import React, { useState, useEffect } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";

const StatementForm = (props) => {
  // items={itemFormValues}
  // onAddFormFields={addFormFields}
  // onHandleChange={handleChange}
  // onSubmit={onSubmit}
  // onRemoveItem={removeFormFields}

  statementItems = props.items.map((item, index) => (
    <div className="form-row align-items-center" key={index}>
      <div className="col-auto">
        <label className="sr-only" htmlFor={`statement_item_${index}_name`}>Name</label>
        <input
          type="text" 
          name="name"
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
          onChange={(event)=> props.onHandleChange(index, event)}>
          
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
        Add a new statement.
      </h1>
        <button 
        onClick={props.onAddFormFields}
        className="btn btn-primary mt-3">
          Add new statement
        </button>
      <form onSubmit={props.onSubmit} className="form-inline">
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

export default StatementForm