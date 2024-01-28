import React, { useState, useEffect } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";

const EditStatement = () => {
  const itemAttr = ["name", "amount_pennies", "statement_type", "id", "_destroy"]
  const navigate = useNavigate();
  const params = useParams();
  const [itemFormValues, setItemFormValues] = useState([])
  const [toBeDeleted, setToBeDeleted] = useState([])
  const emptyFormAttributes = { "name": "","amount_pennies": "","statement_type": "0","id": "", "_destroy": "" }

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
       return setItemFormValues(res.statement_items)
      })
      .catch(() => navigate("/react"))
  }, []);

  const handleChange = (i, e) => {
    let newFormValues = [...itemFormValues];
    newFormValues[i][e.target.name] = e.target.value;
    setItemFormValues(newFormValues);
  }

  const addFormFields = () => {
    setItemFormValues([...itemFormValues, emptyFormAttributes])
  }

  const removeFormFields = (i) => {
    let newFormValues = [...itemFormValues];
    debugger
    if (newFormValues[i].id) {
      setToBeDeleted([...toBeDeleted, { id: newFormValues[i].id, _delete: '1' }])
    }
    newFormValues.splice(i, 1);
    setItemFormValues(newFormValues)
  }

  const onSubmit = (event) => {
    const body = {
      statement: { 
        items: [...itemFormValues, ...toBeDeleted]
      }
    }
    event.preventDefault();
    const url = "/api/v1/statements/create";

    const token = document.querySelector('meta[name="csrf-token"]').content;
    debugger
    fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    })
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((response) => navigate(`/react/statement/${response.id}`))
      .catch((error) => console.log(error.message));
  };

  statementItems = itemFormValues.map((item, index) => (
    <div className="form-row align-items-center" key={index}>
      <div className="col-auto">
        <label className="sr-only" htmlFor={`statement_item_${index}_name`}>Name</label>
        <input
          type="text" 
          name="name"
          defaultValue={item.name}
          className="form-control mb-2"
          id={`statement_item_${index}_name`}
          onChange={(event)=> handleChange(index, event)}
          />
      </div>

      <div className="col-auto">
        <label className="sr-only" htmlFor={`statement_item_${index}_amount_pennies`}>Amount</label>
          <input 
            name="amount_pennies"
            defaultValue={item.amount_pennies}
            type="number"
            step=".01"
            className="form-control"
            id={`statement_item_${index}_amount_pennies`}
            placeholder="Amount"
            onChange={(event)=> handleChange(index, event)}
          />
      </div>

      <div className="col-auto">
        <label className="sr-only" htmlFor={`statement_item_${index}_statement_type`}>Type</label>
        <select 
          name="statement_type"
          className="form-selec"
          defaultValue={item.statement_type == 'expenditure' ? '0' : '1' }
          id={`statement_item_${index}_statement_type`}
          onChange={(event)=> handleChange(index, event)}
          >
          
          <option value="0">expenditure</option>
          <option value="1">income</option>
        </select>
      </div>

      <input type="hidden" className="form-control" id={`statement_item_${index}_id`} />

      <div className="col-auto">
        <a onClick={() => removeFormFields(index)} className="btn btn-danger mb-2">X</a>
      </div>

    </div>
))

  return (
    <div className="container mt-5">
      <h1 className="font-weight-normal mb-5">
        Add a new statement.
      </h1>
        <button 
        onClick={addFormFields}
        className="btn btn-primary mt-3">
          Add new statement
        </button>
      <form onSubmit={onSubmit} className="form-inline">
        <div className="row">
          { statementItems }
        </div>
        <button type="submit" className="btn btn-primary mt-3">
          Create statement
        </button>
      </form>
    </div>

  );
}

export default EditStatement