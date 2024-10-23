import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TestView(),
    );
  }
}

class TestView extends ConsumerWidget {
  final counterProvider = StateNotifierProvider((ref) => Counter());

  TestView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    ref.listen(counterProvider, (prev, next) {
      print('State changed: $prev, $next');
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Count: $count',
            ),
            TextButton(
              onPressed: () {
                ref.watch(counterProvider.notifier).increment();
              },
              child: const Text(
                'Increment',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
}
