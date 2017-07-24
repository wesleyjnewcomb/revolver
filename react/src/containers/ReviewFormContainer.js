import React from 'react'

import RadioButton from '../components/RadioButton'


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

  render() {
    let options = [
      { label: '1', value: 1 },
      { label: '2', value: 2 },
      { label: '3', value: 3 },
      { label: '4', value: 4 },
      { label: '5', value: 5 },
      { label: '6', value: 6 },
      { label: '7', value: 7 },
      { label: '8', value: 8 },
      { label: '9', value: 9 },
      { label: '10', value: 10 }
    ]
    return (
      <div className='review-form'>
        <form >
          <RadioButton
            name='rating'
            options={options}
            handleChange={this.handleChange}
          />
        </form>
      </div>
    )
  }
}

export default ReviewFormContainer;
