import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="landing--gallery"
export default class extends Controller {
  static targets = ['image']

  connect() {
    this.imageTargets.forEach((image) => {
      if (image.addEventListener) {
        image.onclick = this.toggleImage.bind(this, image);
      }
    });
  }

  toggleImage(image) {
    if (window.innerWidth >= 639) { // измените значение на необходимое
      image.classList.toggle('active');
    }
  }
}
