import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";

const Statements = () => {
  const navigate = useNavigate();
  const [statements, setStatements] = useState([]);

  useEffect(() => {
    const url = "http://localhost:3300/api/v1/statements/index";
    fetch(url)
      .then((res) => {
        debugger
        if (res.ok) {
          return res.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((res) => 
      {debugger; return setStatements(res)})
      .catch(() => navigate("/react"))
  }, []);

  debugger
  const allStatements = statements.map((statement, index) => (
    <div key={index} className="col-md-6 col-lg-4">
      <div className="card mb-4">
        <div className="card-body">
          <h5 className="card-title">{statement.id}</h5>
          <Link to={`/recipe/${statement.id}`} className="btn custom-button">
            View Statement
          </Link>
        </div>
      </div>
    </div>
  ));

  const noStatement = (
    <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
      <h4>
        No Statements yet. Why not <Link to="#">create one</Link>
      </h4>
    </div>
  );
return (
  <>
      <section className="jumbotron jumbotron-fluid text-center">
        <div className="container py-5">
          <h1 className="display-4">Your I&E statements</h1>
          <p className="lead text-muted">
            We’ve pulled together our most popular recipes, our latest
            additions, and our editor’s picks, so there’s sure to be something
            tempting for you to try.
          </p>
        </div>
      </section>
      <div className="py-5">
        <main className="container">
          <div className="text-end mb-3">
            <Link to="#" className="btn custom-button">
              Create New Statement
            </Link>
          </div>
          <div className="row">
            {statements.length > 0 ? allStatements : noStatement}
          </div>
          <Link to="/" className="btn btn-link">
            Home
          </Link>
        </main>
      </div>
    </>
)
};

export default Statements