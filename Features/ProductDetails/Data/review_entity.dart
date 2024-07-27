class Comment{
  final String productId;
  final String userName,profilePicture,comment,uploadedAt;
  final double rating;
  Comment? reply;

  Comment( {required this.productId, this.reply,required this.userName, required this.profilePicture, required this.comment, required this.uploadedAt, required this.rating});
}
class ReviewEntity{

   double oneStar,twoStar,threeStar,fourStar,fiveStar;

  ReviewEntity({ required this.oneStar, required this.twoStar, required this.threeStar, required this.fourStar, required this.fiveStar});
}