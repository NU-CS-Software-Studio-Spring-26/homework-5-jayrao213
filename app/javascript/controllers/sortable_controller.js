import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      ghostClass: "sortable-ghost",
      onEnd: this.onEnd.bind(this)
    })
  }

  disconnect() {
    if (this.sortable) {
      this.sortable.destroy()
    }
  }

  onEnd(event) {
    const todoIds = Array.from(this.element.children)
      .map(child => child.dataset.id)
      .filter(id => id)

    // Retrieve standard Rails CSRF token
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute("content")

    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify({ todo_ids: todoIds })
    })
    .then(response => {
      if (!response.ok) {
        console.error("Failed to persist reordered TODOs")
      }
    })
    .catch(error => {
      console.error("Network error when updating positions:", error)
    })
  }
}
