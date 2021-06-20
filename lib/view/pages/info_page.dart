import 'package:covid_prediction_app_ios/utils/constants.dart';
import 'package:covid_prediction_app_ios/utils/strings.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_back_button.dart';
import 'package:covid_prediction_app_ios/view/widgets/ios_button.dart';
import 'package:covid_prediction_app_ios/viewmodels/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:covid_prediction_app_ios/view/view_helper.dart';
import 'package:url_launcher/url_launcher.dart';



class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  //TableViewModel _viewModel;
  AppTheme _appTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_viewModel = Provider.of<TableViewModel>(context);
    //_appTheme = Provider.of<AppTheme>(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// * * * * * APP BAR * * * * *
      appBar: AppBar(
        title: Text(
          Strings.covidInfo,

          style: TextStyle(
            color: Colors.black,//_appTheme.colors.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor:  Color(0xfff4f4f4),//_appTheme.colors.gray,
        leading: IosBackButton(
          onPressed: () => Navigator.of(context).pop(),
          //iconColor: _appTheme.colors.accent,
          iconColor: Colors.blueAccent,
        ),
      ),

      /// * * * * * BODY * * * * *
      body: Container(
        color:  Color(0xfff4f4f4),//_appTheme.colors.gray,
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            Constants.screenPadding,
            0,
            Constants.screenPadding,
            Constants.screenPadding,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[






              Text(
                "Basic rules against coronavirus:",
                textAlign: TextAlign.center,
                style:TextStyle(
                  color: new Color(0xFF0D47A1),
                  fontWeight:FontWeight.bold,
                  fontSize: 20.0,
                  //backgroundColor: new Color(0xFFFF7043)
                ),
              ),

              Container(
                  child:ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20.0),
                    children:  <Widget>[
                      Container(
                        height: 50,
                        color: Colors.lightGreen,
                        child: const Center(child:
                        Text(
                            'Wash your hands thoroughly and regularly',
                          style:TextStyle(
                            color: Colors.white,
                            fontWeight:FontWeight.bold,
                            fontSize: 18.0,
                            //backgroundColor: new Color(0xFFFF7043)
                          ),
                         ),

                        ),
                      ),
                      Container(
                        height: 50,
                        color: Colors.lightGreen,
                        child: const Center(child: Text('Stay 1.5 metres away from other people',
                          style:TextStyle(
                            color: Colors.white,
                            fontWeight:FontWeight.bold,
                            fontSize: 18.0,
                            //backgroundColor: new Color(0xFFFF7043)
                          ),)),
                      ),
                      Container(
                        height: 50,
                        color: Colors.lightGreen,
                        child: const Center(child: Text('Remember to wear a mask',
                          style:TextStyle(
                            color: Colors.white,
                            fontWeight:FontWeight.bold,
                            fontSize: 18.0,
                            //backgroundColor: new Color(0xFFFF7043)
                          ),)),
                      ),
                    ],
                  )
              ),

              Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset('img/protectionrules.PNG', height: 400, width: 400),
                      height: 250,
                      width: double.infinity,
                      //fit: BoxFit.cover,
                    ),
                  ]
              ),









              Text(
                Strings.testPositive,
                textAlign: TextAlign.center,
                style:TextStyle(
                  color: new Color(0xFF0D47A1),
                  fontWeight:FontWeight.bold,
                  fontSize: 20.0,
                  //backgroundColor: new Color(0xFFFF7043)
                ),
              ),


              Container(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        setState((){
                          const url='https://www.gov.pl/web/koronawirus/wlasnie-otrzymalem-pozytywny-wynik-testu';
                          launch(url);
                        });
                      },

                      style: ElevatedButton.styleFrom(
                        primary:Colors.blueAccent,
                        onPrimary: Colors.white,
                        elevation: 20,
                        minimumSize: Size(200,50),
                      ),
                      label: Text('COVID TEST POSITIVE',
                          style:TextStyle(
                            color: new Color(0xFFFFFFFF),
                            fontWeight:FontWeight.bold,
                            fontSize: 15.0,

                          )
                      ),  icon: const Icon(Icons.coronavirus)
                  ),
              ),

              Padding(padding: const EdgeInsets.all(5.0),

                child:  ElevatedButton.icon(
                    onPressed: () {
                      setState((){

                        const url='https://www.gov.pl/web/koronawirus/mam-koronawirusa-i-jestem-w-izolacji-domowej';
                        launch(url);
                        //Navigator.push(context,new MaterialPageRoute(builder: (context) => IsolHomeFragment()),
                        // );
                      }
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      primary:Colors.blueAccent,
                      onPrimary: Colors.white,
                      elevation: 20,
                      minimumSize: Size(50,50),
                    ),
                    label: Text('HOME ISOLATION PRINCIPLES',
                        style:TextStyle(
                          color: new Color(0xFFFFFFFF),
                          fontWeight:FontWeight.bold,
                          fontSize: 15.0,

                        )
                    ),  icon: const Icon(Icons.home)
                ),
              ),


            ]



          ),





        ),




      ),


    );
  }
}
