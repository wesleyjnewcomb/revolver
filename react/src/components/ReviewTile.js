import React from 'react';

const ReviewTile = props => {
  let review = props.content

  let body = review.body
  let rating = review.rating

  return(
    <div className="small-12 panel columns">
      <div className="row">
        <h3 className="left">
          Rating: {rating}/10
        </h3>
      </div>
      <div className="review-body">
        {body}
      </div>
    </div>
  );
}

export default ReviewTile;
