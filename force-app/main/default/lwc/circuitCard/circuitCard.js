import { LightningElement } from "lwc";
import getAllCircuits from "@salesforce/apex/CircuitController.getAllCircuits";
import circuitShapes from "@salesforce/resourceUrl/circuitShapes";

export default class CircuitCard extends LightningElement {
  circuits;
  error;

  connectedCallback() {
    this.loadCircuits();
  }

  loadCircuits() {
    getAllCircuits()
      .then((result) => {
        const parsedResult = JSON.parse(result);
        if (Array.isArray(parsedResult)) {
          this.circuits = parsedResult.map((circuit) => ({
            ...circuit,
            ImgUrl: circuitShapes + "/" + circuit.Shape__c
          }));
        } else {
          console.error("Result is not an Array:", parsedResult);
        }
      })
      .catch((error) => {
        this.error = error;
      });
  }
}
