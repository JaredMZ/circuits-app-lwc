import { LightningElement, wire, api } from "lwc";
import { publish, MessageContext } from "lightning/messageService";
import CIRCUIT_TILES_UPDATE_MESSAGE from "@salesforce/messageChannel/CircuitTilesUpdate__c";

export default class CircuitCard extends LightningElement {
  @api circuit;
  @wire(MessageContext) messageContext;

  handleCircuitClick(event) {
    const circuitId = event.target.value;

    if (this.circuit.Id === circuitId) {
      const circuitData = {
        circuitId: this.circuit.Id,
        Name: this.circuit.Name,
        Location: this.circuit.Location__c,
        Length: this.circuit.Length__c,
        Turns: this.circuit.Turns__c,
        Surface: this.circuit.Surface__c,
        StartYear: this.circuit.Start_Year__c,
        Latitude: this.circuit.Latitude__c,
        Longitude: this.circuit.Longitude__c,
        IsActive: true
      };

      publish(this.messageContext, CIRCUIT_TILES_UPDATE_MESSAGE, {
        record: circuitData
      });
    }
  }
}
