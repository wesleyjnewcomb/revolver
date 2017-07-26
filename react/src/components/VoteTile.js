import React, { Component } from 'react';

class VoteTile extends Component {
  constructor(props){
    super(props);
    this.state = {
      userVote: this.props.currentValue
    }
  }

  vote(value) {
    let vote;
    if (this.state.userVote === value) {
      vote = 0
    } else {
      vote = value
    }
    this.setState({ userVote: vote });
  }

  render() {
    let total = this.props.score + this.state.userVote
    let upVote = () => { this.vote(1) }
    let downVote = () => { this.vote(-1) }
    let upCssClass = 'fa fa-caret-up arrow'
    let downCssClass = 'fa fa-caret-down arrow'
    if (this.state.userVote === 1) {
      upCssClass += ' highlighted-arrow'
    } else if (this.state.userVote === -1) {
      downCssClass += ' highlighted-arrow'
    }

    return(
      <div className="vote-tile">
        <i className={upCssClass} onClick={upVote}/>
          <br />
            {total}
          <br />
        <i className={downCssClass} onClick={downVote}/>
      </div>
    )
  }

}

export default VoteTile;
