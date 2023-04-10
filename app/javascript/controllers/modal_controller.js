import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal"];

  toggle() {
    this.modalTarget.classList.toggle("hidden");
  }

  hide() {
    this.modalTarget.classList.add("hidden");
  }

  connect() {
    document.onkeydown = (event) => {
      if (event.key == "Escape") {
        this.hide();
      }
    };
  }
}
