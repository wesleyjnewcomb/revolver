import React from 'react';
import { Link } from 'react-router-dom'
import AlbumTile from '../components/AlbumTile'
import TextField from '../components/TextField'


class SearchContainer extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      albums: [],
      query: '',
      noResults: null
    };
    this.handleTextFieldChange = this.handleTextFieldChange.bind(this)
    this.handleSearch = this.handleSearch.bind(this)
  }

  handleTextFieldChange(event) {
    this.setState({ [event.target.name]: event.target.value })
  }

  handleSearch(event) {
    event.preventDefault()
    let query = '?artist='+encodeURIComponent(this.state.query);
    fetch('/api/v1/albums/search' + query, {
      credentials: 'same-origin'
    })
    .then(response => {
      if (response.ok) {
        return response.json()
      } else {
        let errorMessage = `${response.status} (${response.statusText})`
        let error = new Error(errorMessage)
        throw(error)
      }
    })
    .then(response => {
      console.log(response)
      this.setState({ albums: response.albums, noResults: false })
      if (response.albums.length === 0) {
        this.setState({ noResults: true })
      }
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  render() {
    let albums = this.state.albums.map(album => {
      return (
        <AlbumTile key={album.id} album={album} />
      )
    });
    let noResultsMessage = ''
    if (this.state.noResults) {
      noResultsMessage = <div className="small-12 columns text-center">
        No albums found for "{this.state.query}"
      </div>
    }
    return (
      <div className='albums-index'>
        <div className='text-center'>
          <Link className='button' to='/albums/new'>Submit New Album</Link>
          &nbsp;
          <Link className='button' to='/albums'>Browse</Link>
        </div>
        <div className="small-8 small-centered end columns">
          <form onSubmit={this.handleSearch}>
            <div className="small-11 columns">
              <TextField
                name='query'
                content={this.state.query}
                handleChange={this.handleTextFieldChange}
              />
            </div>
            <div className="small-1 end columns">
              <input className='button secondary small' type='submit' value='Search' />
            </div>
          </form>
        </div>
        {albums}
        <br />
        {noResultsMessage}
      </div>
    );
  }
}

export default SearchContainer;
