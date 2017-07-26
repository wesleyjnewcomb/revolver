import React from 'react';
import VoteTile from './VoteTile';

const ReviewTile = props => {
  let review = props.content

  let body = review.body
  let rating = review.rating
  let username = review.username
  let score = review.score

  return(
    <div className='panel'>
      <div className='row'>
        <div className="medium-9 small-8 columns">
          <h3 className="rating">
            Rating: {rating}/10
          </h3>
        </div>
        <div className="medium-3 small-4 columns">
          <h3 className='username'>
            {username}
          </h3>
        </div>
      </div>
      <div className='row'>
        <div className='small-1 text-center columns'>
          <VoteTile
            score={score}
            currentValue={0}
            reviewId={review.id}
          />
        </div>
        <div className="small-11 columns">
          <p className='review-body'>{body}</p>
        </div>
      </div>
    </div>
  );
}

export default ReviewTile;
