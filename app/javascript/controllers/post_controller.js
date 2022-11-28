import { add, Controller } from "@hotwired/stimulus";

// Connects to data-controller="post"
export default class extends Controller {
  static targets = [
    "likeButton",
    "likeCount",
    "likeIcon",
    "commentList",
    "newComment",
  ];
  static values = { liked: Boolean, count: Number, currentUserName: String };

  connect() {}

  toggleLiked() {
    this.likedValue = !this.likedValue;
    if (this.countValue > 0) {
      this.likeCountTarget.textContent = this.likedValue
        ? `You and ${this.countValue} others`
        : `${this.countValue}`;
    } else {
      this.likeCountTarget.textContent = this.likedValue
        ? this.currentUserNameValue
        : "";
      this.toggleElement(this.likeIconTarget);
    }
  }

  toggleElement(element) {
    element.classList.toggle("hidden");
  }

  toggleCommentList(event) {
    this.toggleElement(this.commentListTarget);
    this.addPreventDefault(event);
  }

  toggleNewComment(event) {
    this.toggleElement(this.newCommentTarget);
    this.addPreventDefault(event);
  }

  addPreventDefault(event) {
    var default_action = event.target.getAttribute("data-action");
    event.target.setAttribute("data-action", default_action + ":prevent");
  }
}
