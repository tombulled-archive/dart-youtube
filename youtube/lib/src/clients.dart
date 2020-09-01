import 'dart:io' as io;
// import 'dart:convert' as convert;
// import 'package:html/parser.dart' as parser;
// import 'package:html/dom.dart' as dom;
import 'package:dio/dio.dart' as dio;

import 'exceptions.dart' as exceptions;
import 'utils.dart' as utils;
import 'context.dart' as context;

/*
 * REFERENCES - READ THESE!
 * https://github.com/leptos-null/LeptosMusic/blob/master/music/Models/LMInnerTubeURLBuilder.h --referenced
 * https://github.com/leptos-null/LeptosMusic/blob/master/music/Models/LMVideoItemModule.m
 */

class BaseClient {
    String _name;
    String _version;
    String _apiKey;
    String _userAgent;
    String _originHost;

    String _visitorData;

    context.ApiContext _apiContext;

    dio.Dio _dio;

    Map<String, dynamic> _payloadData = {
        'context': {
            'client': {
                'clientName': null,
                'clientVersion': null,
                'hl': 'en',
                'gl': 'GB',
            },
        },
    };

    BaseClient (context.ClientContext clientContext, [context.ApiContext apiContext]) {
        this._apiContext = apiContext ?? context.ApiContext();

        this._dio = dio.Dio (
            dio.BaseOptions (
                baseUrl: this._apiUrl(['']),
                connectTimeout: 5000,
                receiveTimeout: 5000,
                queryParameters: {
                    'alt': 'json',
                },
                contentType: dio.Headers.jsonContentType,
                responseType: dio.ResponseType.json,
            ),
        );

        this.name = clientContext.clientName;
        this.version = clientContext.clientVersion;
        this.apiKey = clientContext.apiKey;
        this.userAgent = clientContext.userAgent;
        this.originHost = clientContext.originHost;
    }

    String get name => this._name;
    String get version => this._version;
    String get apiKey => this._apiKey;
    String get userAgent => this._userAgent;
    String get visitorData => this._visitorData;
    String get originHost => this._originHost;

    String toString() {
        String class_name = this.runtimeType.toString();

        return '${class_name}(${this.name} v${this.version})';
    }

    void set name(String name) {
        if (name == null) return;

        this._name = name;

        this._payloadData['context']['client']['clientName'] = name;
    }

    void set version(String version) {
        if (version == null) return;

        this._version = version;

        this._payloadData['context']['client']['clientVersion'] = version;
    }

    void set apiKey(String apiKey) {
        if (apiKey == null) return;

        this._apiKey = apiKey;

        this._dio.options.queryParameters['key'] = apiKey;
    }

    void set userAgent(String userAgent) {
        if (userAgent == null) return;

        this._userAgent = userAgent;

        this._dio.options.headers[io.HttpHeaders.userAgentHeader] = userAgent;
    }

    void set visitorData(String visitorData) {
        if (visitorData == null) return;

        this._visitorData = visitorData;

        this._dio.options.headers['X-Goog-Visitor-Id'] = visitorData;
    }

    void set originHost(String originHost) {
        if (originHost == null) return;

        this._originHost = originHost;

        this._dio.options.headers[io.HttpHeaders.refererHeader] = 'https://${originHost}/';
    }

    String _apiUrl([List<String> endpoints]) {
        Uri uri = Uri (
            scheme: 'https',
            host: this._apiContext.host,
            pathSegments: [
                'youtubei',
                'v1',
                ...?endpoints,
            ],
        );

        return uri.toString();
    }

    Future<Map<String, dynamic>> _dispatch (
            String scope,
            {
                Map<String, dynamic> payloadData,
                Map<String, dynamic> queryParameters,
            }) async {
        dio.Response response = await this._dio.post (
            scope,
            data: {
                ...this._payloadData,
                ...?payloadData,
            },
            queryParameters: queryParameters,
        ).catchError (
            (error) {
                switch (error.type) {
                    case dio.DioErrorType.RESPONSE:
                        dio.Response response = error.response;

                        throw exceptions.ApiResponseError('${response.statusCode} - ${response.statusMessage}');
                    default:
                        throw error;
                }
            }
        );

        Map<String, dynamic> data = response.data;

        if (data.containsKey('error')) {
            throw exceptions.ApiError(data['error']);
        }

        if (data.containsKey('responseContext')) {
            Map<String, dynamic> responseContext = data['responseContext'];

            if (responseContext.containsKey('visitorData')) {
                String visitorData = responseContext['visitorData'];

                this.visitorData = visitorData;
            }
        }

        return data;
    }

    Future<Map<String, dynamic>> guide() async {
        return this._dispatch('guide');
    }

    Future<Map<String, dynamic>> config() async {
        return this._dispatch('config');
    }

    Future<Map<String, dynamic>> player([String videoId]) async {
        return this._dispatch (
            'player',
            payloadData: {
                'videoId': videoId,
            },
        );
    }

    Future<Map<String, dynamic>> browse ({
                String browseId,
                String continuation,
                String params,
            }) async {
        return this._dispatch (
            'browse',
            payloadData: utils.filterMap ({
                'browseId': browseId,
                'params': params,
            }),
            queryParameters: utils.filterMap ({
                'continuation': continuation,
                'ctoken': continuation,
            }),
        );
    }

    Future<Map<String, dynamic>> search ({
                String query = '',
                String params,
                String continuation,
            }) async {
        return this._dispatch (
            'search',
            payloadData: utils.filterMap ({
                'query': query,
                'params': params,
            }),
            queryParameters: utils.filterMap ({
                'continuation': continuation,
                'ctoken': continuation,
            }),
        );
    }

    Future<Map<String, dynamic>> next ({
                String params,
                String playerParams,
                String continuation,
                String playlistId,
                String videoId,
                int index,
            }) async {
        return this._dispatch (
            'next',
            payloadData: utils.filterMap ({
                'enablePersistentPlaylistPanel': true,
                'tunerSettingValue': 'AUTOMIX_SETTING_NORMAL',
                'params': params,
                'playlistId': playlistId,
                'videoId': videoId,
                'index': index,
                'continuation': continuation,
                'playerParams': playerParams,
            }),
        );
    }

    Future<Map<String, dynamic>> musicSearchSuggestions([String input = '']) async {
        return this._dispatch (
            'music/get_search_suggestions',
            payloadData: {
                'input': input,
            },
        );
    }

    Future<Map<String, dynamic>> musicGetQueue({String playlistId, List<String> videoIds}) async {
        return this._dispatch (
            'music/get_queue',
            payloadData: {
                'playlistId': playlistId,
                'videoIds': videoIds ?? [null],
            },
        );
    }
}
