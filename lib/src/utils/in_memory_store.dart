import 'package:rxdart/subjects.dart';

/// An in-memory store backed by BehaviourSubject that can be used to
/// store the data for add fake repositories in the app
class InMemoryStore<T> {
  InMemoryStore(T initial) : _subject = BehaviorSubject.seeded(initial);

  /// the behaviour subject that holds the data
  final BehaviorSubject<T> _subject;

  /// the output stream that can be used to listen the data
  Stream<T> get stream => _subject.stream;

  /// a syncronous getter of current value
  T get value => _subject.value;

  /// a setter for updating the value
  set value(T value) => _subject.add(value);

  /// do not forget to call this when done
  void close() => _subject.close();
}
