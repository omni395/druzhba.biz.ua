// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "./controllers";
import "flowbite";
import 'flowbite-datepicker';

// Trix as rich text area
import "trix"
import "@rails/actiontext"

// Chartkick for grafs and charts in dashboard
import "chartkick/chart.js";

// Google analitics
import gtag from "./src/analitics";

// FontAwesome
import {far} from "@fortawesome/free-regular-svg-icons";
import {fas} from "@fortawesome/free-solid-svg-icons";
import {fab} from "@fortawesome/free-brands-svg-icons";
import {library} from "@fortawesome/fontawesome-svg-core";
import "@fortawesome/fontawesome-free";
library.add(far, fas, fab);

import jquery from "jquery";
window.jQuery = jquery;
window.$ = jquery;

// Disable Turbo
Turbo.setFormMode("off");

// Плавная прокрутка
var $page = $('html, body');
$('a[href*="#"]').click(function() {
    $page.animate({
        scrollTop: $($.attr(this, 'href')).offset().top
    }, 400);
    return false;
});

// Появление элеммента во время прокрутки страницы
function onEntry(entry) {
    entry.forEach(change => {
      if (change.isIntersecting) {
       change.target.classList.add('element-show');
      }
    });
  }
  
  let options = { threshold: [0.3] };
  let observer = new IntersectionObserver(onEntry, options);
  let elements = document.querySelectorAll('.element-animation');
  
  for (let elm of elements) {
    observer.observe(elm);
  }

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