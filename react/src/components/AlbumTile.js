import React from 'react'

import months from '../monthAbbreviations'

const AlbumTile = ({ album }) => {
  let month = album.month_released
  let year = album.year_released
  return (
    <div className='album-tile panel row'>
      <h3 className='left'>
        <span className="album-artist">{album.artist.name}</span>
        <span className="album-title">{album.title}</span>
      </h3>
      <h4 className='right'>{months[month]} {year}</h4>
    </div>
  )
}

export default AlbumTile;
