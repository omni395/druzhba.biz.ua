import { Controller } from "@hotwired/stimulus";

const postControllerIndexFilePath = "app/javascript/controllers/landing/index_controller.js"

export default class extends Controller {
  initialize() {
  }

  connect() {
    this.exFunction();
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

