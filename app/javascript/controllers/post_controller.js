import { add, Controller } from "@hotwired/stimulus";

// Connects to data-controller="post"
export default class extends Controller {
  static targets = [
    "likeButton",
    "likeCount",
    "likeIcon",
    "commentList",
    "newComment",
    "newCommentLink",
    "uploadField",
    "uploadButton",
    "postContent",
    "postButton",
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
    this.addPreventDefault(event.target);
    this.changeCommentListText(event.target);
  }

  toggleNewComment() {
    this.toggleElement(this.newCommentTarget);
    this.addPreventDefault(this.newCommentLinkTarget);
  }

  changeCommentListText(element) {
    if (element.textContent == "Hide comments") {
      element.textContent = "Show comments";
    } else {
      element.textContent = "Hide comments";
    }
  }

  addPreventDefault(target) {
    var default_action = target.getAttribute("data-action");
    if (default_action && !default_action.includes(":prevent")) {
      target.setAttribute("data-action", default_action + ":prevent");
    }
  }

  addUploadField() {
    var upload_field = this.uploadFieldTarget.cloneNode(true);
    upload_field.value = "";
    upload_field.removeAttribute("data-post-target");
    upload_field.classList.remove("hidden");
    this.uploadFieldTarget.insertAdjacentElement("beforebegin", upload_field);
  }

  checkPostContent(event) {
    if (this.postContentTarget.value.length > 0) {
      this.postButtonTarget.removeAttribute("disabled");
    } else {
      this.postButtonTarget.setAttribute("disabled", true);
    }
  }
}
