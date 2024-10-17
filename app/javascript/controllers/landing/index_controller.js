import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.loadFlowbiteStylesheet();
    this.loadFlowbiteScript();
    this.loadAdsScript();
    this.exFunction();

    document.addEventListener('turbo:load', () => {
      this.initializeModals(); // Инициализация модальных окон при загрузке страницы
    });
  }

  loadAdsScript() {
    window.addEventListener('load', () => {
      const script = document.createElement('script');
      script.async = true;
      script.crossOrigin = "anonymous";
      script.nonce = true; // Добавьте nonce, если требуется
      script.src = "https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-3829218691602401";
      document.head.appendChild(script);
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