import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="landing--gallery"
export default class extends Controller {
  connect() {
    this.toggleButtons = this.element.querySelectorAll('[data-modal-toggle]');
    this.hideButtons = this.element.querySelectorAll('[data-modal-hide]');
    
    this.toggleButtons.forEach(button => {
      button.addEventListener('click', (event) => {
        event.preventDefault(); // Предотвращаем стандартное поведение
        const modalId = button.dataset.modalToggle;
        const modal = document.getElementById(modalId);
        if (modal) {
          modal.classList.remove('hidden');
        }
      });
    });

    this.hideButtons.forEach(button => {
      button.addEventListener('click', (event) => {
        event.preventDefault(); // Предотвращаем стандартное поведение
        const modalId = button.dataset.modalHide;
        const modal = document.getElementById(modalId);
        if (modal) {
          modal.classList.add('hidden');
        }
      });
    });

    // Обработчик клика вне модального окна
    document.addEventListener('click', (event) => {
      const modals = document.querySelectorAll('[id^="image-modal-"]');
      modals.forEach(modal => {
        if (!modal.classList.contains('hidden') && event.target === modal) {
          modal.classList.add('hidden');
        }
      });
    });
  }
}