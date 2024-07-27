import 'package:ecommerce_app/Features/ProductDetails/Data/review_entity.dart';

class ReviewController {
  static List<Comment> comments = [
    Comment(
      reply: Comment(
        userName: 'My Store',
        profilePicture: '',
        comment: 'Thank you for your kind words Muneeb, we are delighted to hear about your experience',
        uploadedAt: '07-27-2024',
        rating: 0,
        productId: '',
      ),
      userName: 'Muneeb',
      profilePicture: 'https://firebasestorage.googleapis.com/v0/b/task-manager-1a961.appspot.com/o/images%2FProfilePicture?alt=media&token=771d3425-737e-4350-a012-265c5589df78',
      comment: 'User Interface off the app was very intuitive. I was able to navigate through the app seamlessly.',
      uploadedAt: '07-27-2024',
      rating: 5,
      productId: '11',
    )
  ];

  ReviewEntity reviews = ReviewEntity(oneStar: 0, twoStar: 0, threeStar: 0, fourStar: 0, fiveStar: 0);
  List<double> reviewList = [];

  ReviewController() {
    calculateRating();
    reviewList = [
      reviews.oneStar.toDouble(),
      reviews.twoStar * 2.0,
      reviews.threeStar * 3.0,
      reviews.fourStar * 4.0,
      reviews.fiveStar * 5.0
    ];
  }

  double getPercentage(int value) {
    double totalRatings = reviewList.fold(0, (sum, rating) => sum + rating);
    return totalRatings == 0 ? 0 : reviewList[value] / totalRatings;
  }

  double getAverageRating() {
    double totalRatings = reviewList.fold(0, (sum, rating) => sum + rating);
    return totalRatings / comments.length;
  }

  void calculateRating() {
    for (int x = 0; x < comments.length; x++) {
      switch (comments[x].rating) {
        case 1:
          reviews.oneStar++;
          break;
        case 2:
          reviews.twoStar++;
          break;
        case 3:
          reviews.threeStar++;
          break;
        case 4:
          reviews.fourStar++;
          break;
        case 5:
          reviews.fiveStar++;
          break;
      }
    }
  }
}
