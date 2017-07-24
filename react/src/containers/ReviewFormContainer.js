import React from 'react'

import RadioButton from '../components/RadioButton'
import TextArea from '../components/TextArea'


class ReviewFormContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      rating: null,
      body: ''
    }
    this.handleChange = this.handleChange.bind(this)
  }

  handleChange(e) {
    this.setState({ [e.target.name]: e.target.value });
  }

  handleSubmitForm(e) {
    e.preventDefault();
  }

  clearForm() {
    e.preventDefault();
    this.setState({body: ''})

  }

  render() {
    let options = [
      { label: '1', value: '1' },
      { label: '2', value: '2' },
      { label: '3', value: '3' },
      { label: '4', value: '4' },
      { label: '5', value: '5' },
      { label: '6', value: '6' },
      { label: '7', value: '7' },
      { label: '8', value: '8' },
      { label: '9', value: '9' },
      { label: '10', value: '10' }
    ]
    return (
      <div className='review-form'>
        <div className='small-6 columns small-centered'>
          <h2>Submit New Review</h2>
          <form onSubmit={this.handleSubmitForm}>
            <RadioButton
              label='Rating'
              name='rating'
              value={this.state.rating}
              options={options}
              handleChange={this.handleChange}
            />
            <TextArea
              label='Review'
              name='body'
              content={this.state.body}
              handleChange={this.handleChange}
            />
            <input type='submit' className='button'/>&nbsp;
            <button onClick={this.clearForm} className='button secondary'>Clear</button>
          </form>
        </div>
      </div>
    )
  }
}

export default ReviewFormContainer;
