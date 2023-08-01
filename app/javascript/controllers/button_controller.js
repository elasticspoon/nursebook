import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="button"
export default class extends Controller {

  static targets = ["button", "content"];

  disableEmptyButton() {
    if (this.contentTarget.value.length > 0) {
      this.buttonTarget.removeAttribute("disabled");
    } else {
      this.buttonTarget.setAttribute("disabled", true);
    }
  }

  test() {
    console.log('test');
  }
}
