import React from 'react';
import {
 BrowserRouter as Router,
 Route,
 Switch,
 Link
} from 'react-router-dom';
import AlbumsIndexContainer from './AlbumsIndexContainer';

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
        <Route path='/albums' component={AlbumsIndexContainer} />
      </div>
    </Router>
  )
}

export default App;
