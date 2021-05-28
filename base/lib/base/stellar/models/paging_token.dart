class PagingToken {
  final String value;

  PagingToken(this.value);

  int compareTo(PagingToken other) {
    return this.value.compareTo(other.value);
  }
}
