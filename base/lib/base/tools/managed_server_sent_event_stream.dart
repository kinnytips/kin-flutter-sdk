import 'package:kin_base/stellarfork/requests/request_builder.dart';
import 'package:sse_client/sse_client.dart';

class ManagedServerSentEventStream<ResponseType> {

  final StreamingProtocol<ResponseType> _requestBuilder ;
  final List<EventListener<ResponseType>> listeners = <EventListener<ResponseType>>[] ;
  SseClient _connection = null;
  ResponseType _lastReceivedResponse = null;
  ResponseTypeEventListener<ResponseType> listener ;

  ManagedServerSentEventStream(this._requestBuilder) {
    listener = ResponseTypeEventListener(this);
  }

  addListener(EventListener<ResponseType> listener) {
    listeners.add(listener);
    if (_lastReceivedResponse != null) {
        listener.onEvent(_lastReceivedResponse);
    }

    connectIfNecessary();
    return this;
  }

  removeListener(EventListener<ResponseType> listener) {
    listeners.remove(listener);
    closeIfNecessary();
    return this;
  }

  bool hasConnection() {
    return _connection != null;
  }

  connectIfNecessary() {

    if(_connection == null && listeners.isNotEmpty) {
      var sseClient = _requestBuilder.stream(listener);
      _connection = sseClient;
    }

  }

  closeIfNecessary() {

    if(_connection == null) {
      if(listeners.isEmpty) {
        // No close, since it's a HTTP client:
        //_connection.close();
        _connection = null;
      }
    }

  }
}

class ResponseTypeEventListener<ResponseType> extends EventListener<ResponseType> {

  ManagedServerSentEventStream<ResponseType> _managedServerSentEventStream ;

  ResponseTypeEventListener(this._managedServerSentEventStream);

  onEvent(ResponseType data){
    _managedServerSentEventStream._lastReceivedResponse = data;
  }
}
