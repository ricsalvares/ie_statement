import React from "react";
import { Link } from "react-router-dom";
const StatementForm = (props) => {

  textBySection = (section) => {
    const texts = {
      "header": { 
        "update": "Updating statement.", 
        "create": "Creating a new statement."
      },
      "submit": { 
        "update": "Update", 
        "create": "Create"
      }
    }


    return texts[section][props.action]
  }

  statementItems = props.items.map((item, index) => (
    <div className="form-row align-items-center" key={index}>
      <div className="col-auto">
        <label className="sr-only" htmlFor={`statement_item_${index}_name`}>Name</label>
        <input
          type="text" 
          name="name"
          defaultValue={item.name}
          className="form-control mb-2"
          id={`statement_item_${index}_name`}
          onChange={(event)=> props.onHandleChange(index, event)}
          />
      </div>

      <div className="col-auto">
        <label className="sr-only" htmlFor={`statement_item_${index}_amount_pennies`}>Amount</label>
          <input 
            name="amount_pennies"
            type="number"
            defaultValue={item.amount_pennies}
            step=".01"
            className="form-control"
            id={`statement_item_${index}_amount_pennies`}
            placeholder="Amount"
            onChange={(event)=> props.onHandleChange(index, event)}
          />
      </div>

      <div className="col-auto">
        <label className="sr-only" htmlFor={`statement_item_${index}_statement_type`}>Type</label>
        <select 
          name="statement_type"
          className="form-selec"
          id={`statement_item_${index}_statement_type`}
          onChange={(event)=> props.onHandleChange(index, event)}
          defaultValue={item.statement_type == 'income' ? '1' : '0' }>
          <option value="0">expenditure</option>
          <option value="1">income</option>
        </select>
      </div>

      <input type="hidden" className="form-control" id={`statement_item_${index}_id`} />

      <div className="col-auto">
        <a onClick={() => props.onRemoveItem(index)} className="btn btn-danger mb-2">X</a>
      </div>

    </div>
))

  return (
    <div className="container mt-5">
      <h1 className="font-weight-normal mb-5">
        {textBySection('header')} 
      </h1>
      <Link to={props.backUrl} className="btn btn-link">Back</Link>
      <div className="text-end mb-3">
        <button 
          onClick={props.onAddFormFields}
          className="btn btn-primary mt-3">
          Add new statement
        </button>
      </div>
      <form onSubmit={props.onSubmit} className="form-inline">
        <div className="row">
          { statementItems }
        </div>
        <div className="text-end mb-3">
          <button type="submit" className="btn btn-primary mt-3">
            {textBySection("submit")}
          </button>
        </div>
      </form>
    </div>

  );
}

export default StatementForm