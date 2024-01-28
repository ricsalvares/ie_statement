import React, { useState, useEffect } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";

const Statement = () => {
  const params = useParams();
  const navigate = useNavigate();
  const [statement, setStatement] = useState({});

  useEffect(() => {
    const url = `/api/v1/statement/show/${params.id}`
    fetch(url)
      .then((res) => {
        if (res.ok) {
          return res.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((res) => {
       return setStatement(res)
      })
      .catch(() => navigate("/react"))
  }, []);

  const deleteStatement = () => {
    const url = `/api/v1/statements/delete/${params.id}`;
    const token = document.querySelector('meta[name="csrf-token"]').content;
    if (confirm("Are you sure?") == true) {
      fetch(url, {
        method: "DELETE",
        headers: {
          "X-CSRF-Token": token,
          "Content-Type": "application/json",
        },
      })
        .then((response) => {
          if (response.ok) {
            return response.json();
          }
          throw new Error("Network response was not ok.");
        })
        .then(() => navigate("/react/statements"))
        .catch((error) => console.log(error.message));
    }
  };


  statementItemsTableRows = () => (statement.statement_items.map((item, index) => (
    <tr key={index}>
      <td>{item.id}</td>
      <td>{item.name}</td>
      <td>{item.amount_pennies}</td>
      <td>{item.statement_type}</td>      
    </tr>
  )))

  items = () => { 
    const hasItems = Boolean(statement.statement_items) && Boolean(Object.keys(statement.statement_items).length)
    if (hasItems) {
      return (<table className="table table-hover">
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Amount</th>
          <th>Type</th>
        </tr>
      </thead>
        <tbody>
          {statementItemsTableRows()}
        </tbody>
      </table>)
    }
    return (<p> No items</p>)
  }

  return (
    <div className="">
      
      <div className="container py-5">
        <div className="row">
          <div className="col-sm-12 col-lg-7">
            <ul className="list-group">
            <h5 className="mb-2">{`Id: #${statement.id}`}</h5>
            <h5 className="mb-2">{`disposable_income_pennies: £${statement.disposable_income_pennies}`}</h5>
            <h5 className="mb-2">{`ie_rating: ${statement.ie_rating}`}</h5>
              {items()}
            </ul>
          </div>
          <div className="col-sm-12 col-lg-2">
            <Link
              type="button"
              className="btn btn-primary"
              to={`/react/statement/${statement.id}/edit`}
            >
              Edit
            </Link>

            <button
              type="button"
              className="btn btn-danger"
              onClick={deleteStatement}
            >
              Delete
            </button>
          </div>
        </div>
        <Link to="/react/statements" className="btn btn-link">
          Back to statements
        </Link>
      </div>
    </div>
  );
};

export default Statement