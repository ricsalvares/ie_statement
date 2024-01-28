import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import StatementForm from "./StatementForm";

const NewStatement = () => {
  const navigate = useNavigate();

  const [itemFormValues, setItemFormValues] = useState([{"name": "","amount_pennies": "","statement_type": "0","id": "","_destroy": "" }])
  const emptyFormAttributes = { "name": "","amount_pennies": "","statement_type": "0","id": "", "_destroy": "" }

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
    newFormValues.splice(i, 1);
    setItemFormValues(newFormValues)
  }

  const onSubmit = (event) => {
    const body = {
      statement: { 
        items: [...itemFormValues]
      }
    }
    
    event.preventDefault();
    const url = "/api/v1/statements/create";
    const token = document.querySelector('meta[name="csrf-token"]').content;
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

  return (
    <StatementForm 
      items={itemFormValues}
      onAddFormFields={addFormFields}
      onHandleChange={handleChange}
      onSubmit={onSubmit}
      onRemoveItem={removeFormFields}
      action={"create"}
      backUrl="/react/statements/"
    />
  );
}

export default NewStatement