import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["star", "input", "submit"]
  static values = { score: Number }

  connect() {
    this.updateStars()
    if (this.hasSubmitTarget) {
      this.submitTarget.disabled = true
      this.submitTarget.style.opacity = "0.5"
    }
  }

  select(event) {
    this.scoreValue = parseInt(event.currentTarget.dataset.score)
    if (this.hasInputTarget) {
      this.inputTarget.value = this.scoreValue
    }
    if (this.hasSubmitTarget) {
      this.submitTarget.disabled = false
      this.submitTarget.style.opacity = "1"
    }
    this.updateStars()
  }

  updateStars() {
    this.starTargets.forEach((star, index) => {
      if (index < this.scoreValue) {
        star.style.opacity = "1"
      } else {
        star.style.opacity = "0.2"
      }
    })
  }
}
