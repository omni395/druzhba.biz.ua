import "@hotwired/turbo-rails";
import "./controllers";
// WOW.js for animation
import WOW from "./src/WOW.js";
// Trix as rich text area
import "trix";
import "@rails/actiontext";
// Chartkick for grafs and charts in dashboard
import "chartkick/chart.js";
import jquery from "jquery";
// Google analitics
//import gtag from "./src/analitics";
// FontAwesome
//import {far} from "@fortawesome/free-regular-svg-icons";
//import {fas} from "@fortawesome/free-solid-svg-icons";
//import {fab} from "@fortawesome/free-brands-svg-icons";
//import {library} from "@fortawesome/fontawesome-svg-core";
//import "@fortawesome/fontawesome-free";
//library.add(far, fas, fab);

window.jQuery = jquery;
window.$ = jquery;

var wow = new WOW({
  animateClass: 'animated',
  offset: 100
});
wow.init();


