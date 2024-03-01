import { LightningElement, track } from "lwc";

import { NavigationMixin } from "lightning/navigation";
import circuitShapes from "@salesforce/resourceUrl/circuitShapes";
import searchCircuit from "@salesforce/apex/CircuitController.searchCircuit";

export default class CircuitTiles extends NavigationMixin(LightningElement) {
  @track searchTerm = "";
  @track circuits;
  @track error;

  connectedCallback() {
    this.loadCircuits();
  }

  loadCircuits() {
    this.getCircuits();
  }

  handleSearchTermChange(event) {
    this.searchTerm = event.target.value;
    this.getCircuits();
  }

  getCircuits() {
    searchCircuit({ searchTerm: this.searchTerm })
      .then((result) => {
        //I'M NOT SURE ABOUT THIS BUT IT WORKS :D
        const parsedResult = JSON.parse(result);

        this.circuits = parsedResult.map((circuit) => ({
          ...circuit,
          ImgUrl: circuitShapes + "/" + circuit.Shape__c //IMG URL FOR <img> TAG
        }));
      })
      .catch((error) => {
        console.error("Error fetching circuits:", error);
        this.error = error.body ? error.body.message : "Unknown error";
        this.circuits = undefined;
      });
  }

  get hasResults() {
    return this.circuits && this.circuits.length > 0;
  }
}
