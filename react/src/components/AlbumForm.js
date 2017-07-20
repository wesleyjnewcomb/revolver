import React, {Component} from "react";
import TextField from './TextField';

class AlbumForm extends Component{
constructor(props){
  super(props);
  this.state = {
    title: '',
    date_released: '',
    artist: ''
  }
    this.handleTextFieldChange = this.handleTextFieldChange.bind(this)
}

handleTextFieldChange(event) {
  this.setState({[event.target.name]: event.target.value})
}

render(){

  let handleChange = (event) => {this.handleTextFieldChange(event)}

  return(
    <div>
      <h2>Album Form</h2>
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
        <button onClick=this.></button>
      </form>
    </div>
  )
  }
}

export default AlbumForm;
