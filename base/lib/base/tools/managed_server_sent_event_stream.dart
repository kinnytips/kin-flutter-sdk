import 'package:kin_base/stellarfork/requests/request_builder.dart';
import 'package:sse/server/sse_handler.dart';

class ManagedServerSentEventStream<ResponseType> {
  ManagedServerSentEventStream(StreamingProtocol<ResponseType> requestBuilder);

  var _lock;
  List<EventListener<ResponseType>> listeners;
  SseConnection _connection = null; 
  ResponseType _lastReceivedResponse = null;
  var listener = ResponseTypeEventListener();

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
    synchronized(_lock) {
      if(_connection == null && listeners.isNotEmpty()) {
        _connection = requestBuilder.stream(listener);
      }
    }
  }

  closeIfNecessary() {
    synchronized(_lock) {
      if(_connection == null) {
        if(listeners.isEmpty()) {
          _connection.close();
          connection = null;
        }
      }
    }
  }
}

class ResponseTypeEventListener implements EventListener<ResponseType> {
  onEvent(ResponseType data){
    synchronized(_lock) {
      _lastReceivedResp
    }
  }
}
