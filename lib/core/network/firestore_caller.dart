import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreCaller {
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  ///can you use it to set doc to collection with auto iD
  ///or set doc in collection inside collection with auto iD
  ///or create new collection and set doc with auto iD
  ///Path Example  collection name , collection name/doc id/another collection name
  Future<void> setDocument({
    required String path,
    required Map<String, dynamic> data,
    String? docId,
  }) async {
    final CollectionReference<Map<String, dynamic>> reference =
        _firebaseFireStore.collection(path);
    if (docId != null) {
      DocumentReference<Map<String, dynamic>> doc = reference.doc(docId);
      await doc.set(data);
    } else {
      await reference.add(data);
    }
    print('path: $path/${docId ?? ''} ');
    print('data: $data');
  }

  ///can you use it to update doc in collection
  ///or update doc in collection inside collection
  ///Path Example collection name/doc id , collection name/doc id/another collection name/doc id
  Future<void> updateDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final DocumentReference<Map<String, dynamic>> reference =
        _firebaseFireStore.doc(path);
    print('path: $path');
    print('data: $data');
    await reference.update(data);
  }

  ///can you use it to delete doc in collection
  ///or delete doc in collection inside collection
  ///Path Example  collection name/doc id , collection name/doc id/another collection name/doc id
  Future<void> deleteDocument({required String path}) async {
    final DocumentReference<Map<String, dynamic>> reference =
        _firebaseFireStore.doc(path);
    print('path: $path');
    await reference.delete();
  }

  ///can you use it to return doc exist in collection
  ///or return doc in collection inside collection
  ///Path Example  collection name/doc id , collection name/doc id/another collection name/doc id
  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic>? data) builder,
  }) async {
    final DocumentReference<Map<String, dynamic>> reference =
        _firebaseFireStore.doc(path);
    final DocumentSnapshot<Map<String, dynamic>> doc = await reference.get();
    print('path: $path');
    if (doc.exists && doc.data() != null) {
      String docId = doc.id;
      Map<String, dynamic> data = doc.data()!;
      data.addAll({
        'docId': docId,
      });
      print('data: $data');
      return builder(data);
    }
    print('data: null');
    return builder(
      null,
    );
  }

  ///can you use it to get streaming doc in collection
  ///or get streaming doc in collection inside collection
  ///Path Example  collection name/doc id , collection name/doc id/another collection name/doc id
  ///[builder] you can use this function to receive doc in Map<String,dynamic> and put it in model
  Stream<T> getDocumentStream<T>({
    required String path,
    required T Function(
      Map<String, dynamic> data,
    ) builder,
  }) {
    final DocumentReference<Map<String, dynamic>> reference =
        _firebaseFireStore.doc(path);
    final Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots =
        reference.snapshots();
    return snapshots.map((snapshot) {
      Map<String, dynamic>? doc = snapshot.data();
      doc!.addAll({'docId': snapshot.id});
      print('path: $path');
      print('data: $doc');
      return builder(
        doc,
      );
    });
  }

  ///can you use it to get docs in collection as Future
  ///or get docs in collection inside collection as Future
  ///Path Example  collection name , collection name/doc id/another collection name
  Future<T> getCollection<T>({
    required String path,
    required T Function(List<QueryDocumentSnapshot<Object?>> data) builder,
    Query<Object?> Function(CollectionReference query)? queryBuilder,
  }) async {
    final CollectionReference reference = _firebaseFireStore.collection(path);

    final List<QueryDocumentSnapshot<Object?>> docs;
    if (queryBuilder != null) {
      docs = (await queryBuilder(reference).get()).docs;
    } else {
      docs = (await reference.get()).docs;
    }
    print('path: $path');
    if (docs.isNotEmpty) {
      print('docs: ${docs.length}');
      return builder(docs);
    }
    print('docs : Empty');
    return builder([]);
  }

  ///can you use it to get streaming docs in collection
  ///or get streaming docs in collection inside collection
  ///Path Example  collection name , collection name/doc id/another collection name
  ///[queryBuilder]  you can use this function to make query as Example return query.where('text', isEqualTo: 'ddd')
  ///[builder] you can use this function to receive data item in Map<String,dynamic> and put it in model
  Stream<List<T>> getCollectionStream<T>({
    required String path,
    Query<Map<String, dynamic>>? Function(Query<Map<String, dynamic>> query)?
        queryBuilder,
    required T Function(Map<String, dynamic>? data) builder,
  }) {
    Query<Map<String, dynamic>> query = _firebaseFireStore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
        query.snapshots();
    print('path: $path');
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) {
            Map<String, dynamic> doc = snapshot.data();
            doc.addAll({'docId': snapshot.id});
            print('data: $doc');
            return builder(
              doc,
            );
          })
          .where((value) => value != null)
          .toList();
      return result;
    });
  }

  ///can you use it to remove all docs in collection
  ///or remove all docs in collection inside collection
  ///Path Example  collection name , collection name/doc id/another collection name
  Future<void> deleteCollection({required String path}) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
        (await _firebaseFireStore.collection(path).get()).docs;
    print('path: $path');
    for (DocumentSnapshot doc in docs) {
      doc.reference.delete();
    }
  }
}
