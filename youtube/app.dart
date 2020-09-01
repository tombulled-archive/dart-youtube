// import 'package:youtube/youtube.dart' as youtube;

// import 'package:youtube/src/exceptions.dart' as exceptions;
// import 'package:youtube/src/constants.dart' as constants;
// import 'package:youtube/src/utils.dart' as utils;
// import 'package:youtube/src/context.dart' as context;
import 'package:youtube/src/clients.dart' as clients;

void main() async {
    clients.YouTubeKidsWebClient client = clients.YouTubeKidsWebClient();

    print(await client.getKidsFlowData());
}
