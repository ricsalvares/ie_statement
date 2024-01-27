import React from "react";
import { createRoot } from "react-dom/client";
import App from "./App";

document.addEventListener("turbo:load", () => {
  console.log('addEventListener("turbo:load",')
  const el = document.getElementById("root")

  if (el) {
    const root = createRoot(el) 
    root.render(<App />);
  }
});