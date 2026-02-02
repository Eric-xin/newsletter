import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editor", "preview", "previewContent"]

  togglePreview() {
    const editorVisible = !this.editorTarget.classList.contains("hidden")

    if (editorVisible) {
      // Show preview
      const textarea = this.editorTarget.querySelector("textarea")
      this.previewContentTarget.innerHTML = textarea.value
      this.editorTarget.classList.add("hidden")
      this.previewTarget.classList.remove("hidden")
    } else {
      // Show editor
      this.editorTarget.classList.remove("hidden")
      this.previewTarget.classList.add("hidden")
    }
  }
}
