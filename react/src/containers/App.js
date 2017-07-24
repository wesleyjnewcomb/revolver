import React from 'react';
import {
 BrowserRouter as Router,
 Route,
 Switch,
 Link
} from 'react-router-dom';
import AlbumsIndexContainer from './AlbumsIndexContainer';
import AlbumFormContainer from './AlbumFormContainer';
import ReviewFormContainer from './ReviewFormContainer';
import AlbumShow from './AlbumShow';

const Home = () => {
  return (
    <div>Home</div>
  )
}

const App = ({ }) => {
  return (
    <Router>
      <div>
        <Route exact path='/' component={Home} />
        <Route exact path='/albums' component={AlbumsIndexContainer} />
        <Route path='/albums/new' component={AlbumFormContainer} />
        <Route path='/albums/:id/reviews/new' component={ReviewFormContainer} />
        <Route path='/albums/:id' component={AlbumShow} />
      </div>
    </Router>
  )
}

export default App;
