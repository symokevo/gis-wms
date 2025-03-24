import consumer from "./consumer";

consumer.subscriptions.create("PressureChannel", {
  received(data) {
    alert(`Leak detected at ${data.location}!`);
  }
});