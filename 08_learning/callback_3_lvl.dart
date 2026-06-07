typedef DownloadHandler = Future<void> Function();

class Dawnloader {
  static void main() {
    startDownload(onFinished: () async {
      print("BLIAT RABOTAJET");
    });
  }

  static void startDownload({required DownloadHandler onFinished}) async {
    print("Загрузка началась...");
    await Future.delayed(const Duration(seconds: 3));
    await onFinished.call();
  }
}
