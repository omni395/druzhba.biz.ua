// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./admin/controllers"

// Chartkick for grafs and charts in dashboard
import "chartkick/chart.js"

// Trix as rich text area
import "trix"
import "@rails/actiontext"

import('@rails/activestorage')
    .then(ActiveStorage => { ActiveStorage.start() })
    .catch()

document.currentModals = []

$(document).ready(function(){
    $('[data-toggle="popover"]').popover();
  });