import * as React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Home from "../components/Home";
import Statements from "../components/Statements";
import Statement from '../components/Statement';
import NewStatement from '../components/NewStatement';
import EditStatement from '../components/EditStatement';

export default (
  <Router>
    <Routes>
      <Route path="/react" element={<Home />} />
      <Route path="/react/statements" element={<Statements />} />        
      <Route path="/react/statement/:id" element={<Statement />} />
      <Route path="/react/statement" element={<NewStatement />} />
      <Route path="/react/statement/:id/edit" element={<EditStatement/>} />
    </Routes>
  </Router>
);