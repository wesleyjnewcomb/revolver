import React, {Component} from "react";
import TextField from '../components/TextField';

class AlbumFormContainer extends Component{
constructor(props){
  super(props);
  this.state = {
    title: '',
    date_released: '',
    artist: '',
    form: []
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
let submissions = [];
let payload = [this.state.title, this.state.date_released, this.state.artist]
this.setState({ form: submissions.concat(payload) });
this.handleClearForm(event)
}



render(){

  let handleChange = (event) => {this.handleTextFieldChange(event)}
  let handleClearForm = (event) => {this.handleClearForm(event)}

  return(
    <div className="small-6 columns small-centered">
      <h2>New Album</h2>
      <form>
        <TextField
          name='title'
          label='Title'
          content={this.state.title}
          handleChange={handleChange}
        />
        <TextField
          name='date_released'
          label='Date Released'
          content={this.state.date_released}
          handleChange={handleChange}
        />
        <TextField
          name='artist'
          label='Artist'
          content={this.state.artist}
          handleChange={handleChange}
        />
        <button onClick={this.handleSubmitForm}>Add</button>
        <br />
        <button onClick={handleClearForm}>Clear</button>
      </form>
    </div>
  )
  }
}

export default AlbumFormContainer;
