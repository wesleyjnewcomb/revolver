import React, { Component } from 'react';

class VoteTile extends Component {
  constructor(props){
    super(props)
    this.state = {
      userVote: this.props.currentValue
    }
  }

  vote(value) {
    let vote
    if (this.state.userVote === value) {
      vote = 0
    } else {
      vote = value
    }
    this.setState({ userVote: vote })
    this.persistVote(vote)
  }

  persistVote(vote) {
    let payload = {
      vote: {
        review_id: this.props.reviewId,
        value: vote
      }
    }
    fetch('/api/v1/votes', {
      method: 'POST',
      credentials: 'same-origin',
      body: JSON.stringify(payload)
    })
    .then(response => {
      if (response.ok) {
        return response
      } else {
        let errorMessage = `${response.status} (${response.statusText})`
        let error = new Error(errorMessage)
        throw(error)
      }
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  render() {
    let total = this.props.score + this.state.userVote
    let upCssClass = 'fa fa-caret-up arrow'
    let downCssClass = 'fa fa-caret-down arrow'
    let upVote = () => {}
    let downVote = () => {}
    if (this.props.canVote) {
      upVote = () => { this.vote(1) }
      downVote = () => { this.vote(-1) }
      if (this.state.userVote === 1) {
        upCssClass += ' highlighted-arrow'
      } else if (this.state.userVote === -1) {
        downCssClass += ' highlighted-arrow'
      }
    } else {
      upCssClass += ' invisible-arrow'
      downCssClass += ' invisible-arrow'
    }

    return(
      <div className="small-1 text-center">
        <div className="vote-tile">
          <i className={upCssClass} onClick={upVote}/>
          <div className="score">{total}</div>
          <i className={downCssClass} onClick={downVote}/>
        </div>
      </div>
    )
  }
}

export default VoteTile;
