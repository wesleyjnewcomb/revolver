import React from 'react'

const months = [
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
]

const AlbumTile = ({ album }) => {
  let dateReleased = new Date(album.date_released)
  let month = dateReleased.getMonth()
  let year = dateReleased.getFullYear()
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
