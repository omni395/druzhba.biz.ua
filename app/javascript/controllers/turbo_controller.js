import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo"
export default class extends Controller {
  connect() {
    this.disableTurboForLinks();
  }
  // Запретить turbo
  disableTurboForLinks() {
    const links = this.element.querySelectorAll('a');
    links.forEach(link => {
      link.setAttribute('data-turbo', 'false')
    });
  }
}
