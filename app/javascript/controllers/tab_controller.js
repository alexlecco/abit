import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]
  static values = { active: Number }

  connect() {
    this.showTab(this.activeValue)
  }

  show(event) {
    const tab = parseInt(event.currentTarget.dataset.tab)
    this.showTab(tab)
  }

  showTab(activeTab) {
    this.tabTargets.forEach(tab => {
      const isActive = parseInt(tab.dataset.tab) === activeTab
      tab.classList.toggle("bg-teal-500/20", isActive)
      tab.classList.toggle("text-teal-300", isActive)
      tab.classList.toggle("text-slate-500", !isActive)
    })

    this.panelTargets.forEach(panel => {
      const isActive = parseInt(panel.dataset.tab) === activeTab
      panel.classList.toggle("hidden", !isActive)
    })
  }
}
