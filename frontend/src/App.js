import React, { useEffect, useState } from "react";

function App() {
  const [message, setMessage] = useState("");

  useEffect(() => {
    fetch("/api/hello")
      .then(res => res.text())
      .then(data => setMessage(data));
  }, []);

  return (
    <div style={{ textAlign: "center", marginTop: "50px" }}>
      <h1>Spring Boot + React (Docker)</h1>
      <h2>{message}</h2>
    </div>
  );
}

export default App;
