class GetContentTypeFromQrFormType {
  GetContentTypeFromQrFormType._();

  static String getContentType(String qrFormType) {
    final splitted = qrFormType.split('.');
    return splitted.last;
  }
}
