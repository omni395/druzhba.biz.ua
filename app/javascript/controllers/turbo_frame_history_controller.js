import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-frame-history"
export default class extends Controller {
  connect() {
    useMutation(this, { attributes: true })
    if(this.element.dataset.mutateOnConnect) {
      this.mutate([{ type: 'attributes', attributeName: 'src' }])
    }
  }
}
