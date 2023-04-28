import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal", "innerField", "outerField"];

  connect() {
    this.modalTarget.addEventListener('close', (e) => {
      this.close();
    })
  }

  show() {
    this.modalTarget.showModal();
  }

  setOuterValue() {
    this.outerFieldTarget.value = this.innerFieldTarget.value
  }

  close() {
    if (this.innerFieldTarget.value !== 'default') {
      this.setOuterValue();
    }
      this.modalTarget.close();
  }
}
