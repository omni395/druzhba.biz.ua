import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    document.addEventListener('DOMContentLoaded', () => {
      this.exFunction();
    });
    //this.loadAdsScript();
  }

  /*
  loadAdsScript() {
    window.addEventListener('load', () => {
      const script = document.createElement('script');
      script.async = true;
      script.defer = true;
      script.crossOrigin = "anonymous";
      script.nonce = true; // Ensure nonce is set correctly if required
      script.src = "https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-3829218691602401";
      
      script.onload = () => {
        console.log("Скрипт рекламы загружен успешно.");
      };
  
      script.onerror = (error) => {
        console.error("Ошибка загрузки скрипта рекламы:", error);
      };
  
      document.head.appendChild(script);
    });
  }
  */

  exFunction() {    
    // Плавная прокрутка
    document.querySelectorAll('a[href*="#"]').forEach(function(anchor) {
      anchor.addEventListener('click', function(e) {
          e.preventDefault(); // Отменяем стандартное поведение ссылки

          const targetId = this.getAttribute('href'); // Получаем значение атрибута href
          const targetElement = document.querySelector(targetId); // Находим целевой элемент

          if (targetElement) {
              // Плавная прокрутка
              window.scrollTo({
                  top: targetElement.getBoundingClientRect().top + window.scrollY,
                  behavior: 'smooth' // Параметр для плавной прокрутки
              });
          }
      });
    });

    // Toggle the modal
    const openContactFormButton = document.getElementById('openContactForm');
    const closeContactFormButton = document.getElementById('closeContactForm');
    const contactFormModal = document.getElementById('contactFormModal');
    
    openContactFormButton.addEventListener('click', () => {
        contactFormModal.classList.remove('hidden');
    });

    closeContactFormButton.addEventListener('click', () => {
        contactFormModal.classList.add('hidden');
    });

    // Toggle nav menu
    const toggleNavMenu = document.getElementById('toggleNavMenu');
    const navMenu = document.getElementById('navMenu');
    toggleNavMenu.addEventListener('click', () => {
        navMenu.classList.toggle('hidden');
    });

    // Animation effects with aos.js
    document.addEventListener('turbo:load', () => {
      AOS.init({
        'offset': 250,
        'duration': 800,
        'easing': 'ease-in-sine'
      });
    });
  }
}