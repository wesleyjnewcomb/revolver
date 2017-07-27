import React from 'react'

import RadioButton from '../components/RadioButton'
import TextArea from '../components/TextArea'
import ErrorBox from '../components/ErrorBox'

class ReviewFormContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {}
    this.handleChange = this.handleChange.bind(this)
    this.clearForm = this.clearForm.bind(this)
  }

  handleChange(e) {
    this.props.handleChange(e);
  }

  clearForm(e) {
    e.preventDefault();
    this.props.clearForm()

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

    let errors;
    if(this.props.errors.length) {
      errors = <ErrorBox errors={this.props.errors} />
    }

    return (
      <div className='review-form'>
        <div className='small-6 columns small-centered'>
          <form onSubmit={this.props.handleSubmitForm}>
            <RadioButton
              label='Rating'
              name='rating'
              value={this.props.rating}
              options={options}
              handleChange={this.handleChange}
            />
            <TextArea
              label='Review'
              name='body'
              content={this.props.content}
              handleChange={this.handleChange}
            />
            <div className='small-12 columns'>
              {errors}
            </div>
            <div className='text-center'>
              <input type='submit' className='button'/>&nbsp;
              <button onClick={this.clearForm} className='button secondary'>Clear</button>
            </div>
          </form>
        </div>
      </div>
    )
  }
}

export default ReviewFormContainer;
