import * as React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import HelloWorld from "../components/HelloWorld";
import Statements from "../components/Statements";
import Statement from '../components/Statement';
import NewStatement from '../components/NewStatement';
import EditStatement from '../components/EditStatement';
// import Recipes from "../components/Recipes";
// import Recipe from "../components/Recipe";
// import NewRecipe from "../components/NewRecipe";

export default (
  <Router>
    <Routes>
      <Route path="/react" element={<HelloWorld />} />
      <Route path="/react/statements" element={<Statements />} />        
      <Route path="/react/statement/:id" element={<Statement />} />
      <Route path="/react/statement" element={<NewStatement />} />
      <Route path="/react/statement/:id/edit" element={<EditStatement/>} />
    </Routes>
  </Router>
);