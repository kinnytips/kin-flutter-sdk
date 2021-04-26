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
    _lastReceivedResponse
      ..{ listener.onEvent(this) };
  }
}

class ResponseTypeEventListener implements EventListener<ResponseType> {
  onEvent(ResponseType data){
                // listeners.indices
                // .asSequence()
                // .map { listeners[it] }
                // .forEach { it.onEvent(data) }
  }
}

typedef T LetCallback<T>(T value);

T let<T>(T value, LetCallback<T> cb) {
  if (value != null) {
    return cb(value);
  }
}