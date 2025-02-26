import React from "react";

import { Route, Switch, BrowserRouter as Router } from "react-router-dom";

import Dashboard from "components/Dashboard";

import NavBar from "./components/NavBar";

const App = () => (
  <Router>
    <NavBar />
    <Switch>
      <Route
        exact
        path="/"
        render={() => <div className="bg-slate-500">Home</div>}
      />
      <Route exact path="/about" render={() => <div>About</div>} />
      <Route exact component={Dashboard} path="/dashboard" />
    </Switch>
  </Router>
);

export default App;
