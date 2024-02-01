import 'dart:developer';
import 'dart:math' hide log;
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myadmin/cubits/my_app_cubit/my_app_cubit.dart';
import 'package:myadmin/routes/route_names.dart';
import 'package:myadmin/utils/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:window_manager/window_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.title});

  final String? title;

  @override
  State<LoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPage> {

  TextEditingController managerCode = TextEditingController();
  FocusNode managerCodeFocus = FocusNode();
  bool isManagerCodeActive = false;

  TextEditingController password = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  bool isPasswordActive = false;

  void initData() {
    log("Initialize Login screen");
  }

  void openPrintPreview() async {
    PdfPageFormat pageFormat = PdfPageFormat(
      58 * 2.5, // Millimeters
      210, // Millimeters
      marginAll: 5
    );

    Uint8List memoryPDF = Uint8List(0);
    Future<void> getMemoryPDF() async {
      Uint8List tempMemory = await _generatePdf(pageFormat, "Sales Invoice");
      memoryPDF = tempMemory;
    }

    showDialog(
        context: context,
        builder: ((BuildContext _) {

          void printDocument() {
            Printing.layoutPdf(
                name: "Sales Invoice",
                usePrinterSettings: true,
                onLayout: (PdfPageFormat format) async => _generatePdf(pageFormat, "Sales Invoice"));
          }

          void downloadDocument() async {
            Uint8List savedFile = await _generatePdf(pageFormat, "Sales Invoice");
            List<int> fileInts = List.from(savedFile);
            // html.AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
            //   ..setAttribute("download", "POS-SALE-${DateTime.now().millisecondsSinceEpoch}.pdf")
            //   ..click();
          }

          // final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
          // pdfViewerKey.currentState?.openBookmarkView();

          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SizedBox(
                    width: 1000,
                    height: 600,
                    child: Column(children: [
                      Container(
                        width: 1000,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Expanded(
                            child: Text('PRINT PREVIEW')
                          ),
                          InkWell(
                              child: const Icon(
                                Icons.close,
                                color: Color(0xFF333333),
                              ),
                              onTap: () {
                                Navigator.pop(_, true);
                              }),
                        ]),
                      ),
                      SizedBox(
                          width: 300,
                          height: 550,
                          child: PdfPreview(
                            canDebug: false,
                            canChangeOrientation: false,
                            canChangePageFormat: false,
                            allowPrinting: false,
                            allowSharing: false,
                            pdfFileName: 'POS-SALE-${DateTime.now().millisecondsSinceEpoch}',
                            // loadingWidget: SfPdfViewer.memory(
                            //   memoryPDF,
                            //   key: pdfViewerKey,
                            // ),
                            loadingWidget: const Center(
                              child: CircularProgressIndicator()
                            ),
                            onError: (_, data) {
                              return const Center(
                                child: CircularProgressIndicator(color: Colors.red)
                              );
                            },
                            onPrintError: (_, data) {
                              print(data);
                            },
                            actions: [
                              SizedBox(
                                width: 75,
                                height: 40,
                                child: Center(
                                  child: Tooltip(
                                    message: "Print",
                                    child: InkWell(
                                        onTap: () {
                                          printDocument();
                                        },
                                        child: const Icon(Icons.print, color: Colors.white)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 75,
                                height: 40,
                                child: Center(
                                  child: Tooltip(
                                    message: "Download PDF",
                                    child: InkWell(
                                        onTap: () {
                                          downloadDocument();
                                        },
                                        child: const Icon(Icons.download, color: Colors.white)),
                                  ),
                                ),
                              ),
                              Container(
                                height: 36,
                                color: Colors.white,
                                margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    menuMaxHeight: 300,
                                    value: "POS 58mmx210mm",
                                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black
                                    ),
                                    onChanged: (String? newValue) {
                                      // setState(() {
                                        
                                      // });
                                    },
                                    items: <String>[
                                      "Letter",
                                      "Legal",
                                      "A4",
                                      "POS 58mmx210mm",
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 75,
                                height: 40,
                                child: Center(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Tooltip(
                                          message: "Preview as portrait",
                                          child: InkWell(
                                              onTap: () {
                                                // setState(() {
                                                  
                                                // });
                                              },
                                              child: Transform.rotate(
                                                angle: -90 * pi / 180,
                                                child: Icon(
                                                  Icons.note_sharp,
                                                  color:  Colors.white,
                                                ),
                                              )),
                                        ),
                                        Tooltip(
                                          message: "Preview as landscape",
                                          child: InkWell(
                                              onTap: () {
                                                // setState(() {
                                                  
                                                // });
                                              },
                                              child: Icon(
                                                Icons.note_sharp,
                                                color: Colors.white,
                                              )),
                                        )
                                      ]),
                                ),
                              )
                            ],
                            build: (format) => _generatePdf(pageFormat, "Sales Invoice"),
                          ))
                    ])));
          });
        }));
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {

    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final poppinsLight = await PdfGoogleFonts.poppinsLight();
    
    // final img = await rootBundle.load('assets/images/print-image.png');
    // final imageBytes = img.buffer.asUint8List();
    final netImage = await networkImage('https://my-assets-indol.vercel.app/assets/sp-qr-code.png');

    List<pw.Widget> sections = [];

    final body = pw.Container(
      child: pw.Column(
        children: [
          pw.Text(
            "Thriver Digital",
            style: pw.TextStyle(
              font: poppinsLight,
              fontSize: 6 * 2,
            ),
            textAlign: pw.TextAlign.center
          ),
          pw.SizedBox(height: 4 * 2),
          pw.Text(
            "Tekqore Solutions",
            style: pw.TextStyle(
              font: poppinsLight,
              fontSize: 4 * 2,
            ),
            textAlign: pw.TextAlign.center
          ),
          pw.SizedBox(height: 4 * 2),
          // pw.Image(pw.MemoryImage(imageBytes)),
          pw.Image(netImage),
          pw.SizedBox(height: 4 * 2),
          pw.Text(
            "Test Print",
            style: pw.TextStyle(
              font: poppinsLight,
              fontSize: 4 * 2,
            ),
            textAlign: pw.TextAlign.center
          ),
          pw.SizedBox(height: 4 * 2),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Product 1",
                style: pw.TextStyle(
                  font: poppinsLight,
                  fontSize: 4 * 2,
                ),
                textAlign: pw.TextAlign.center
              ),
              pw.Text(
                "P 0.00",
                style: pw.TextStyle(
                  font: poppinsLight,
                  fontSize: 4 * 2,
                ),
                textAlign: pw.TextAlign.center
              ),
            ]
          ),
          pw.SizedBox(height: 4 * 2),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Product 2",
                style: pw.TextStyle(
                  font: poppinsLight,
                  fontSize: 4 * 2,
                ),
                textAlign: pw.TextAlign.center
              ),
              pw.Text(
                "P 0.00",
                style: pw.TextStyle(
                  font: poppinsLight,
                  fontSize: 4 * 2,
                ),
                textAlign: pw.TextAlign.center
              ),
            ]
          ),
          pw.SizedBox(height: 10 * 2),
          pw.Text(
            "For inquiries, you can email as at tekqore@gmail.com. Visit our website: https://thriverdigital.com",
            style: pw.TextStyle(
              font: poppinsLight,
              fontSize: 3 * 2,
            ),
            textAlign: pw.TextAlign.center
          ),
          pw.SizedBox(height: 10 * 2),
          pw.Text(
            "Thank you for your business",
            style: pw.TextStyle(
              font: poppinsLight,
              fontSize: 4 * 2,
            ),
            textAlign: pw.TextAlign.center
          ),
        ]
      )
    );

    sections.add(body);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        build: (context) => sections,
      ),
    );

    final newDocument = pdf.save();

    // Print the PDF document
    /* Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => newDocument
    ); */

    return newDocument;

  }

  @override
  void dispose() {
    //
    super.dispose();
    managerCodeFocus.removeListener(_onManagerCodeFocusChange);
    managerCodeFocus.dispose();
    passwordFocus.removeListener(_onPasswordFocusChange);
    passwordFocus.dispose();
  }

  @override
  void initState() {
    initData();
    super.initState();
    managerCodeFocus.addListener(_onManagerCodeFocusChange);
    passwordFocus.addListener(_onPasswordFocusChange);
  }

  void _onManagerCodeFocusChange() {
    // setState(() {
    //   if(managerCodeFocus.hasFocus){
    //     isManagerCodeActive = true;
    //   }else{
    //     isManagerCodeActive = false;
    //   }
    // });
  }

  void _onPasswordFocusChange() {
    // setState(() {
    //   if(passwordFocus.hasFocus){
    //     isPasswordActive = true;
    //   }else{
    //     isPasswordActive = false;
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final myAppCubit = GetIt.instance<MyAppCubit>();
    return BlocBuilder<MyAppCubit, MyAppState>(
      bloc: myAppCubit,
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.deepPurple.withOpacity(0.2),
                padding: const EdgeInsets.all(50),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(100.0),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 400,
                                height: 100,
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    "WELCOME ADMIN!",
                                    style: MyDesktopTheme.textbody20()
                                  )
                                ),
                              ),
                              const SizedBox(height: 100),
                              SizedBox(
                                width: 400,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    FilledButton(
                                      style: FilledButton.styleFrom(
                                        fixedSize: Size(150, 50),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                      onPressed: () {
                        
                                      },
                                      child: Center(
                                          child: Text(
                                            "USER",
                                            style: MyDesktopTheme.textbody20(
                                              color: Colors.white
                                            )
                                          )
                                        )
                                    ),
                                    FilledButton(
                                      style: FilledButton.styleFrom(
                                        fixedSize: Size(150, 50),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                      onPressed: () {
                        
                                      },
                                      child: Center(
                                          child: Text(
                                            "ADMIN",
                                            style: MyDesktopTheme.textbody20(
                                              color: Colors.white
                                            )
                                          )
                                        )
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              SizedBox(
                                width: 400,
                                child: TextFormField(
                                  controller: managerCode,
                                  focusNode: managerCodeFocus,
                                  onTap: () {
                                    setState(() {
                                      isManagerCodeActive = true;
                                      isPasswordActive = false;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Manager Code"
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 400,
                                child: TextFormField(
                                  controller: password,
                                  focusNode: passwordFocus,
                                  obscureText: true,
                                  obscuringCharacter : "*",
                                  onTap: () {
                                    setState(() {
                                      isManagerCodeActive = false;
                                      isPasswordActive = true;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "PIN"
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              FilledButton(
                                style: FilledButton.styleFrom(
                                  fixedSize: Size(400, 50),
                                  backgroundColor: Colors.redAccent,
                                ),
                                onPressed: managerCode.text.isNotEmpty && password.text.isNotEmpty
                                ? () {
                                  GetIt.instance<GoRouter>().goNamed(Routes.home.name);
                                }
                                : null,
                                child: Center(
                                    child: Text(
                                      "LOGIN",
                                      style: MyDesktopTheme.textbody20(
                                        color: Colors.white
                                      )
                                    )
                                  )
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: () {
                                  openPrintPreview();
                                },
                                child: Text(
                                  "Test Printer here",
                                  style: TextStyle(
                                    color: Colors.blue
                                  )
                                )
                              )
                            ],
                          ),
                        ),
                      )
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: double.infinity,
                              color: Colors.white,
                            )
                          ),
                          // KEYPAD
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: double.infinity,
                              color: Colors.grey,
                              child: Column(
                                children: [
                                  ////////////////////////////
                                  //
                                  // ROW A
                                  //
                                  ////////////////////////////
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "7";
                                                  }else if (isPasswordActive){
                                                    password.text += "7";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "7",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "8";
                                                  }else if (isPasswordActive){
                                                    password.text += "8";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "8",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "9";
                                                  }else if (isPasswordActive){
                                                    password.text += "9";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "9",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                if(isManagerCodeActive && managerCode.text.isNotEmpty){
                                                  setState(() {
                                                    managerCode.text = managerCode.text.substring(0, (managerCode.text.length - 1));
                                                  });
                                                }else if(isPasswordActive && password.text.isNotEmpty){
                                                  setState(() {
                                                    password.text = password.text.substring(0, (password.text.length - 1));
                                                  });
                                                }
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "Bck",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 20,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ),

                                  ////////////////////////////
                                  //
                                  // ROW B
                                  //
                                  ////////////////////////////
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "4";
                                                  }else if (isPasswordActive){
                                                    password.text += "4";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "4",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "5";
                                                  }else if (isPasswordActive){
                                                    password.text += "5";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "5",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "6";
                                                  }else if (isPasswordActive){
                                                    password.text += "6";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "6",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "#";
                                                  }else if (isPasswordActive){
                                                    password.text += "#";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "#",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ),

                                  ////////////////////////////
                                  //
                                  // ROW C
                                  //
                                  ////////////////////////////
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "1";
                                                  }else if (isPasswordActive){
                                                    password.text += "1";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "1",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "2";
                                                  }else if (isPasswordActive){
                                                    password.text += "2";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "2",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "3";
                                                  }else if (isPasswordActive){
                                                    password.text += "3";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "3",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "*";
                                                  }else if (isPasswordActive){
                                                    password.text += "*";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "*",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ),

                                  ////////////////////////////
                                  //
                                  // ROW A
                                  //
                                  ////////////////////////////
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += ".";
                                                  }else if (isPasswordActive){
                                                    password.text += ".";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    ".",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += "0";
                                                  }else if (isPasswordActive){
                                                    password.text += "0";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "0",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if(isManagerCodeActive){
                                                    managerCode.text += ",";
                                                  }else if (isPasswordActive){
                                                    password.text += ",";
                                                  }
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    ",",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 50,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white70,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              onPressed: () {
                                                if(isManagerCodeActive){
                                                    managerCode.text += "";
                                                  }else if (isPasswordActive){
                                                    password.text += "";
                                                  }
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "Enter",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 16,
                                                    )
                                                  )
                                                )
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            )
                          )
                        ],
                      )
                    )
                  ],
                )
              ),
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          await windowManager.destroy();
                        },
                        child: const Tooltip(
                          message: "Close this window",
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.cancel_sharp,
                              color: Colors.red
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        );
      }
    );
  }
}