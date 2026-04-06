import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  toggle() {
    this.formTarget.classList.toggle("hidden")
  }

  reset() {
    this.formTarget.classList.add("hidden")
    this.formTarget.querySelectorAll("input[type=text], input[type=url], textarea").forEach(el => {
      el.value = ""
    })
  }
}
