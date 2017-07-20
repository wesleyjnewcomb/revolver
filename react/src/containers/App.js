import React from 'react';
import {
 BrowserRouter as Router,
 Route,
 Switch,
 Link
} from 'react-router-dom';
import AlbumsIndexContainer from './AlbumsIndexContainer';
import AlbumsNewFormContainer from './AlbumsNewFormContainer'

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
        <Route path='/albums/new' component={AlbumsNewFormContainer} />

      </div>
    </Router>
  )
}

export default App;
