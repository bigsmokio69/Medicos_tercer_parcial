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