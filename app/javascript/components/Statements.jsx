import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";

const Statements = () => {
  const navigate = useNavigate();
  const [statements, setStatements] = useState([]);

  useEffect(() => {
    const url = "/api/v1/statements/index";
    fetch(url)
      .then((res) => {
        if (res.ok) {
          return res.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((res) => setStatements(res))
      .catch(() => navigate("/react"))
  }, []);

const tableRows = statements.map((statement, index) => (
  <tr key={index}>
    <td>
      <Link to={`/react/statement/${statement.id}`}> { statement.id} </Link>
    </td>
    <td>{statement.user_id}</td>
    <td>{statement.created_at}</td>
    <td>
      <span >{statement.ie_rating}</span>
    </td>
    <td>{statement.disposable_income_pennies}</td>      
  </tr>
))

const allStatementsTable = (
  <div className="page-content page-container" id="page-content">
    <div className="padding">
      <div className="row d-flex justify-content-center">
        <div className="col-lg grid-margin stretch-card">
          <div className="card">
            <div className="card-body">
              <div className="table-responsive">
                <table className="table table-hover">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Created by</th>
                      <th>Created at</th>
                      <th>I&E rating</th>
                      <th>Disposable Income(£)</th>
                    </tr>
                  </thead>
                    <tbody>
                      {tableRows}
                    </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
);


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
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
          </p>
        </div>
      </section>
      <div className="py-5">
        <main className="container">
        <Link to="/react" className="btn btn-link">
            Home
          </Link>
          <div className="text-end mb-3">
            {Boolean(statements.length) && <Link to="/react/statement" className="btn btn-primary">
              Create New Statement
            </Link>}
          </div>
          <div className="row">
            {statements.length > 0 ? allStatementsTable : noStatement}
          </div>
        </main>
      </div>
    </>
)
};

export default Statements