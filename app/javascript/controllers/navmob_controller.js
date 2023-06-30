import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navmob"
export default class extends Controller {
  static targets = ["navmob"]
  connect() {
  }
  togglemenu() {
    this.navmobTarget.classList.toggle("hidden")
  }
}
