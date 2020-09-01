enum Device {
    Android,
    Ios,
    Web,
}

enum Service {
    YouTube,
    YouTubeMusic,
    YouTubeKids,
}

class ApiContext {
    String host;
    String collection;
    String version;

    ApiContext ({
        this.host = 'youtubei.googleapis.com',
        this.collection = 'youtubei',
        this.version = 'v1',
    });
}

class ClientContext {
    String clientName;
    String clientVersion;
    String userAgent;
    String apiKey;
    String host;
    String originHost;

    ClientContext ({
        this.clientName,
        this.clientVersion,
        this.userAgent,
        this.apiKey,
        this.host,
        this.originHost,
    });
}

Map<Service, Map<Device, ClientContext>> ClientContexts = {
    Service.YouTube: {
        Device.Web: ClientContext (
            clientName: 'WEB',
            clientVersion: '2.20200516.07.00',
            userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101 Firefox/77.0',
            apiKey: 'AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8',
            originHost: 'www.youtube.com',
        ),
        Device.Ios: ClientContext (
            clientName: 'IOS',
            clientVersion: '15.19.4',
            userAgent: 'com.google.ios.youtube/15.19.4 (iPhone10,5; U; CPU iOS 13_4_1 like Mac OS X; en_GB)',
            apiKey: 'AIzaSyB-63vPrdThhKuerbB2N_l7Kwwcxj6yUAc',
            originHost: 'www.youtube.com',
        ),
        Device.Android: ClientContext (
            clientName: 'ANDROID',
            clientVersion: '15.19.34',
            userAgent: 'com.google.ios.youtube/15.19.34 (iPhone10,5; U; CPU iOS 13_4_1 like Mac OS X; en_GB)',
            apiKey: 'AIzaSyA8eiZmM1FaDVjRy-df2KTyQ_vz_yYM39w',
            originHost: 'www.youtube.com',
        ),
    },
    Service.YouTubeMusic: {
        Device.Web: ClientContext (
            clientName: 'WEB_REMIX',
            clientVersion: '0.1',
            userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101 Firefox/77.0',
            apiKey: 'AIzaSyC9XL3ZjWddXya6X74dJoCTL-WEYFDNX30',
            originHost: 'music.youtube.com',
        ),
        Device.Ios: ClientContext (
            clientName: 'IOS_MUSIC',
            clientVersion: '3.65.3',
            userAgent: 'com.google.ios.youtubemusic/3.65.3 (iPhone10,5; U; CPU iOS 13_4_1 like Mac OS X; en_GB)',
            apiKey: 'AIzaSyDK3iBpDP9nHVTk2qL73FLJICfOC3c51Og',
            originHost: 'music.youtube.com',
        ),
        Device.Android: ClientContext (
            clientName: 'ANDROID_MUSIC',
            clientVersion: '3.65.58',
            userAgent: 'com.google.android.apps.youtube.music/3.65.58 (Linux; U; Android 5.1.1; en_UK; SM-G930K Build/NRD90M)',
            apiKey: 'AIzaSyCbNu0kKlAVm5mL6m4NUEgCUl0NR3nPqLs',
            originHost: 'music.youtube.com',
        ),
    },
    Service.YouTubeKids: {
        Device.Web: ClientContext (
            clientName: 'WEB_KIDS',
            clientVersion: '2.1.1',
            userAgent: 'Mozilla/5.0 (X11; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0',
            apiKey: 'AIzaSyBbZV_fZ3an51sF-mvs5w37OqqbsTOzwtU',
            originHost: 'www.youtubekids.com',
        ),
        Device.Ios: ClientContext (
            clientName: 'IOS_KIDS',
            clientVersion: '5.29.1',
            userAgent: 'com.google.ios.youtubekids/5.29.1 (iPhone10,5; U; CPU iOS 13_6_1 like Mac OS X; en_GB)',
            apiKey: 'AIzaSyA6_JWXwHaVBQnoutCv1-GvV97-rJ949Bc',
            originHost: 'www.youtubekids.com',
        ),
        Device.Android: ClientContext (
            clientName: 'ANDROID_KIDS',
            clientVersion: '5.28.2',
            userAgent: 'com.google.android.apps.youtube.kids/5.28.2 (Linux; U; Android 6.0; en_US; Google Nexus 5 Build/MRA58K)',
            apiKey: 'AIzaSyAxxQKWYcEX8jHlflLt2Qcbb-rlolzBhhk',
            originHost: 'www.youtubekids.com',
        ),
    },
};

ClientContext getClientContext({Service service, Device device}) {
    return ClientContexts[service][device];
}
