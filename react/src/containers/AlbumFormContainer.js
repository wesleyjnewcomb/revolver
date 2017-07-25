import React, {Component} from "react";

import TextField from '../components/TextField';
import Dropdown from '../components/Dropdown';
import NumberField from '../components/NumberField';
import ErrorBox from '../components/ErrorBox'

import months from '../monthAbbreviations';

const yearMin = 1900;
const yearMax = 3000;

class AlbumFormContainer extends Component{
constructor(props) {
  super(props);
  this.state = {
    title: '',
    year_released: null,
    month_released: null,
    artist: '',
    errors: []
  }
    this.handleTextFieldChange = this.handleTextFieldChange.bind(this);
    this.handleClearForm = this.handleClearForm.bind(this);
    this.handleSubmitForm = this.handleSubmitForm.bind(this)
}

handleTextFieldChange(event) {
  event.preventDefault();
  this.setState({ [event.target.name]: event.target.value })
}

handleClearForm(event) {
  event.preventDefault();
  this.setState({ title: '', date_released: '', artist: '' })
}

validateInput() {
  let errors = [];

  if(this.state.title.trim() === '') {
    errors.push('Title cannot be blank');
  }
  if(this.state.artist.trim() === '') {
    errors.push('Artist cannot be blank');
  }
  let year = this.state.year_released;
  if(year) {
    if(year < yearMin) {
      errors.push(`Year cannot be earlier than ${yearMin}`);
    }
    if(year > yearMax) {
      errors.push(`Year cannot be later than ${yearMax}`);
    }
  }
  console.log(errors);
  this.setState({errors: errors})

  if(errors.length) {
    return false;
  } else {
    return true;
  }
}

handleSubmitForm(event) {
  event.preventDefault();
  if(this.validateInput() === false) {
    console.log('Bad form');
    return false;
  }
  let payload = { album: { title: this.state.title, date_released: this.state.date_released, artist_name: this.state.artist } };
  fetch('/api/v1/albums', {
    method: 'POST',
    credentials: 'same-origin',
    body: JSON.stringify(payload)
  }).then(response => {
    if (response.ok) {
      return response
    }
  }).then(response => {
      let body = response.json();
      return body;
  });
  this.handleClearForm(event)
}

render() {
  let errors;

  if(this.state.errors.length) {
    errors = <ErrorBox errors={this.state.errors} />
  }

  let monthOptions = months.map((option, i) => {
    return { label: option, value: i }
  })
  monthOptions.unshift({label: '', value: null})

  return(
    <div className='album-form'>
      <div className="panel small-6 columns small-centered">
        <h2>New Album</h2>
        <form onSubmit={this.handleSubmitForm}>
          <div className='row small-12 columns'>
            <TextField
              name='title'
              label='Title'
              content={this.state.title}
              handleChange={this.handleTextFieldChange}
            />
          </div>
          <div className='row'>
            <div className='small-3 columns'>
              <Dropdown
                name='month_released'
                label='Month Released'
                value={this.state.month_released}
                options={monthOptions}
                handleChange={this.handleTextFieldChange}
              />
            </div>
            <div className='small-9 columns'>
              <NumberField
                name='year_released'
                label='Year Released'
                value={this.state.year_released}
                handleChange={this.handleTextFieldChange}
                min={yearMin}
                max={yearMax}
              />
            </div>
          </div>
          <div className='row small-12 columns'>
            <TextField
              name='artist'
              label='Artist'
              content={this.state.artist}
              handleChange={this.handleTextFieldChange}
            />
          </div>
          <div className='row small-12 columns'>
            {errors}
          </div>
          <div className='text-center'>
            <input type='submit' className='button'/>
            &nbsp;
            <button onClick={this.handleClearForm} className='button secondary'>Clear</button>
          </div>
        </form>
      </div>
    </div>
  )
  }
}

export default AlbumFormContainer;
