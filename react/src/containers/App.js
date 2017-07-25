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
      <Switch>
        <Route exact path='/' component={Home} />
        <Route exact path='/albums' component={AlbumsIndexContainer} />
        <Route exact path='/albums/new' component={AlbumFormContainer} />
        <Route exact path='/albums/:id' component={AlbumShow} />
        <Route path='/albums/:id/reviews/new' component={ReviewFormContainer} />
      </Switch>
    </Router>
  )
}

export default App;
