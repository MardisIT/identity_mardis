// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:identity_engine/core/domain/Models/identities.dart';
// import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';
// import 'package:identity_engine/core/presentation/pages/identities/widgets/identities_container.dart';
// import 'package:identity_engine/core/presentation/pages/scanner_qr/scanner_controller.dart';

// class IdentitySearchDelegate extends SearchDelegate {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return IdentitiesSearchResults(query: query);
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return IdentitiesSearchResults(query: query);
//   }
// }

// class IdentitiesSearchResults extends StatelessWidget {
//   final String query;

//   const IdentitiesSearchResults({
//     super.key,
//     required this.query,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final IdentitiesController controller = Get.find();
//     final List<Identity> filteredIdentities = controller.identities
//         .where((identity) =>
//             identity.systemAplication.contains(query) ||
//             identity.email.contains(query))
//         .toList();

//     return ListView.builder(
//       itemCount: filteredIdentities.length,
//       itemBuilder: (context, index) {
//         final identity = filteredIdentities[index];
//         final scannerController = Get.find<ScannerController>();
//         return IdentitiesContainer(
//           controller: controller,
//           scannerController: scannerController,
//           identity: identity,
//           index: index,
//         );
//       },
//     );
//   }
// }
