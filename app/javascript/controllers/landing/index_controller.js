import { Controller } from "@hotwired/stimulus"
import "flowbite";

const postControllerIndexFilePath = "app/javascript/controllers/landing/index_controller.js"

// Connects to data-controller="posts--index"
export default class extends Controller {

  // Optional function for when controller is initialized, can remove
  initialize(){
    //console.log(`${postControllerIndexFilePath} initialized`)
  }

  // Optional function for when controller is connected, can remove
  connect(){
    //console.log(`${postControllerIndexFilePath} connected`)
    this.exFunction();
    // import "flowbite";
    window.document.addEventListener('turbo:load', (event) => {
      // trigger flowbite events
      window.document.dispatchEvent(new Event("DOMContentLoaded", {
        bubbles: true,
        cancelable: true,
        carousel: true,
        dropdown: true,
        modal: true
      }));
    });
    // Other functions you want to execute when controller is connected
  }

  // Optional function for when controller is disconnected, can remove
  disconnect() {
    //console.log(`${postControllerIndexFilePath} disconnected`)
  }

  exFunction() {
    //console.log("\nsuper cool exFunction function")

    // Disable Turbo
    //Turbo.setFormMode("off");
    
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
