import "@hotwired/turbo-rails";
import "./controllers";

// Trix as rich text area
import "trix";
import "@rails/actiontext";

// Chartkick for grafs and charts in dashboard
import "chartkick/chart.js";
import jquery from "jquery";

// Flowbite turbo
import "flowbite/dist/flowbite.turbo.js";
import 'flowbite-datepicker';
//import 'flowbite/dist/datepicker.turbo.js';

window.jQuery = jquery;
window.$ = jquery;