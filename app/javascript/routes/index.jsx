import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import HelloWorld3 from "../components/HelloWorld3";
// import Recipes from "../components/Recipes";
// import Recipe from "../components/Recipe";
// import NewRecipe from "../components/NewRecipe";

export default (
  <Router>
    <Routes>
      <Route path="/" element={<HelloWorld3 />} />
      {/* <Route path="/recipes" element={<Recipes />} />        
      <Route path="/recipe/:id" element={<Recipe />} />
      <Route path="/recipe" element={<NewRecipe />} /> */}
    </Routes>
  </Router>
);