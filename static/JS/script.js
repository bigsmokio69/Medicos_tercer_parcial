function borrar(id, rfc) {
    let choice=confirm(`Estas seguro de borrar este registro?: ${id}, con RFC del médico: ${rfc}`)

    if (choice) {
        enviarBorrar(id)
    }
}

function enviarBorrar(id) {
    let id_borrar=id
    const xhr= new XMLHttpRequest()
    xhr.open('POST', '/borrarMed', true);
    xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
    xhr.onload = function() {};
    xhr.send(JSON.stringify({
        ID_borrar: id_borrar
    }));
}