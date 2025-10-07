document.addEventListener('DOMContentLoaded', function() {
  // Cerrar alerts al hacer click en el botón
  const closeButtons = document.querySelectorAll('.alert .btn-close');
  
  closeButtons.forEach(button => {
    button.addEventListener('click', function() {
      const alert = this.closest('.alert');
      alert.style.opacity = '0';
      setTimeout(() => {
        alert.remove();
      }, 200);
    });
  });

  // Auto-cerrar alerts después de 5 segundos (opcional)
  const alerts = document.querySelectorAll('.alert');
  alerts.forEach(alert => {
    setTimeout(() => {
      if (alert.parentNode) {
        alert.style.opacity = '0';
        setTimeout(() => {
          if (alert.parentNode) {
            alert.remove();
          }
        }, 300);
      }
    }, 5000);
  });
});