import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="post"
export default class extends Controller {
  static targets = ["likeButton", "likeCount", "likeIcon"];
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
      this.likeIconTarget.classList.toggle("post__likes-icon--hidden");
    }
  }
}
