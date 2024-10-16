import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="landing--gallery"
export default class extends Controller {
  connect() {
    this.toggleButtons = this.element.querySelectorAll('[data-modal-toggle]'); // Исправлено на data-modal_toggle
    this.hideButtons = this.element.querySelectorAll('[data-modal-hide]'); // Исправлено на data-modal_hide

    this.toggleButtons.forEach(button => {
      button.addEventListener('click', (event) => {
        event.preventDefault();
        const modalId = button.dataset.modalToggle; // исправлено по атрибуту
        const modal = document.getElementById(modalId);
        if (modal) {
          modal.classList.remove('hidden');
        }
      });
    });

    this.hideButtons.forEach(button => {
      button.addEventListener('click', (event) => {
        event.preventDefault();
        const modalId = button.dataset.modalHide; // исправлено по атрибуту
        const modal = document.getElementById(modalId);
        if (modal) {
          modal.classList.add('hidden');
        }
      });
    });
  }
}