import React, {Component} from 'react'
import AlbumForm from '../components/AlbumForm'


class AlbumsNewFormContainer extends Component{
  constructor(props){
    super(props);
    this.state = {
        forms: []
    }
      this.onSubmit = this.onSubmit.bind(this)
    }

    onSubmit(submission){
      this.setState({forms: this.state.forms.concat(submission) })
    }



  render(){
    return(
      <div>
        <AlbumForm
          onSubmit={this.onSubmit}
        />
      </div>
    )
  }
}

export default AlbumsNewFormContainer;
