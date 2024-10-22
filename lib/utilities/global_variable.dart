import 'dart:io';

const webScreenSize = 600;
final appDownloadLink = 'https://netuni.page.link/app';
//live ad unit id
final adUnitId = Platform.isAndroid
    ? 'ca-app-pub-5526351581228684/8819614202'
    : 'ca-app-pub-5526351581228684/2774770327';

final adUnitId_reward = Platform.isAndroid
    ? 'ca-app-pub-5526351581228684/5034328157'
    : 'ca-app-pub-5526351581228684/7595298226';

//test ad unit id
// final adUnitId = Platform.isAndroid
//     ? 'ca-app-pub-3940256099942544/6300978111'
//     : 'ca-app-pub-3940256099942544/2934735716';
// final adUnitId_reward = Platform.isAndroid
//     ? 'ca-app-pub-3940256099942544/5224354917'
//     : 'ca-app-pub-3940256099942544/1712485313';
//const String google_map = "AIzaSyDc4ZtQGvLb0u251m1Zyd16kgpd6sGqDrQ";

//FOR SHARING CONTENT status
// final result = await Share.shareXFiles(['${directory.path}/image.jpg'], text: 'Great picture');
//
// if (result.status == ShareResultStatus.success) {
// print('Thank you for sharing the picture!');
// }
// final result = await Share.shareXFiles(['${directory.path}/image1.jpg', '${directory.path}/image2.jpg']);
//
// if (result.status == ShareResultStatus.dismissed) {
// print('Did you not like the pictures?');
// }