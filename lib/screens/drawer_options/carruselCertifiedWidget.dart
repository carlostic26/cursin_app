import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class carruselCertifiedScreen extends StatefulWidget {
  const carruselCertifiedScreen({super.key});

  @override
  State<carruselCertifiedScreen> createState() =>
      _carruselCertifiedScreenState();
}

class _carruselCertifiedScreenState extends State<carruselCertifiedScreen> {
  String cert1_google =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgCL4fwj0YocGblRpvDfgoqIfSPokBV3GthuorPTf8nUdccINVV7ZTurMYvKOmsbLDDFMYBh_w3qaSgF56YHth423P2Fo5kydxesUW32ff3x30dNFra332WXFJO8Ze3yqK61TIY4iDPx3x0Tq4UXjMwd0sg_Mf5xCi5GipxPSdGiZmbrZwMJ49A5Q/w400-h283/Comercio-electronico-min.jpg';
  String cert2_linkedin =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgjr1twZVdlY1iBO3Js6QFX6N4LiBfWFZhBX7SS1adofN8I9cc29Mx4jQK1Kw75qCkQwr0v2CzvnFn0NJY3DqJRVb1SdZjzhD7weB6068jsRWgqz3um2UCc14D-75QcT00C_MgqCCFG9fsnn6mFD-yeaY9oaclHImGy_Eqgr20TC_R14iwuhw1rtQ/w400-h309/1675821542143.png';
  String cert3_slim =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi7I2KCkhaqgKLuDDsQ7_l-XFfR9ptQwqejnKg7_1rWfKDcvIyXQ7wmn4-IeanSYkhu-Msz6aNUw1DA2ltLXbe3jRmIimBnVS2J5zATuhJ61X8EjIL4WmmDgT9l4V0GUgNH9bgZ1WYj9bgHRNZvCMo6m54TRqLEA8ocuRG5FhAxCvonMeJDPYID8w/w400-h310/1679945095.webp';
  String cert4_microsoft =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgSkc0y-2FeLVCyi4rgp0V4CX6wWbXPXUD6LTnQYJ2eIaG2t0ia81vYHIDYQrFgk5DrxRefQ6epWx_TTE5xsR8FgbGKEpM0_g7bBHWEsrJeRcs0lZtzTRII6rOsJaSq-eoQp7-_MxuiekQIWlZsJqWH43AXREHtK_jS45FUm4DtyJNtd2KrWePrnw/w400-h261/Microsoft%20Certified%20Azure%20Architect%20Expert.png';
  String cert5_hp =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgmtTRTcuxWM-1VSRT_oqtLiJu74JqQq_EQ0R84n5A6I3eyo_5QUI9VssBL13Za0WymaqI8ywmrcSL0lx5q3UR5IOvfPmMDod2OzsWGvc_f2zVW7sA3ksdj7pCChtXx3pQkx3X_7dhyjkChuaCT0m5cvJg7WMgybxmW2mhPCQY8w4FfVTmBWjrFAA/w400-h283/p1.jpg';
  String cert6_cognitive =
      'https://blogger.googleusercontent.com/img/a/AVvXsEgFk489twXrZ8AdNyCnvEV_c55Voq8m8zVZ-f1cNLcDIuaPvDa2bFD2ZisRHSfKEY2nWw25yNYSbrPWW8fkR7j7mbAAU-i6c_G99BpweQAM9gP9BJ9-seN90duYwa6J3WxgGrCQka682j8fQnxIB-whsTOjGfOoWIga2qlmrmbbobAgNRkp1SXCEA=w400-h248';
  String cert7_cisco =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgEui1Ck10AWun-D6hfY52MWMg77c0538GHW-T-7Cr7QO5mlx0FPYDJ8_32w6ixBjxjQRC2b1qjDs5YyxqXbiOj5quvOu8P7zJHhTTRUzVJ8XX9AsGxo-bcCOLS0_XKuMMiOCKi94oHuT4oyBnJsIih4HHN-3KE2WPzxIo_riXkao88OtxG3H8ffg/w400-h300/EfO76ckX0AEzadm.jpg';
  String cert8_onu =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh3ZSByqbws2XXgSCGkpofR0aYBmp-Q1YHmY1MoCXPMCcbJzUPpbb3WTYmOj3n5RYeRTnFbL3CeHZ_gt75vs-rPq5_hPkVh4X7H9TXd4xGtG1ZnaHCL6vzQ3Tr118l5EAKlD4vRvVnMs_mYg8WjWL8Kr-PgVt6_g7JDxTjrvL_o14vaKIYV7lKMOA/w400-h291/DSkxnY6VAAEnCpR.jpg';
  String cert9_ibm =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi9kevMAmisH7vkonyK76uXx_XG09L8DJ2FBDtEWGgw9OywsGlkOvy57L-mZt1_YAwlZB0Qy_hQS9DpEbtxcOGm5CejUI2dcmSrXXEMksJp78htpT57ORb6orsfbPoz0yycDHtYq_rDz7H4A1eRZoYIuN5KhGpaCHetEH4IwrPUxtPXj5xBIjwEJQ/w400-h264/1605167899868.jpg';
  String cert10_unicef =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiagh-9QfGroOBMwfqQl5zdcvVWU6XWOuDRBPJX8MJUDeFXJsZkElThRHNUEuBOmhQlTKiY7l3vKMwst95A8iLfPErVPr5hawP8Cm_RDmfRNBSyoBEKdts8vCRwWNCMiD_yx1E4-mp3mxXRxM05vVkUAQwATyH9GM1tIAaWb6rGQwg3IL1U9fsvGQ/s320/unicef.webp';
  String cert11_openbootcamp =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhoSKJk_Eeqe3OeHCwI2_mLTKg1UZFd1F04IPCM1qF19x-nL4UF-poKgI4PbQ7w_yYbg4vrBjba4I2_uAUda5AC23SKUEgCCZXl4GrW7iW_m_DyEpJQMka8IGAOyHxUbhsUV0QT5PUvuCeOwhq1skUm3P0TOwDGi6fLw5plQx_qAMDKL3s2MFTSjg/s320/openBootCamp.png';
  String cert12_intel =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhOskR9RwNSOC0qCRm-Pp81LZGOZMJYMXGLiNf87yl18p2FW42FRQzVLQDBa_l2ZZVHHurLPwMt0uz3y0DNZj1NfEl8IM1Pxn_2hDH0AQtjgkyJZ4hfvXCLw4QLJMk5HGpZ_FX8NFZ8_ZOQ0UwXmSsx0JKkj72CKbzM86-ksZMh-TvmMSQtJhfKQg/s320/intel.webp';
  String cert13_freecodecamp =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFtX1-NXofu2m6EYZQLfGgukbUt9_US4i0AgdG4yswKLH5tj2DrD9L3FO2tvJKW0wK2YDqM1bBb-GGznarZmvg8Z9jNjFrgWHo9ch6D7qShx-EfHkMgCM_L14rUMfzazAlEtChGykX7jPvLkJRU2Mkq1r6YQ4UruhrIN0K8h79Be6_ZCecHRfHPw/s320/FreeCoodeCamp.png';
  String cert14_efset =
      'https://blogger.googleusercontent.com/img/a/AVvXsEjwe6Y_dO0y_U1JGtC32kynzgR9_ibg1kxoWtZkP7jZcYvxYiFvsW-e-eZQa43N60FgLeZ1bKOvpRnJI6YdnmK0oh0E7yov1PqcipNLEH99ezL6jTc3i3X3KiR5kKeS7W4wwDnjNNiHeu2Jju1n13osUTUlpAY9rdYZx6KvgHh_-EWj_wGAmToZIA=w338-h298';

  int _currentAviso = 0;
  @override
  Widget build(BuildContext context) {
    double widthCertifiedImage = 500;
    List<Widget> _certificados = [
      Container(
        child: CachedNetworkImage(
          imageUrl: cert1_google,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert2_linkedin,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert3_slim,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert4_microsoft,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert5_hp,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert6_cognitive,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert7_cisco,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert8_onu,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert9_ibm,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert10_unicef,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert11_openbootcamp,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert12_intel,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert13_freecodecamp,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert14_efset,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.30,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: CarouselSlider(
                items: _certificados,
                options: CarouselOptions(
                  //height: MediaQuery.of(context).size.height * 0.30,
                  autoPlayInterval: const Duration(seconds: 2),
                  enableInfiniteScroll: false,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.99,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentAviso = index;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicators(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicators() {
    List<Widget> indicators = [];
    //number of images
    for (int i = 0; i < 14; i++) {
      indicators.add(Container(
        width: 7.0,
        height: 7.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentAviso == i ? Colors.green : Colors.grey,
        ),
      ));
    }
    return indicators;
  }
}
