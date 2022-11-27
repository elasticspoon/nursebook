import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="button-modifier"
export default class extends Controller {
  static targets = ["button", "form"];
  connect() {}

  likeObject(event) {
    // Do something
    // event.preventDefault();
    // console.log(event);
    this.buttonTarget.classList.add("post__social-button--selected");
  }
}
