import React from "react";
import { createRoot } from "react-dom/client";
import HelloWorld3 from "./HelloWorld3";

document.addEventListener("turbo:load", () => {
  console.log('addEventListener("turbo:load",')
  const root = createRoot(document.getElementById("root"))

  root.render(<HelloWorld3 />);
});