function showDetails( name, ap, am, birthday, chronicDiseases, allergies, familyHistory, appointment, image, idPac) {
    document.getElementById('patient-name').innerText = name;
    document.getElementById('patient-ap').innerText = ap;
    document.getElementById('patient-am').innerText = am;
    document.getElementById('patient-birthday').innerText = birthday;
    document.getElementById('patient-chronicDiseases').innerText = chronicDiseases; // Aquí puedes añadir los datos correspondientes
    document.getElementById('patient-allergies').innerText = allergies; // Aquí puedes añadir los datos correspondientes
    document.getElementById('patient-familyHistory').innerText = familyHistory; // Aquí puedes añadir los datos correspondientes
    document.getElementById('patient-appointment').innerText = appointment; // Aquí puedes añadir los datos correspondientes
    document.getElementById('profile-picture').src = image || 'img/default-profile.png';; // Cambia la fuente de la imagen de perfil según el paciente

    document.getElementById('hid_pacId').value=idPac; // Para obtener el id en el modal de expediente
}

// Selecciona todos los botones de detalles
const detailsButtons = document.querySelectorAll('.details-button button');

// Añadir un evento de clic a cada botón de detalles
detailsButtons.forEach(button => {
    button.addEventListener('click', function() {
        const containerReceta = this.closest('.container-receta');

        // Alterna la clase 'expanded' en el contenedor de la receta
        containerReceta.classList.toggle('expanded');

        // Cambia el texto del botón entre "Detalles" y "Ocultar"
        if (containerReceta.classList.contains('expanded')) {
            this.textContent = 'Ocultar';
        } else {
            this.textContent = 'Detalles';
        }
    });
});

document.getElementById('show-all-btn').addEventListener('click', function() {
    const appointments = document.querySelectorAll('.appointment-item');
    
    appointments.forEach(function(appointment) {
        appointment.style.display = 'flex'; // Muestra todas las citas
    });

    // Opcional: Limpiar el campo de fecha después de mostrar todas las citas
    document.getElementById('appointment-date').value = '';
});

document.getElementById('patient-name-filter').addEventListener('input', function() {
    const selectedName = this.value.toLowerCase();
    const appointments = document.querySelectorAll('.appointment-item');
    
    appointments.forEach(function(appointment) {
        const patientName = appointment.querySelector('.appointment-info p').textContent.toLowerCase();
        if (patientName.includes(selectedName)) {
            appointment.style.display = 'flex';
        } else {
            appointment.style.display = 'none';
        }
    });
});

document.getElementById('appointment-date').addEventListener('input', function() {
    const selectedDate = this.value;
    const appointments = document.querySelectorAll('.appointment-item');
    
    appointments.forEach(function(appointment) {
        const appointmentDate = appointment.getAttribute('data-date');
        if (appointmentDate === selectedDate) {
            appointment.style.display = 'flex';
        } else {
            appointment.style.display = 'none';
        }
    });
});




