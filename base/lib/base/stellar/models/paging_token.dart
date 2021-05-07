class PagingToken {
  final String value;

  PagingToken(this.value);

  int compareTo(PagingToken other){
    this.value.compareTo(other.value)
  }
}
