import React, { Component } from 'react';
import ReviewsIndex from './ReviewsIndex';

class AlbumShow extends Component {
  constructor(props) {
    super(props);
    this.state = {
      fetched: false,
      albumReviews: [],
      albumTitle: '',
      albumArtist: ''
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
        albumReviews: response
      });
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))

    fetch(`/api/v1/albums/${this.props.match.params.id}`)
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
        albumTitle: response.album.title,
        albumArtist: response.album.artist.name
      });
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  render() {
    let reviewsIndex;
    let reviewsData = []
    if (this.state.fetched) {
      if (!this.state.albumReviews.length) {
        reviewsIndex = "No reviews found"
      } else {
        reviewsData = this.state.albumReviews
        reviewsIndex = (
          <ReviewsIndex
            reviewsData={reviewsData}
          />
        )
      }
    }
    return(
      <div>
        <div className="row">
          <h2 className="left">{this.state.albumTitle}</h2>
          <h3 className="right">{this.state.albumArtist}</h3>
        </div>
        {reviewsIndex}
      </div>
    );
  }
}

export default AlbumShow;
