import React from 'react'
import { Link } from 'react-router-dom'
import months from '../monthAbbreviations'

const AlbumTile = ({ album }) => {
  let month = album.month_released
  let year = album.year_released
  return (
    <div className='album-tile panel row'>
      <h3 className='left'>
        <Link to={`/albums/${album.id}`}>
          <span className="album-artist">{album.artist.name}</span>
          <span className="album-title">{album.title}</span>
        </Link>
      </h3>
      <h4 className='right'>{months[month]} {year}</h4>
    </div>
  )
}

export default AlbumTile;
