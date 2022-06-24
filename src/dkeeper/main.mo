import List "mo:base/List";
import Debug "mo:base/Debug";

actor DKeeper {

  public type Note = {
    title: Text;
    content: Text;
  };
  
  //creo una var para las notas, le doy de tipo "list" (este módulo igual tengo que importarlo) y a ese tipo list le doy un tipo note (que es el que cree) de la siguiente manera. Vamos a empezarla como si fuese una lista vacía y por eso hacemos List.nill y le volvemos a especificar que va a ser un tipo nota.
  //Agrego el stable para que aunque utilice "dfx deploy", no se resetee mi codigo y se eliminen las notas
  stable var notes: List.List<Note> = List.nil<Note>();

  //Creamos una función que cuando la llamamos le pasamos un titulo y un content para la nota, y luego actualiza la lista "notes" a una que es igual a esa misma lista pero agregandole al comienzo la nueva nota.
  public func createNote(titleText: Text, contentText: Text) {    
    let newNote: Note = {
      title = titleText;
      content = contentText;
    };

    notes := List.push(newNote, notes);
    Debug.print(debug_show(notes));
    
  };

  //Creo una funcion de lectura solo, que asincronamente me de devuelve un array, toma la lista de notas y lo transforma en el array que me devuelve.
  public query func readNotes(): async [Note] {
    return List.toArray(notes);
  };

  //Para elmininar elementos no existe un metodo en particular dentro del modulo list de ICP. Pero puedo usar take metodo take para sacar los elementos de la lista hasta antes del elemento que quiero borrar, luego saco de la lista inicial los primeros elementos hasta el que quiero borrar incluido, y luego concateno estas dos listas 
  public func removeNote(id: Nat) {
    let takeList = List.take(notes, id);
    let dropList = List.drop(notes, id + 1);
    notes := List.append(takeList, dropList);
  };

}