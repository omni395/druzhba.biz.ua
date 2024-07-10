import { Controller } from "@hotwired/stimulus"
import "flowbite";

const postControllerIndexFilePath = "app/javascript/controllers/landing/index_controller.js"

// Connects to data-controller="posts--index"
export default class extends Controller {

  // Optional function for when controller is initialized, can remove
  initialize(){
  }

  // Optional function for when controller is connected, can remove
  connect(){
    this.exFunction();
    window.addEventListener('load', function(){
      $('#hero-section-1').addClass('animate__animated animate__fadeInLeft');
      $('#hero-section-1').attr("data-wow-duration", "2s");
      $('#hero-section-1').attr("data-wow-delay", ".5s");

      $('#services').addClass('animate__animated animate__fadeInRight');
      $('#services').attr("data-wow-duration", "2s");
      $('#services').attr("data-wow-delay", ".5s");

      $('#hero-section-2').addClass('animate__animated animate__fadeInLeft');
      $('#hero-section-2').attr("data-wow-duration", "2s");
      $('#hero-section-2').attr("data-wow-delay", ".5s");

      $('#about').addClass('animate__animated animate__fadeInRight');
      $('#about').attr("data-wow-duration", "2s");
      $('#about').attr("data-wow-delay", ".5s");

      $('#hero-section-1').addClass('animate__animated animate__fadeInLeft');
      $('#hero-section-1').attr("data-wow-duration", "2s");
      $('#hero-section-1').attr("data-wow-delay", ".5s");

      $('#faq').addClass('animate__animated animate__fadeInRight');
      $('#faq').attr("data-wow-duration", "2s");
      $('#faq').attr("data-wow-delay", ".5s");

      $('#contacts').addClass('animate__animated animate__fadeInLeft');
      $('#contacts').attr("data-wow-duration", "2s");
      $('#contacts').attr("data-wow-delay", ".5s");
    });
    // Other functions you want to execute when controller is connected
  }

  // Optional function for when controller is disconnected, can remove
  disconnect() {
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
  };
}
