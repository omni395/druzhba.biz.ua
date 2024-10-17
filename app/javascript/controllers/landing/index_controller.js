import { Controller } from "@hotwired/stimulus";

const postControllerIndexFilePath = "app/javascript/controllers/landing/index_controller.js"

export default class extends Controller {
  initialize() {
  }

  connect() {
    this.loadFlowbiteStylesheet();
    this.loadFlowbiteScript();
    this.loadAdsScript();
    this.exFunction();
  }

  loadAdsScript() {
    window.addEventListener('load', () => { // Ждем полной загрузки страницы
      const script = document.createElement('script');
      script.async = true;
      script.crossOrigin = "anonymous";
      script.nonce = true; // Добавьте nonce, если требуется
      script.src = "https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-3829218691602401";
      document.head.appendChild(script);
    });
  }

  loadFlowbiteStylesheet() {
    const link = document.createElement('link');
    link.href = 'https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.5.1/flowbite.min.css';
    link.rel = 'stylesheet';
    link.nonce = true; // Добавьте nonce, если требуется
    document.head.appendChild(link);
  }

  loadFlowbiteScript() {
    const script = document.createElement('script');
    script.src = 'https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.5.1/flowbite.min.js';
    script.async = true;
    script.nonce = true; // Добавьте nonce, если требуется
    script.onload = () => {
      console.log('Flowbite script loaded');
      this.initializeModals(); // Инициализация модальных окон после загрузки Flowbite
    };
    document.body.appendChild(script);
  }
  
  initializeModals() {
    // Здесь вы можете инициализировать ваши модальные окна
    const modals = document.querySelectorAll('[data-modal-target]');
    modals.forEach(modal => {
      Flowbite.Modal.init(modal);
    });
  }

  exFunction() {
    // Плавная прокрутка
    var $page = $('html, body');
    $('a[href*="#"]').click(function() {
        $page.animate({
            scrollTop: $($.attr(this, 'href')).offset().top
        }, 400);
        return false;
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
    document.addEventListener('turbo:load', () => { AOS.init(
      {
        'offset': 300,
        'duration': 800,
        'easing': 'ease-in-sine'
        //'data-aos-once': true
      }
    ) });
  };
}