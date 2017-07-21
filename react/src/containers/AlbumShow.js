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
    // fetch(`api/v1/albums/${this.props.albumId}/reviews`)
    // .then(response => {
    //   if (response.ok) {
    //     return response
    //   } else {
    //     let errorMessage = `${response.status} (${response.statusText})`;
    //     let error = new Error(errorMessage);
    //     throw(error);
    //   }
    // })
    // .then(response => {
    //   debugger;
    //   this.setState({
    //     albumReviews: [
    //       { sup: 'dooood' }
    //     ]
    //   });
    // })
    // .catch(error => console.error(`Error in fetch: ${error.message}`))
    this.setState({
      albumTitle: 'the white album',
      albumReviews: [
        {
          id: 1,
          albumId: 3,
          username: 'enthusiastick',
          createdAt: 'a week ago',
          updatedAt: 'a day ago',
          body: 'album suxxx',
          rating: 2
        }
      ],
      fetched: true
    });
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
        {reviewsIndex}
      </div>
    );
  }
}

export default AlbumShow;
