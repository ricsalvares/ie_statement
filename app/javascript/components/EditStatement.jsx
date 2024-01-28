import React, { useState, useEffect } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";
import StatementForm from "./StatementForm";

const EditStatement = () => {
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
      .then((res) => setItemFormValues(res.statement_items))
      .catch(() => navigate(`/react/statement/${params.id}`))
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
    if (newFormValues[i].id) {
      setToBeDeleted([...toBeDeleted, { ...newFormValues[i],  _destroy: '1' }])
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
    const url = `/api/v1/statements/${params.id}`;
    const token = document.querySelector('meta[name="csrf-token"]').content;

    fetch(url, {
      method: "PUT",
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
      action={"update"}
      backUrl={`/react/statement/${params.id}`}
    />
  );
}

export default EditStatement