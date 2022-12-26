import 'package:islam_made_easy/views/QnA/qna.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  Future<LottieComposition>? _composition;

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();
  }

  Future<LottieComposition> _loadComposition() async {
    var data = await rootBundle.load('assets/lottie/please-wait-loading.json');
    return await LottieComposition.fromByteData(data);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<LottieComposition>(
        future: _composition,
        builder: (context, snapshot) {
          var composition = snapshot.data;
          if (composition != null) return Lottie(composition: composition);
          // To avoid errors on web where there is low network connection return CPI
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(.05),
              semanticsLabel: 'Loading...',
              strokeWidth: 1,
            ),
          );
        },
      ),
    );
  }
}
