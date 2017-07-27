import React from 'react';
import {
 BrowserRouter as Router,
 Route,
 Switch,
 Link
} from 'react-router-dom';

import AlbumsIndexContainer from './AlbumsIndexContainer';
import AlbumFormContainer from './AlbumFormContainer';
import EditAlbumFormContainer from './EditAlbumFormContainer';
import ReviewFormContainer from './ReviewFormContainer';
import AlbumShow from './AlbumShow';
import SearchContainer from './SearchContainer'

const App = ({ }) => {
  return (
    <Router>
      <div className="page-container">
        <Switch>
          <Route exact path='/' component={AlbumsIndexContainer} />
          <Route exact path='/albums' component={AlbumsIndexContainer} />
          <Route exact path='/albums/search' component={SearchContainer} />
          <Route exact path='/albums/new' component={AlbumFormContainer} />
          <Route exact path='/albums/:id/edit' component={EditAlbumFormContainer} />
          <Route exact path='/albums/:id' component={AlbumShow} />
          <Route path='/albums/:id/reviews/new' component={ReviewFormContainer} />
        </Switch>
      </div>
    </Router>
  )
}

export default App;
