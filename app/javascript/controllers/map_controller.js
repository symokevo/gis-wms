import { Controller } from "@hotwired/stimulus";
import L from 'leaflet';

export default class extends Controller {
  connect() {
    this.map = L.map(this.element).setView([-0.7, 37.0], 13); // Default to Murang'a, Kenya
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(this.map);
  }
}