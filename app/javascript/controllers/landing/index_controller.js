import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="landing--gallery"
export default class extends Controller {
  connect() {
    // Получаем все кнопки для открытия и закрытия модальных окон
    this.toggleButtons = this.element.querySelectorAll('[data-modal-toggle]');
    this.hideButtons = this.element.querySelectorAll('[data-modal-hide]');
    this.disableTurboForLinks();
    
    // Обработчик для открытия модального окна
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

    // Обработчик для закрытия модального окна
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

    // Обработчик клика вне модального окна для закрытия
    document.addEventListener('click', (event) => {
      const modals = document.querySelectorAll('[id^="image-modal-"]');
      modals.forEach(modal => {
        if (!modal.classList.contains('hidden') && event.target === modal) {
          modal.classList.add('hidden');
        }
      });
    });
  }
  // Запретить turbo
  disableTurboForLinks() {
    const links = this.element.querySelectorAll('a');
    links.forEach(link => {
      link.setAttribute('data-turbo', 'false')
    });
  }
}