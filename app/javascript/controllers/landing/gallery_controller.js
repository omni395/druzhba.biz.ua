import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="landing--gallery"
export default class extends Controller {
  static targets = ['image']

  connect() {
    this.imageTargets.forEach((image) => {
      if (image.addEventListener) {
        console.log(image);
        image.onclick = this.toggleImage.bind(this, image);
      }
    });
  }

  toggleImage(image) {
    console.log('clicked');
    image.classList.toggle('active');
  }
}
