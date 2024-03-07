import 'package:flutter/material.dart';
import 'package:kisiler_uygulamasi/KisiDetaySayfa.dart';
import 'package:kisiler_uygulamasi/KisiKayitSayfa.dart';
import 'package:kisiler_uygulamasi/Kisiler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {

  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  Future<List<Kisiler>> tumKisileriGoster() async {
    var kisilerListesi = <Kisiler>[];

    var k1 = Kisiler(1, "Ahmet", "999999");
    var k2 = Kisiler(2, "Mehmet", "111111");
    var k3 = Kisiler(3, "Zeynep", "222222");

    kisilerListesi.add(k1);
    kisilerListesi.add(k2);
    kisilerListesi.add(k3);

    return kisilerListesi;


  }

  Future<void> sil(int kisi_id) async {
    print("$kisi_id silindi");
    setState((){
    });
  }




  @override
  State<Anasayfa> createState() => _AnasayfaState();

}

class _AnasayfaState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: aramaYapiliyorMu ?
            TextField(
              decoration: InputDecoration(hintText: "Arama için birşey yazın"),
              onChanged: (aramaSonucu){
                print("Arama sonucu : $aramaSonucu");
                setState(() {
                  aramaKelimesi = aramaSonucu;
                });
              },
            )
            : Text("Kişiler Uygulaması"),
        actions: [
          aramaYapiliyorMu ?
      IconButton(
      icon: Icon(Icons.cancel),
      onPressed: (){
        setState(() {
          aramaYapiliyorMu = false;
          aramaKelimesi = "";
        });
      },
    ),
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                aramaYapiliyorMu = true;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Kisiler>>(
        future:  widget.tumKisileriGoster(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var kisilerListesi = snapshot.data;
            return ListView.builder(
              itemCount: kisilerListesi!.length,
              itemBuilder: (context,indeks){
                var kisi = kisilerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => KisiDetaySayfa()));
                  },
                  child: Card(
                    child: SizedBox(height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(kisi.kisi_ad,style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(kisi.kisi_tel),
                          IconButton(
                            icon: Icon(Icons.delete,color: Colors.black54,),
                            onPressed: (){
                              sil(kisi.kisi_ad);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }else {
            return Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => KisiKayitSayfa()));
        },
        tooltip: 'Kişi Ekle',
        child: const Icon(Icons.add),
      ),
    );
  }
}
