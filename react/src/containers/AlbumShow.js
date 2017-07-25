import React, { Component } from 'react';
import ReviewsIndex from './ReviewsIndex';
import ReviewFormContainer from './ReviewFormContainer'
import Accordion from './Accordion';

import months from '../monthAbbreviations';

class AlbumShow extends Component {
  constructor(props) {
    super(props);
    this.state = {
      fetched: false,
      albumReviews: [],
      albumTitle: '',
      albumArtist: '',

      rating: null,
      body: '',
      errors: []
    }

    this.handleSubmitForm = this.handleSubmitForm.bind(this)
    this.handleChange = this.handleChange.bind(this)
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
        albumArtist: response.album.artist.name,
        yearReleased: response.album.year_released,
        monthReleased: response.album.month_released
      });
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  validateInput() {
    let errors = [];

    if(this.state.rating == null) {
      errors.push('Review must have a rating');
    }
    console.log(errors);
    this.setState({errors: errors})

    if(errors.length) {
      return false;
    } else {
      return true;
    }
  }

  handleSubmitForm(e) {
    e.preventDefault();

    if (!this.validateInput()) {
      console.log('Bad form');
      return false;
    }
    // fetch goes here

    let new_review = {
      id: 1000,
      rating: this.state.rating,
      body: this.state.body,
      username: 'Kyle'
    }
    let new_reviews = [ new_review ].concat(this.state.albumReviews);
    this.setState({ albumReviews: new_reviews })

    this.clearForm()
  }

  handleChange(e) {
    this.setState({ [e.target.name]: e.target.value });
  }

  clearForm() {
    this.setState({body: ''})
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
      <div className='row'>
        <div className="album-tile panel">
          <div className='row'>
            <h3 className="medium-9 small-8 columns">
              <span className="album-artist">{this.state.albumArtist}</span>
              <span className='album-title'>{this.state.albumTitle}</span>
            </h3>
            <h4 className="medium-3 small-4 columns text-right">
              {months[this.state.monthReleased]} {this.state.yearReleased}
            </h4>
          </div>
          <Accordion title='Submit new review'>
            <ReviewFormContainer
              handleChange={this.handleChange}
              handleSubmitForm={this.handleSubmitForm}
              clearForm={this.clearForm}
              errors={this.state.errors}
            />
          </Accordion>
          <h3>Reviews</h3>
          <div>{reviewsIndex}</div>
        </div>
      </div>
    );
  }
}

export default AlbumShow;
