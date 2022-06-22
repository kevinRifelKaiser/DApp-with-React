import List "mo:base/List"
import Debug "mo:base/Debug"

actor DKeeper {

  public type Note {
    title: Text;
    content: Text;
  };
  
  //creo una var para las notas, le doy de tipo "list" (este módulo igual tengo que importarlo) y a ese tipo list le doy un tipo note (que es el que cree) de la siguiente manera. Vamos a empezarla como si fuese una lista vacía y por eso hacemos List.nill y le volvemos a especificar que va a ser un tipo nota.
  var notes: List.List<Note> = List.nil<Note>();

  //Creamos una función que cuando la llamamos le pasamos un titulo y un content para la nota, y luego actualiza la lista "notes" a una que es igual a esa misma lista pero agregandole al comienzo la nueva nota.
  public func createNote(titleText: Text, contentText: Text) {    
    let newNote: Note = {
      title = titleText;
      content = contentText;
    }

    notes := List.push(newNote, notes);
    Debug.print(debug_show(notes));
    
  }

}