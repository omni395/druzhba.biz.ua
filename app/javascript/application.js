import "@hotwired/turbo-rails";
import "./controllers";
import "flowbite";
import 'flowbite-datepicker';

// WOW.js for animation
new WOW({offset: 50, live: true}).init();

// Trix as rich text area
import "trix";
import "@rails/actiontext";

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