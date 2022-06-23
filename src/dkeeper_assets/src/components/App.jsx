import React, { useState, useEffect } from "react";
import Header from "./Header";
import Footer from "./Footer";
import Note from "./Note";
import CreateArea from "./CreateArea";
//importamos el archivo dkeeper de la carpeta declaration, donde se almacenan todas las funciones públicas que creamos cada que usamos el comando "dfx deploy "
import { dkeeper } from "../../../declarations/dkeeper";

function App() {
  const [notes, setNotes] = useState([]);

  function addNote(newNote) {
    setNotes(prevNotes => {
      dkeeper.createNote(newNote.title, newNote.content);
      return [newNote, ...prevNotes];
    });
  }
  //Acá usamos el hook useEffect, el cual hace algo cuando la página se renderiza, en este caso llamar a fetchData para que lea el array que creamos en main.mo. El array vacio al final sirve para evitar que la función se ejecute infinitamente (leer la doc de React hooks: useEffect).
  useEffect(()=> {
    console.log("useEffect triggered");
    fetchData();
  }, []);

  //Esta función llama a la funcion de main.mo que creamos para leer todas las notas. Usamos await para esperar a que el array este lista y le asignamos el valor del array que esta almacenado en el back end, a nuestro array en el frontend, para que se renderize completo cada vez que cargamos la página. 
  async function fetchData() {
    const notesArray = await dkeeper.readNotes();
    setNotes(notesArray);
  }

  function deleteNote(id) {
    setNotes(prevNotes => {
      return prevNotes.filter((noteItem, index) => {
        return index !== id;
      });
    });
  }

  return (
    <div>
      <Header />
      <CreateArea onAdd={addNote} />
      {notes.map((noteItem, index) => {
        return (
          <Note
            key={index}
            id={index}
            title={noteItem.title}
            content={noteItem.content}
            onDelete={deleteNote}
          />
        );
      })}
      <Footer />
    </div>
  );
}

export default App;
