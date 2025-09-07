//
//  FirestoreManager.swift
//  MovieReviews
//
//  Created by Aryan Patel on 9/4/25.
//

import FirebaseFirestore
import FirebaseAuth

class FirestoreManager {
    private let db = Firestore.firestore()
    
    func listenForReviews(movieId: String, completion: @escaping ([Review]) -> Void) -> ListenerRegistration {
        let listener = db.collection("movies")
            .document(movieId)
            .collection("reviews")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error listening for reviews: \(error)")
                    DispatchQueue.main.async {
                        completion([])
                    }
                    return
                }
                
                let reviews = snapshot?.documents.compactMap { doc -> Review? in
                    let data = doc.data()
                    return Review(
                        id: doc.documentID,
                        username: data["username"] as? String ?? "Anonymous",
                        userId: data["userId"] as? String ?? "unknown",
                        rating: data["rating"] as? Int ?? 0,
                        text: data["text"] as? String ?? ""
                    )
                } ?? []
                
                DispatchQueue.main.async {
                    completion(reviews)
                }
            }
        return listener
    }

    
    func addOrUpdateReview(movieId: String, review: Review, completion: ((Error?) -> Void)? = nil) {
        guard let user = Auth.auth().currentUser else {
            completion?(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Not logged in"]))
            return
        }
        
        let data: [String: Any] = [
            "rating": review.rating,
            "text": review.text,
            "username": review.username,
            "userId": user.uid,
            "timestamp": FieldValue.serverTimestamp()
        ]
        
        db.collection("movies")
          .document(movieId)
          .collection("reviews")
          .document(user.uid)
          .setData(data) { error in
              completion?(error)
          }
    }
    
    func fetchUserReview(movieId: String, userId: String, completion: @escaping (Review?) -> Void) {
        db.collection("movies")
          .document(movieId)
          .collection("reviews")
          .document(userId)
          .getDocument { snapshot, error in
              if let data = snapshot?.data(),
                 let rating = data["rating"] as? Int,
                 let text = data["text"] as? String,
                 let username = data["username"] as? String {
                  
                  let review = Review(
                      id: snapshot!.documentID,
                      username: username,
                      userId: userId,
                      rating: rating,
                      text: text
                  )
                  completion(review)
              } else {
                  completion(nil)
              }
          }
    }

}
