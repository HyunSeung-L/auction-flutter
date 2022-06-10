
import 'package:auction/provider/auctions_provider.dart';
import 'package:auction/utilities/widget_utils.dart';
import 'package:auction/widgets/main_page.dart';
import 'package:auction/pages/register_auction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Provider Test",
        home: MyHomePage(title: '경매식 중고거래 앱'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetUtils.init(context);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Auctions>(create: (_) => Auctions()),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: const MainPageWidget(),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.short_text_rounded),
                label: "TBD1"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                label: "TBD2"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_right),
                label: "TBD3"
              ),
            ],
          )   ,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (ctx) => const MakeAuctionPage()
                )
              );
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        )
    );
  }
}
