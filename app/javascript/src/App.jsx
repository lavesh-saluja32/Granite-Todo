import React from "react";

import { Route, Switch, BrowserRouter as Router } from "react-router-dom";

import Dashboard from "components/Dashboard";
import CreateTask from "components/Tasks/Create";

import NavBar from "./components/NavBar";

const App = () => (
  <Router>
    <NavBar />
    <Switch>
      <Route exact component={Dashboard} path="/dashboard" />
      <Route exact component={CreateTask} path="/tasks/create" />
    </Switch>
  </Router>
);

export default App;
