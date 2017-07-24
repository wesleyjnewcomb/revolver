import React, {Component} from "react";
import TextField from '../components/TextField';

class AlbumFormContainer extends Component{
constructor(props){
  super(props);
  this.state = {
    title: '',
    date_released: '',
    artist: ''
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

handleSubmitForm(event){
event.preventDefault();
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

render(){
  return(
    <div className='album-form'>
      <div className="panel small-6 columns small-centered">
        <h2>New Album</h2>
        <form onSubmit={this.handleSubmitForm}>
          <TextField
            name='title'
            label='Title'
            content={this.state.title}
            handleChange={this.handleTextFieldChange}
          />
          <TextField
            name='date_released'
            label='Date Released'
            content={this.state.date_released}
            handleChange={this.handleTextFieldChange}
          />
          <TextField
            name='artist'
            label='Artist'
            content={this.state.artist}
            handleChange={this.handleTextFieldChange}
          />
          <input type='submit' className='button'/>
          &nbsp;
          <button onClick={this.handleClearForm} className='button secondary'>Clear</button>
        </form>
      </div>
    </div>
  )
  }
}

export default AlbumFormContainer;
