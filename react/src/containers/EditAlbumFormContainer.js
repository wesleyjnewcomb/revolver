import React, {Component} from "react";
import { Link } from 'react-router-dom'

import TextField from '../components/TextField';
import Dropdown from '../components/Dropdown';
import NumberField from '../components/NumberField';
import ErrorBox from '../components/ErrorBox'

import months from '../monthAbbreviations';

const yearMin = 1900;
const yearMax = 3000;

class EditAlbumFormContainer extends Component{
  constructor(props) {
    super(props);
    this.state = {
      title: '',
      year_released: '',
      month_released: '',
      artist: '',
      errors: []
    }
    this.handleTextFieldChange = this.handleTextFieldChange.bind(this);
    this.handleClearForm = this.handleClearForm.bind(this);
    this.handleSubmitForm = this.handleSubmitForm.bind(this)
  }

  componentDidMount() {
    fetch(`/api/v1/albums/${this.props.match.params.id}`, {
      credentials: 'same-origin'
    })
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
        title: response.album.title,
        artist: response.album.artist.name,
        year_released: response.album.year_released,
        month_released: response.album.month_released
      });
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  handleTextFieldChange(event) {
    event.preventDefault();
    this.setState({ [event.target.name]: event.target.value })
  }

  handleClearForm(event) {
    event.preventDefault();
    this.setState({
      title: '',
      month_released: '',
      year_released: '',
      artist: ''
    })
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

    this.editAlbumSubmit();
  }

  editAlbumSubmit() {
    let payload = {
      album: {
        title: this.state.title,
        month_released: this.state.month_released,
        year_released: this.state.year_released,
        artist_name: this.state.artist
      }
    };
    fetch(`/api/v1/albums/${this.props.match.params.id}`, {
      method: 'PATCH',
      credentials: 'same-origin',
      body: JSON.stringify(payload)
    }).then(response => {
      if (response.ok || response.status === 403) {
        return response.json()
      } else {
        let errorMessage = `${response.status} (${response.statusText})`;
        let error = new Error(errorMessage);
        throw(error);
      }
    }).then(response => {
      if ('errors' in response) {
        this.setState({ errors: response.errors })
      } else {
        this.setState({ newAlbum: response.album })
      }
    }).catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  render() {
    let errors;
    let newAlbumLink;
    if(this.state.errors.length) {
      errors = <ErrorBox errors={this.state.errors} />
    }

    let monthOptions = months.map((option, i) => {
      return { label: option, value: i }
    })
    monthOptions.unshift({label: '', value: ''})

    if (this.state.newAlbum) {
      newAlbumLink = (
        <div className='panel callout text-center'>
          <Link to={`/albums/${this.state.newAlbum.id}`}>
          {this.state.newAlbum.title}
        </Link>
        &nbsp;has been updated!
      </div>
      )
    }

    return(
      <div className='album-form'>
        {newAlbumLink}
        <div className="panel small-6 columns small-centered">
          <h2>Edit Album</h2>
          <form onSubmit={this.handleSubmitForm}>
            <div className='row small-12 columns'>
              <TextField
                name='artist'
                label='Artist*'
                content={this.state.artist}
                handleChange={this.handleTextFieldChange}
              />
            </div>
            <div className='row small-12 columns'>
              <TextField
                name='title'
                label='Title*'
                content={this.state.title}
                handleChange={this.handleTextFieldChange}
              />
            </div>
            <div className='row'>
              <div className='small-3 columns'>
                <Dropdown
                  name='month_released'
                  label='Month'
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

export default EditAlbumFormContainer;
