import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu", "button"];

  toggle() {
    this.menuTarget.classList.toggle("hidden");
  }

  hide(event) {
    if (
      !this.buttonTarget.contains(event.target) &&
      !this.menuTarget.classList.contains("hidden")
    ) {
      this.menuTarget.classList.add("hidden");
    }
  }
}
