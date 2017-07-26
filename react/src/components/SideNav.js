import React from 'react'
import { Link } from 'react-router-dom'

const SideNav = () => {
  return (
    <ul className='side-nav'>
      <li><Link to='/albums/new'>Submit new album</Link></li>
      <li><Link to='/albums/'>Browse albums</Link></li>
      <li><Link to='/reviews'>Browse reviews</Link></li>
    </ul>
  )
}

export default SideNav;
