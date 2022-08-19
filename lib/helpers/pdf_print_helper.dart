import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../widgets/pdf_content.dart';

class PdfPrintHelper {
  static void createPdfAndPrint(BuildContext context) async {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context _) {
            return PdfContent(ctxt: context);
          }),
    );
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
