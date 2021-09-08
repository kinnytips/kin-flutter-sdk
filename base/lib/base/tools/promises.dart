
class PromisedCallback<T>{
  void Function(T value)  onSuccess ;
  void Function(Error error)? onError ;

  PromisedCallback(this.onSuccess, [this.onError]) {
    this.onError ??= (err) => throw err ;
  }

  void success(T value) => onSuccess(value) ;
  void error(Error error) => onError!(error) ;
}
