// import 'package:youtube/youtube.dart' as youtube;

// import 'package:youtube/src/exceptions.dart' as exceptions;
// import 'package:youtube/src/constants.dart' as constants;
// import 'package:youtube/src/utils.dart' as utils;
import 'package:youtube/src/clients.dart' as clients;
import 'package:youtube/src/context.dart' as context;

void main() async {
    context.ClientContext clientContext = context.getClientContext (
        service: context.Service.YouTubeMusic,
        device: context.Device.Android,
    );
    clients.BaseClient client = clients.BaseClient(clientContext = clientContext);

    print(await client.musicSearchSuggestions('foo'));
}
