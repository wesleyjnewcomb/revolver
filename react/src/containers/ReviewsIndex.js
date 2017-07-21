import React from 'react';
import ReviewTile from '../components/ReviewTile';

const ReviewsIndex = props => {
  let reviewTiles = props.reviewsData.map((reviewObj) => {
    let key = reviewObj.id
    return(
      <ReviewTile
        key={key}
        content={reviewObj}
      />
    )
  })
  return(
    <div>
      {reviewTiles}
    </div>
  );
}

export default ReviewsIndex;
