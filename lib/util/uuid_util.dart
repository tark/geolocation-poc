String shortUuid(String? uuid) {
  if (uuid == null || uuid.isEmpty || uuid.length < 8) {
    return '';
  }

  return '${uuid.substring(0, 4)}...${uuid.substring(uuid.length - 4)}';
}
