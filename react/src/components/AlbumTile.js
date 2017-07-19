import React from 'react'

const AlbumTile = ({ album }) => {
  return (
    <div className='album-tile'>
      <h3>{album.title}</h3>
      <h4>{album.date_released.getMonth()} {album.date_released.getYear()}</h4>
    </div>
  )
}

export default AlbumTile;
