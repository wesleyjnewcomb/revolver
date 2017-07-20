import React from 'react';
import {
 BrowserRouter as Router,
 Route,
 Switch,
 Link
} from 'react-router-dom';
import AlbumsIndexContainer from './AlbumsIndexContainer';
import AlbumFormContainer from './AlbumFormContainer'

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

      </div>
    </Router>
  )
}

export default App;
