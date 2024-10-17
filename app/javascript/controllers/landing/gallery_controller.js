import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="landing--gallery"
export default class extends Controller {
  connect() {
    this.toggleButtons = this.element.querySelectorAll('[data-modal-toggle]');
    this.hideButtons = this.element.querySelectorAll('[data-modal-hide]');

    this.toggleButtons.forEach(button => {
      button.addEventListener('click', (event) => {
        event.preventDefault();
        const modalId = button.dataset.modalToggle; // Используйте правильный атрибут
        const modal = document.getElementById(modalId);
        if (modal) {
          modal.classList.remove('hidden');
          modal.setAttribute('aria-hidden', 'false'); // Установите aria-hidden в false
          console.log(`Opened modal: ${modalId}`); // Отладочное сообщение
          
          // Проверка наличия Flowbite перед инициализацией
          if (typeof Flowbite !== 'undefined' && Flowbite.Modal) {
            if (!modal.classList.contains('initialized')) {
              Flowbite.Modal.init(modal);
              modal.classList.add('initialized'); // Добавьте класс, чтобы избежать повторной инициализации
            }
          } else {
            console.error('Flowbite is not defined or Modal is not available.');
          }
        } else {
          console.error(`Modal with ID ${modalId} not found.`);
        }
      });
    });

    this.hideButtons.forEach(button => {
      button.addEventListener('click', (event) => {
        event.preventDefault();
        const modalId = button.dataset.modalHide; // Используйте правильный атрибут
        const modal = document.getElementById(modalId);
        if (modal) {
          modal.classList.add('hidden');
          modal.setAttribute('aria-hidden', 'true'); // Установите aria-hidden в true
          console.log(`Closed modal: ${modalId}`); // Отладочное сообщение
        } else {
          console.error(`Modal with ID ${modalId} not found.`);
        }
      });
    });
  }
}