part of 'pages.dart';

class GetBuku extends StatefulWidget {
  GetBuku({Key? key}) : super(key: key);
  @override
  State<GetBuku> createState() => _GetBukuState();
}

class _GetBukuState extends State<GetBuku> {
var _scaffoldKey = GlobalKey<ScaffoldState>();
  
    Future<List<Buku>> getBuku() async {
    List<Buku> listBuku = [];
    var response = await http.get(Uri.parse(ApiBuku.URL_GET_BUKU));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List listJson = responseBody['data'];
        listJson.forEach((element) {
          listBuku.add(Buku.fromJson(element));
        });
      }
    } else {
      print('Request gagal');
    }
    return listBuku;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Perpustakaan'),
      ),
      body: FutureBuilder(
        future: getBuku(),
        builder: (context, AsyncSnapshot<List<Buku>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              print('ConnectionState.done');
              if (snapshot.hasData) {
                if (snapshot.data!.length > 0) {
                  return buildList(snapshot.data!);
                } else {
                  return Center(child: Text('Tidak ada data'));
                }
              } else {
                print('snapshot error');
                return Center(child: Text('Error'));
              }
              break;
            default:
              print('Undefine Connection');
              return Center(child: Text('Undefine Connection'));
          }
        },
      ),
    );
  }
    Widget buildList(List<Buku> listbuku) {
    return ListView.builder(
      itemCount: listbuku.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        var buku = listbuku[index];
        return Container(
          margin: EdgeInsets.fromLTRB(
            16,
            index == 0 ? 16 : 10,
            16,
            index == 9 ? 16 : 10,
          ),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: Colors.black26,
                ),
              ]),
          child: Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${buku.judulbuku}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Tersedia',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}