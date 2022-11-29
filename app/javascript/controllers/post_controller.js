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
    // this.likeButtonTarget.classList.toggle("post__social_button--selected");
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
    this.changeCommentListText(event.target);
  }

  toggleNewComment(event) {
    this.toggleElement(this.newCommentTarget);
    this.addPreventDefault(event);
  }

  changeCommentListText(element) {
    if (element.textContent == "Hide comments") {
      element.textContent = "Show comments";
    } else {
      element.textContent = "Hide comments";
    }
  }

  addPreventDefault(event) {
    var default_action = event.target.getAttribute("data-action");
    event.target.setAttribute("data-action", default_action + ":prevent");
  }
}
