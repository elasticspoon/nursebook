import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal", "innerField", "outerField"];
  static values = {
    username: String,
  };

  connect() {
    this.modalTarget.addEventListener("close", () => {
      this.close();
    });
  }

  show() {
    this.modalTarget.showModal();
  }

  setOuterValue(value) {
    if (value === "") {
      this.outerFieldTarget.textContent = `Whats on your mind, ${this.usernameValue}?`;
    } else {
      this.outerFieldTarget.textContent = value;
    }
  }

  close() {
    // TODO: this broke for some reason
    this.setOuterValue(this.innerFieldTarget.value);
    this.modalTarget.close();
  }
}
