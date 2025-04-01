import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Home Page'),
          Button(
              onPressed: () {
                context.push('/about');
              },
              child: const Text('关于'))
        ],
      ),
    );
  }
}
