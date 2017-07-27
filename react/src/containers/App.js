import React from 'react';
import {
 BrowserRouter as Router,
 Route,
 Switch,
 Link
} from 'react-router-dom';

import SideNav from '../components/SideNav'
import AlbumsIndexContainer from './AlbumsIndexContainer';
import AlbumFormContainer from './AlbumFormContainer';
import EditAlbumFormContainer from './EditAlbumFormContainer';
import ReviewFormContainer from './ReviewFormContainer';
import AlbumShow from './AlbumShow';
import SearchContainer from './SearchContainer'

const Home = () => {
  return (
    <div>Home</div>
  )
}

const App = ({ }) => {
  return (
    <Router>
      <div>
        <div className='large-3 medium-4 columns side-bar'>
          <div className='hide-for-small'>
            <SideNav/>
          </div>
        </div>
        <div className='large-9 medium-8 columns page-container'>
          <Switch>
            <Route exact path='/' component={Home} />
            <Route exact path='/albums' component={AlbumsIndexContainer} />
            <Route exact path='/albums/search' component={SearchContainer} />
            <Route exact path='/albums/new' component={AlbumFormContainer} />
            <Route exact path='/albums/:id/edit' component={EditAlbumFormContainer} />
            <Route exact path='/albums/:id' component={AlbumShow} />
            <Route path='/albums/:id/reviews/new' component={ReviewFormContainer} />
          </Switch>
        </div>
      </div>
    </Router>
  )
}

export default App;
