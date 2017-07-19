import React from 'react';
import AlbumTile from '../components/AlbumTile'


class AlbumsIndexContainer extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      albums: []
    };
  }

  render() {
    let albums = this.state.albums.map(album => {
      return (
        <AlbumTile key={album.id} album={album} />
      )
    });
    return(
      <div className='albums-index'>
        {albums}
      </div>
    );
  }
}

export default AlbumsIndexContainer;
