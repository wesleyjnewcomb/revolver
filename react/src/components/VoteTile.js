import React, { Component } from 'react';

class VoteTile extends Component {
  constructor(props){
    super(props);
    this.state = {
      userVote: 0
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
    let total = this.props.tally + this.state.userVote
    let upVote = () => { this.vote(1) }
    let downVote = () => { this.vote(-1) }
    return(
      <div className="vote-tile">
        <i className='fa fa-caret-up arrow' onClick={upVote}/>
          {total}
        <i className='fa fa-caret-down arrow' onClick={downVote}/>
      </div>
    )
  }

}

export default VoteTile;
