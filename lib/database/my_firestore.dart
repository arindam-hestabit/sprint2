// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sprint2/models/user_model.dart';

class MyFirestore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> addFriends(HestaBitFriend f) async {
    CollectionReference friends = firestore.collection('friends');

    try {
      await friends.add({
        'name': f.name,
        'phone': f.phone,
        'email': f.email,
        'dept': f.dept,
        'location': f.location,
        'isfav': f.isFav,
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map>> getFriends() async {
    CollectionReference friends = firestore.collection('friends');

    try {
      final resp = await friends.get();

      return resp.docs
          .map((e) => {
                'id': e.id,
                'data':
                    HestaBitFriend.fromJson((e.data() as Map<String, dynamic>)),
              })
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> deleteFriend(String id) async {
    CollectionReference friends = firestore.collection('friends');

    try {
      final resp = await friends.doc(id).delete();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> toggleFavourite(String id, bool inp) async {
    CollectionReference friends = firestore.collection('friends');

    try {
      final resp = await friends.doc(id).update({'isfav': inp});

      return true;
    } catch (e) {
      return false;
    }
  }
}
