import React, { Component } from 'react';
import ReviewsIndex from './ReviewsIndex';

class AlbumShow extends Component {
  constructor(props) {
    super(props);
    this.state = {
      fetched: false,
      albumReviews: []
    }
  }

  componentDidMount() {
    fetch(`/api/v1/albums/${this.props.match.params.id}/reviews`)
    .then(response => {
      if (response.ok) {
        return response.json()
      } else {
        let errorMessage = `${response.status} (${response.statusText})`;
        let error = new Error(errorMessage);
        throw(error);
      }
    })
    .then(response => {

      this.setState({
        fetched: true,
        albumReviews: response.reviews
      });
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  render() {
    let reviewsIndex;
    let reviewsData = []
    if (this.state.fetched) {
      reviewsData = this.state.albumReviews
      reviewsIndex = (
        <ReviewsIndex
          reviewsData={reviewsData}
        />
      )
    }
    return(
      <div>
        <h2>{this.state.albumTitle}</h2>
        {reviewsIndex}
      </div>
    );
  }
}

export default AlbumShow;
