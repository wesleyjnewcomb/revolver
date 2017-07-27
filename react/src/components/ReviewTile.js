import React from 'react';
import VoteTile from './VoteTile';

const ReviewTile = props => {
  let review = props.content

  let body = review.body
  let rating = review.rating
  let username = review.user.username
  let avatar = review.user.avatar
  let currentValue = review.current_user_vote
  let score = review.score - currentValue
  let canVote = review.signed_in

  return(
    <div className='panel radius'>
      <div className="small-12 columns">
        <h3 className="left rating">{rating}/10</h3>
        <span className='right text-right'>
          <img className='avatar' src={avatar.url} /><br/>
          <i className='username'>{username}</i>
        </span>
      </div>
      <div className='row'>
        <div className='small-1 text-center columns'>
          <VoteTile
            score={score}
            currentValue={currentValue}
            reviewId={review.id}
            canVote={canVote}
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
