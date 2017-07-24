import React from 'react';

const ReviewTile = props => {
  let review = props.content

  let body = review.body
  let rating = review.rating
  let username = review.username
  let userEmail = review.user_email

  return(
    <div className="small-12 panel columns">
      <div className="row">
        <h3 className="left">
          Rating: {rating}/10
        </h3>
        <div className="right">
          <h3>
            {username}
          </h3>
        </div>
      </div>
      <div className="review-body">
        {body}
      </div>
    </div>
  );
}

export default ReviewTile;
