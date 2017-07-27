import React from 'react';
import { Link } from 'react-router-dom'
import AlbumTile from '../components/AlbumTile'


class AlbumsIndexContainer extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      albums: []
    };
  }

  componentDidMount() {
    fetch('/api/v1/albums')
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
      this.setState({ albums: response.albums });
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  render() {
    let albums = this.state.albums.map(album => {
      return (
        <AlbumTile key={album.id} album={album} />
      )
    });
    return (
      <div className='albums-index'>
        <div className='text-center'>
          <Link className='button' to='/albums/new'>Submit New Album</Link>
          &nbsp;
          <Link className='button' to='/albums/search'>Search By Artist</Link>
        </div>
        {albums}
      </div>
    );
  }
}

export default AlbumsIndexContainer;
