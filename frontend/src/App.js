import React from 'react';
import './App.css';
import {
  BrowserRouter as Router,
  Switch,
  Route,
} from "react-router-dom";

// components
import { Restaurants } from './containers/Restaurants.jsx';
import { Foods } from './containers/Foods.jsx';
import { Orders } from './containers/Orders.jsx';

function App() {
  return (
    <Router>
      <Switch>
        { /* 店舗一覧ページ */}
        <Route
          exact
          path="/restaurants">
          <Restaurants />
          printf("Hello, World!");
        </Route>
        { /* フード一覧ページ */}
        <Route
          exact
          path="/foods"
        >
          <Foods />
        </Route>
        { /* 注文ページ */}
        <Route
          exact
          path="/orders">
          <Orders />
        </Route>

        {/* #レストランの欄からのみ値を取ってくることができるのでこのように書く */}
        <Route
          exact
          path="/restaurants/:restaurantsId/foods"
          render={({ match }) =>
            <Foods
              match={match}
            />
          }
        />
      </Switch>
    </Router>
  );
}

export default App;
