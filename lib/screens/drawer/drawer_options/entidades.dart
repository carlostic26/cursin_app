import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../screens.dart';
import '../../../utils/ads_ids/ads.dart';

class EntidadesScreen extends StatefulWidget {
  EntidadesScreen({required this.darkTheme});
  late bool? darkTheme;

  @override
  State<EntidadesScreen> createState() => _EntidadesScreenState();
}

class _EntidadesScreenState extends State<EntidadesScreen> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  Color darkColor = Colors.grey[850]!;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAdaptativeAd();
  }

  Future<void> _loadAdaptativeAd() async {
    CursinAdsIds cursinAds = CursinAdsIds();
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      // TODO: replace these test ad units with your own ad unit.
      adUnitId: cursinAds.banner_adUnitId,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  final List<String> imageList = [
    // IMB
    'https://blogger.googleusercontent.com/img/a/AVvXsEhAX2hgXADX14BrApmX2KU7ESFUaUbuSp3CUsUZbs5jXVHf8SeDykHhlwfxzbCdbcp7JyodOOjVr-kMdkpiluJGwcF8OMSj0G3HLkk0Cu11CRtzgoZPyz70OPrmA4fN0E12siyTrRV1sVp06MSCNYpLoNZs0lcSusDM5kuGTGlXuVkUS5YxIL1A8W2f',
    // Google
    'https://blogger.googleusercontent.com/img/a/AVvXsEhJdFrbecPqDupeg2e_d3S1ibLOALLSLAPoKZM9gxDlLNacKRT-4T3TvrgUGKhd_wzQbJi_5JTQJKjUgyYTvhfFfDf8slJ-Gq7C2DjrE1YJ44NWq2MIQIXWKVbXpNof4iXkyYZN8cQRabBTAJk3HopEQ_u7ebIWUxlRSrzl1-imA-dxIvXtdQbSRfwp',
    // Microsoft
    'https://blogger.googleusercontent.com/img/a/AVvXsEjQ1XcxBINP-l34jSPXl5y-UT8GSBCNLE090ujYXidRgVs9w_IEq0gagsU4e-9_qS5v3QkwkaJWWaHbYqqC8lv5KuOVrOjExq8Xkl_7HSWx3f_7AylQ61kMAU4ZUHlZajj6KjuiEk7L0IWGNujIZRstu1mjJ6cj0QrmzGsc2k896zDXMeTUWdlNWjHB',
    // Cisco
    'https://blogger.googleusercontent.com/img/a/AVvXsEgB9-r6b5OtOQEUueT9Bd0m0qzFjbCAIKgLNudTE6-3MpEhfJRL2CBT5W0NKiiUnfPNdcY3q0mebj7A7_WfmKJbazkNwEndg0A7NGmU8pwHzP1OrmZbt2gBjA7e_SBGaMOoIyn1dq6nfvk92kSYj6o3fNE4kRQZLzDwzYQ-Q7_BTNdcnlwRgFMtEieD',
    // Meta
    'https://blogger.googleusercontent.com/img/a/AVvXsEiv3lHCIMJtccvq2dKcQPe-H3ZRLlsJbdgumMyx6m3warLimmwb80rF182hLX4aHJJ-jZEgpC-cJnmmoz26ZpxXUFvIjl7wuyPLBTo5tfJRqIlRb2atcwTGvwuhqMCn0x_FDq9lafyyzMr6G9Wxqzed4W3OZrCk5HAATwo97oyLXcpaLllDWsOX86Yu',
    // Intel
    'https://blogger.googleusercontent.com/img/a/AVvXsEgQ35BrcdN1VQ-nYJbQaY36PegZ3R1Pmvxl1p7CNtK70CfjR4kBnKoNZiSUJVqqPsUyoyqAl1vNxb6FOswOxHShfJK8yHBc0X5IO4PPkjjk3hedHeLZiviHPy2qtxucGc_ZZ3c8HfvUdCELrD-cE0uaTDwWFtdB-GzX8THJPpYRusKVuS653zxQiSE8',
    // Capacitate
    'https://blogger.googleusercontent.com/img/a/AVvXsEhP7igMN4VX0nAse8g95DT-kspi_PJvuDNHcsPS6zN6fDc4bptgndMOLceXdrFZnAdOQYjdJI6Q2eqacIiIGVvE9TqSHDFHpCaykGa4gpWWoKH4q09qvAc64W0EX2jBzL7-XfzaCo6CwpmAi5rxqxoMxenlRz8iUXugT-5a0_XluSfjsZfUdrRjpHkZ',
    // Kaggle
    'https://blogger.googleusercontent.com/img/a/AVvXsEjs83M87PzH3z3VI0HIE2oAgegADuPaVS4BLdZvUO5mvTh4lWm1RqvD561V0OGPZMUWAuvAneDaA1dfT2yU4BDRS3TfJO7La_Cp-Fr5aad8zm0tUord0dQNxkIDKGkQjowog6gvS_FvcdzfNjd0Vt0RWbFsZpQ4WpCXRGv1eUAHkWukL6XNxNJ43PUi',
    // Teachlr
    'https://blogger.googleusercontent.com/img/a/AVvXsEjoDeoMfrbn-bfNK9LUUUsgt-4ArEr8sbmZLP1ud328mIZRi9wwhvNaG59KXHsOE6ZNFVvFFegn9Yj5Bhrb04J7BO7yLViuiA04W7SQ4UHMNnj26mbkfBqE3rru9IhiRlPma_MoLBh8DVdbZvJd3tF88xVJrfClzaOHU9vl24Qb4xBIPnRbdZer7eCm',
    // Matlab
    'https://blogger.googleusercontent.com/img/a/AVvXsEhXpsR_JuQOC_Uwb4DoiZ43UqMy1rSbkABLFVnWmLGt5rHz1cEtWwtFIevz8hAz7zEpNhOIy9FsJxfELWD7spuu-lmRCCPO9XAeWML1kGmQg8uA3FFOep5d-c6Dl9__H-fCW8gaPVsbYhqcBwGGH49BDnJUkq-hZ41H8VJnizxvZUU6rO4HD1x-itvs',
    // ONU
    'https://blogger.googleusercontent.com/img/a/AVvXsEgO7dy6P_qh28rczlOf7aEcpz96lOdBbRqGR1DsXrr4-u-RlY5qNeztSqWa6Mctd6qHogQyF-9Ue3kYP6VtiPclz_3wuL5uHfsIVFwjd8MeZWimLcNJ_AlfEIzH-g7WyFV7AdGHwHtWbiqT98aEK9RSBnc0QMVetwjUkPKQ4ThC8iTrUmMHdXJrc34G',
    // UNICEF
    'https://blogger.googleusercontent.com/img/a/AVvXsEjT01M0AcN9uc9Ma3jS2LKhON3Rfe3tWDgJiKV_-yoTW7BNs89jN-bmNqP6ye3HP-T0Q9tTKJkX5F_0YDNQ4IZhMlYkvHOfqWW3LeTq0-cLBEX1bCEfcFat9C2UdIFqx-njrIhGZUI2Xkvemc4cTp5EBNiqEN7p04AiuZldFp3MZrOz36sfqEMKVdlq',
    // Sololearn
    'https://blogger.googleusercontent.com/img/a/AVvXsEhCkBRIysVdRXujlstu9N_70tkKy5w-ksxtOW-hUcr1KeEPpxfwZdDkIv1OvVvAk2D8vdqeFmH-rNzq5aIFUN6pmFPZ6ttL2ojDhXH6kXnt6DoD2i2FDG010b7kcRpGruQkkEBQXjzexgVGl8lGjLNcy8NQy3bVkk57F85OKtn8vkeBuXb8Bo9Ukyta',
    // FreeCodeCamp
    'https://blogger.googleusercontent.com/img/a/AVvXsEjainDQUYUs58kIyawFcg2g32I-JK0TWDetizA3OOC-8HvH2sc-rxQE1qxkfbhnrxQiZZlIp3PRuj7MJ2iubrV9Bd6BGwtETB-ORdxRW-Qibka2wECaedEQmHhW4ujpqi-0aFNLYWA90mrufOP_miqKGBrZ-WxXU_RRyxQR8sy3NKLaVRe59dP1HUIJ',
    // Turingo
    'https://blogger.googleusercontent.com/img/a/AVvXsEgKdk35HWnFd6jg0rKcrmdSQr98U8Ozmt5QHhjZynAwiX5KoYxsKZHW_Apx6UrLk1Of6_MqrrFcC9Mh8kkOO-TjeWNmHhqNDtWJM3GbpHBCU1ukmFnlegmALAHqIki-5lmrm9C5gZpQ4Llzd3-wXUaXpGVClFZBMP35LsboaTuasSCSNW4J7TZzAdc3',
    // Hubspot
    'https://blogger.googleusercontent.com/img/a/AVvXsEgUmxqR2qVkXHrhhzAyqgxyt3aWzspiN9BFOtbHpK1XJ5a70KHVyV18V_wongcAMBoE_bH8EEPRKruzjkXWqbmtyVW_JdKoGPVITmK1IkFrbGdKwTGLgLrGCAPKKJSrKU69IfW6TfygXufZQ1fmpPrw0cEqi5O9FhPorYrlH725OjCIiLs99kfFSa9N',
    // HP
    'https://blogger.googleusercontent.com/img/a/AVvXsEieuIkUMvUW1JuAyiaMWT5oreFUXkLt-6-UZ14YWofg_1-X_SteW-ynP3YHdsh0rUManDQawEHFLYavcakdA10LIVi6zIeJDKuCtYAIR9gn0w8N6rY4kO_qLaZv9U_LuV_sOGwrH2GJeCkVo8NOlLWHRFE5yDwJxF4-bWAbAv7SmdqJO9K-CKqx247K',
    // Linkedin
    'https://blogger.googleusercontent.com/img/a/AVvXsEhudYiEtm_AZYi6y0y8SrWT7Xk6ch9aNSpdao2U-MLIUmYB9HWw398x2nsuT4REBQB2AdBWdj45iG3fo_yeGYqDwk9yhiEzK4JPedQ4_e_0Y5vHVXemXSvFZtpY3X0YZt3DzDAKmzn3Lg-dRXMqgz8IlVPqKXoZB66iGpE3jwQoOP-NXDG3G7vJhqw2',
    // Future Learn
    'https://blogger.googleusercontent.com/img/a/AVvXsEh52HR8xV8Ltv3pXxRYmgbZLkjvzr2Yv2fBR_7sTHt4D2NrduT-wSUcL0YExePDu1DpsjNmInR7iKcMkDTr-LXcszl0a0ej_5vPrnJNKEQcQGdZ4StOo2nbPtX1IYnDVXJHAEY-1EzcOJkLBlgjOwtn_U0wbfVsSuHSHnpwGE1bxkwROuP-eJcHxUS5',
    // SkillShop
    'https://blogger.googleusercontent.com/img/a/AVvXsEiFooIYGlAr7imLRXyXq0vKUdpl43BLwzlfcONVMNc1e9Re6_wG59pIbFZ-oqE2prXo3cE_rr01m-It7fkruMMBOSDyC6Fq9pEQGpRRC0c157nPpwwamd-6ioclwGHvtmDHxXUiSAoLpMiYMGDiBOtyDd4xPcvLazw-NpPn73w7IvN61fD-Bch1Tx_X',
    // Odin Project
    'https://blogger.googleusercontent.com/img/a/AVvXsEhQB6ff2w3_K0IzNZPXbYswnvoURX5rH7ohl_F3VX05BJyTCa0GOIebkzW2_uKQTTu8wU_I0QZkf3Pj169ec4gRYCjFn5UFFRwSBK3RVKRfADD2cFQ1F9z7ZimSnlrQLBkCxqcUhggIRiCkbBOi2R3flBm3mea8Vd9LVS_NVHGwUf4TGmpbk9Zi-fvx',
    // Cognitive Class
    'https://blogger.googleusercontent.com/img/a/AVvXsEhKbRG_liPMHUz8jj7C60kzhpKV4Cw0vEolIsHGoReIPL-NrT0A5NRIkT-A-Q1yfGWr5jwvGpp9Q35UsaE-KOOEOYZr7tkVeAmnc-5wa01WOyWcXrLkDwcNovQAD4YM3STBMZpxai7dH2OPGo2KDeZ8AZny8wBkK7IwSxC_72Kv7sEd-LPDF909EAR5',
    // GSMA
    'https://blogger.googleusercontent.com/img/a/AVvXsEggU6gfc6RsAFJ-MuZFD2mASEY46blYUNl_gRE-UrWUZ76fMsW3knCJhM_4M1YRp4vYHt4U3iqezArRqWIYkL9c3fL1CleAqwq2f1yif9sN6EqKPDNeRLzFqZn0jaTWfubLxF05b7Uz2GHwoSAmPw_s3b2BW-jdZB2WICtYdD2J7Pz2s2W48KHbAjnV',
    // EFSET
    'https://blogger.googleusercontent.com/img/a/AVvXsEjLF4bV3pfQRUaIZDz0CKzQ_ehjDoQw1e8iRcT8xyaLtI8EmwUo5yNNSYtASecQB8pLa3ibmPT1lU4MhzZkxvBPNCvQgAA5WVVVV8OiVDmSsyatewag6TdflBUGtCfShtAg5tjnVbqYuT4lQZE_01FgINJ_HvEzQe_abJd3oWtRSOWTd7rg9zsjkrvm',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.darkTheme == true ? darkColor : Colors.white,
      appBar: AppBar(
        title: Text('Entidades'),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //pass to search screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => searchedCourses(
                      catProviene: 'sinCategoria',
                      puntoPartida: 'home',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 30, 0, 0),
              child: GridView.builder(
                itemCount: imageList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      print('Tocaste la imagen ${index + 1}');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      margin: EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                          imageUrl: imageList[index],
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: 200, // Ajusta la altura del degradado según tus necesidades
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  darkColor, // Color oscuro en la parte superior
                  Colors.transparent, // Transparente en la parte inferior
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Estas son las plataformas, empresas y entidades que ofrecen los cursos gratis con certificado que puedes encontrar dentro de Cursin App.\nCreditos a cada una de ellas.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      //ad banner bottom screen
      bottomNavigationBar: _anchoredAdaptiveAd != null && _isLoaded
          ? Container(
              color: Color.fromARGB(0, 33, 149, 243),
              width: _anchoredAdaptiveAd?.size.width.toDouble(),
              height: _anchoredAdaptiveAd?.size.height.toDouble(),
              child: AdWidget(ad: _anchoredAdaptiveAd!),
            )
          : Container(
              color: Color.fromARGB(0, 33, 149, 243),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
            ),
    );
  }
}
