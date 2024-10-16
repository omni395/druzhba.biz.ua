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
          // Инициализация модального окна Flowbite
          Flowbite.Modal.init(modal);
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
        }
      });
    });
  }
}