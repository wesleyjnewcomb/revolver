import React from 'react';

const ReviewTile = props => {
  let review = props.content

  let body = review.body
  let rating = review.rating
  let username = review.username

  return(
    <div className='panel'>
      <div>
        <h3 className="medium-9 small-8 columns">
          Rating: {rating}/10
        </h3>
        <div className="medium-3 small-4 columns">
          <h3>
            {username}
          </h3>
        </div>
      </div>
      <div className="small-10 columns small-centered">
        {body}
      </div>
    </div>
  );
}

export default ReviewTile;
