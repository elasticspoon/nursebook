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
    "uploadPreview",
    "addUploadField",
    "input",
    "postContent",
    "postButton",
    "image"
  ];
  static values = { liked: Boolean, count: Number, currentUserName: String };

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

  addImages() {
    this.toggleElement(this.addUploadFieldTarget);
  }

  addUploadField() {
    const uploadField = this.uploadFieldTarget;
    const previewContainer = uploadField.cloneNode(true);
    const uploadPreviewInput = previewContainer.querySelector("[data-placeholder]");

    previewContainer.classList.remove("hidden");
    uploadPreviewInput.value = "";
    uploadPreviewInput.addEventListener("change", this.updateImagePreview);

    this.uploadPreviewTarget.appendChild(previewContainer);
    this.uploadPreviewTarget.appendChild(this.addUploadFieldTarget);
  }

  checkPostContent() {
    if (this.postContentTarget.value.length > 0) {
      this.postButtonTarget.removeAttribute("disabled");
    } else {
      this.postButtonTarget.setAttribute("disabled", true);
    }
  }

  uploadPhoto(event) {
    if (event.target.getAttribute("data-placeholder")) {
      this.createPreview(event);
    }
    this.updateImagePreview(event);
  }

// TODO: currrent issue the multiple file upload is not working
  // both are acting as the same input
  updateImagePreview(event) {
    console.log('updating...');
    const new_image = document.createElement("img");
    new_image.classList.add("new_post__preview-image");
    new_image.src = URL.createObjectURL(event.target.files[0]);

    const container = event.target.parentElement;
    container.lastElementChild.remove();
    container.appendChild(new_image);
  }

  deletePreview(event) {
    const preview = event.target.closest(".new_post__image-upload")
    preview.remove();
  }

  createPreview() {
    const uploadPreviewContainer = this.uploadFieldTarget;
    const uploadPlaceholderContainer = uploadPreviewContainer.cloneNode(true);
    const uploadPreviewInput = uploadPreviewContainer.querySelector("[data-placeholder]");

    uploadPreviewInput.addEventListener("change", (e) => { this.uploadPhoto(e) });
    uploadPreviewInput.removeAttribute("data-placeholder");

    uploadPreviewContainer.removeAttribute("data-post-target");
    
    this.uploadPreviewTarget.appendChild(uploadPlaceholderContainer);
    this.uploadPreviewTarget.appendChild(this.addUploadFieldTarget);
  }
}
