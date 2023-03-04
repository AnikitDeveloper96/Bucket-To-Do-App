// import 'dart:async';

// class ToDoBloc {
//   GetBatchesDataUsingVariantRepo? _getBatchesDataUsingVariantRepo;
//   final _getBatchesDataUsingVariantStreamController =
//       StreamController<ApiResponse<GetBatchesDataUsingVariantResponseModel>>();

//   StreamSink<ApiResponse<GetBatchesDataUsingVariantResponseModel>>
//       get _getBatchesDataUsingVariantSink =>
//           _getBatchesDataUsingVariantStreamController.sink;
//   Stream<ApiResponse<GetBatchesDataUsingVariantResponseModel>>
//       get getBatchesDataUsingVariantStream =>
//           _getBatchesDataUsingVariantStreamController.stream;

//   GetBatchesDataUsingVariantBloc() {
//     _getBatchesDataUsingVariantRepo = GetBatchesDataUsingVariantRepo();
//     getBatchesDataUsingVariantResponse();
//   }

//   getBatchesDataUsingVariantResponse() async {
//     _getBatchesDataUsingVariantSink
//         .add(ApiResponse.loading(("Geting batches data using varient ...")));

//     List variantId = ["27"];

//     try {
//       GetBatchesDataUsingVariantResponseModel _model =
//           await _getBatchesDataUsingVariantRepo!
//               .getBatchesDataUsingVariantRequest(variantId);
//       _getBatchesDataUsingVariantSink.add(ApiResponse.completed(_model));
//     } catch (exception) {
//       print("get batches exception is ------$exception");
//       _getBatchesDataUsingVariantSink
//           .add(ApiResponse.error(exception.toString()));
//     }
//   }

//   dispose() {
//     _getBatchesDataUsingVariantStreamController.close();
//   }
// }
