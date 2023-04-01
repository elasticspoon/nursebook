import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="carousel"
export default class extends Controller {
  static targets = [
    "carouselContent",
    "carouselLeft",
    "carouselRight",
    "carouselContainer",
  ];
  static values = { index: Number, numItems: Number };

  // connect() {}

  next() {
    this.indexValue = this.indexValue + 1;
  }

  previous() {
    this.indexValue = this.indexValue - 1;
  }

  indexValueChanged(current, old) {
    console.log(this.carouselContentTarget);
    console.log(this.carouselContainer);
    this.scrollCarousel(current);
    let maxIndex = this.numItemsValue - 1;

    if (current == 0 || old == 0) {
      this.carouselLeftTarget.toggleAttribute("disabled");
    }
    if (current == maxIndex || old == maxIndex) {
      this.carouselRightTarget.toggleAttribute("disabled");
    }
  }

  scrollCarousel(index) {
    let childSize =
      this.carouselContentTarget.firstElementChild.getBoundingClientRect()
        .width;

    this.carouselContentTarget.scrollTo({
      left: childSize * index,
      behavior: "smooth",
    });
  }
}
