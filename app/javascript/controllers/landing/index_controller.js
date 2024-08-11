import { Controller } from "@hotwired/stimulus"
//import "flowbite";

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
      $('.odd').addClass('animate__animated animate__fadeInUp');
      $('.even').addClass('animate__animated animate__fadeInUp');
      $('.odd, .even').attr("data-wow-duration", "2s");
      $('.odd,  .even').attr("data-wow-delay", ".5s");
    });

    // Other functions you want to execute when controller is connected
  }

  // Optional function for when controller is disconnected, can remove
  disconnect() {
  }
  
  consentGranted() {
    console.log("granted");
  };


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
