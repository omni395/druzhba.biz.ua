import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo"
export default class extends Controller {
  connect() {
    this.disableTurboForLinks();
    console.log('connected');
  }
  // Запретить turbo
  disableTurboForLinks() {
    const links = this.element.querySelectorAll('a');
    console.log('connected');
    links.forEach(link => {
      link.setAttribute('data-turbo', 'false')
    });
  }
}
