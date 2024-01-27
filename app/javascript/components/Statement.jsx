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

        debugger
       return setStatement(res[0])
      })
      .catch(() => navigate("/react"))
  }, []);

  // const deleteRecipe = () => {
  //   const url = `/api/v1/destroy/${params.id}`;
  //   const token = document.querySelector('meta[name="csrf-token"]').content;
  //   if (confirm("Are you sure?") == true) {
  //     fetch(url, {
  //       method: "DELETE",
  //       headers: {
  //         "X-CSRF-Token": token,
  //         "Content-Type": "application/json",
  //       },
  //     })
  //       .then((response) => {
  //         if (response.ok) {
  //           return response.json();
  //         }
  //         throw new Error("Network response was not ok.");
  //       })
  //       .then(() => navigate("/recipes"))
  //       .catch((error) => console.log(error.message));
  //   }
    
  // };

  items = () => { 
    a = statement
    debugger
    return (<p>item 1</p>) }

  return (
    <div className="">
      
      <div className="container py-5">
        <div className="row">
          <div className="col-sm-12 col-lg-7">
            <ul className="list-group">
            <h5 className="mb-2">{`#${statement.id} attributes:`}</h5>
              <h5 className="mb-2">{`#${statement.id} items:`}</h5>
              {items()}
            </ul>
          </div>
          <div className="col-sm-12 col-lg-2">
            <button
              type="button"
              className="btn btn-primary"
              onClick={alert}
            >
              Edit
            </button>

            <button
              type="button"
              className="btn btn-danger"
              onClick={alert}
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