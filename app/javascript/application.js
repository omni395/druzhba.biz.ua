import "@hotwired/turbo-rails";
import "./controllers";
// WOW.js for animation
// import WOW from "./src/WOW.js";
// Trix as rich text area
import "trix";
import "@rails/actiontext";
// Chartkick for grafs and charts in dashboard
import "chartkick/chart.js";
import jquery from "jquery";

window.jQuery = jquery;
window.$ = jquery;

/*
var wow = new WOW({
  animateClass: 'animated',
  offset: 100
});
wow.init();
*/