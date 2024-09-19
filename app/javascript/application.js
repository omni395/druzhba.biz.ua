import "@hotwired/turbo-rails";
import "./controllers";

// Trix as rich text area
import "trix";
import "@rails/actiontext";

// Chartkick for grafs and charts in dashboard
import "chartkick/chart.js";
import jquery from "jquery";

window.jQuery = jquery;
window.$ = jquery;