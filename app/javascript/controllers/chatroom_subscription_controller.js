import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { chatroomId: Number }
  static targets = ["messages", "toto"]

  insertMessageAndScrollDown(data) {
      this.messagesTarget.insertAdjacentHTML("beforeend", data);
      this.messagesTarget.lastElementChild.scrollIntoView();
      console.log(this.messagesTarget.scrollHeight);
  }
  connect() {
    setTimeout(()=> {
      this.messagesTarget.lastElementChild.scrollIntoView({ behavior: "smooth" });
    }, 300);
    this.channel = createConsumer().subscriptions.create(
    { channel: "ChatroomChannel", id: this.chatroomIdValue },
    { received: data => this.insertMessageAndScrollDown(data)}
  )
    }

}
