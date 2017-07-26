import React from 'react';
import VoteTile from './VoteTile';

const ReviewTile = props => {
  let review = props.content

  let body = review.body
  let rating = review.rating
  let username = review.username

  return(
    <div className='panel'>
      <div>
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
      <div className="small-10 columns small-centered">
        <p className='review-body'>{body}</p>
      </div>
      <div>
        <VoteTile
          score={0}
          currentValue={-1}
        />
      </div>
    </div>
  );
}

export default ReviewTile;
