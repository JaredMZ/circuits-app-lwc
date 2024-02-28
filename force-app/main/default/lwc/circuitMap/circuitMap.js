import { LightningElement, wire } from "lwc";
import { subscribe, MessageContext } from "lightning/messageService";

import CIRCUIT_TILES_UPDATE_MESSAGE from "@salesforce/messageChannel/CircuitTilesUpdate__c";

export default class CircuitMap extends LightningElement {
  subscription = null;
  mapMarkers = [];
  circuit = {};
  isActive = false;

  @wire(MessageContext) messageContext;

  subscribeToMessageChannel() {
    if (!this.subscription) {
      this.subscription = subscribe(
        this.messageContext,
        CIRCUIT_TILES_UPDATE_MESSAGE,
        (message) => {
          this.handleCircuitMapUpdate(message);
        }
      );
    }
  }

  handleCircuitMapUpdate(message) {
    if (message && message.record) {
      const selectedCircuit = message.record;

      this.circuit = {
        Id: selectedCircuit.circuitId,
        Name: selectedCircuit.Name,
        Location__c: selectedCircuit.Location,
        Latitude__c: selectedCircuit.Latitude,
        Longitude__c: selectedCircuit.Longitude
      };

      this.mapMarkers = [
        {
          location: {
            Latitude: this.circuit.Latitude__c,
            Longitude: this.circuit.Longitude__c
          }
        }
      ];

      this.isActive = selectedCircuit.IsActive || false;
    }
  }

  connectedCallback() {
    this.subscribeToMessageChannel();
  }
}
