import 'package:flutter/cupertino.dart';
import '../models/input_manager.dart';
import '../ui/components/input_widget.dart';


// Future<void> loadPdfListSeverally({
//   required List<DocumentData> list,
//   required void Function() refresh,
//   int indx = 0,
// }) async {
//   if (list.length == indx) {
//     return;
//   } else {
//     await list[indx].loadPDF(refresh);
//     loadPdfListSeverally(list: list, refresh: refresh, indx: indx + 1);
//   }
// }

extension Separator on InputWidget {
  Padding separator([double height = 0]) {
    return Padding(padding: EdgeInsets.only(bottom: height), child: this);
  }
}

Widget buildInputField({required TextInputManager manager,required double height}) {
  return InputWidget(manager).separator(height);
}
