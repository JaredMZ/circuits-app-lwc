import { LightningElement, wire } from "lwc";
import { publish, MessageContext } from "lightning/messageService";
import CIRCUIT_TILES_UPDATE_MESSAGE from "@salesforce/messageChannel/CircuitTilesUpdate__c";
import { NavigationMixin } from "lightning/navigation";
import getAllCircuits from "@salesforce/apex/CircuitController.getAllCircuits";
import circuitShapes from "@salesforce/resourceUrl/circuitShapes";
import searchCircuit from "@salesforce/apex/CircuitController.searchCircuit";

export default class CircuitCard extends NavigationMixin(LightningElement) {
  circuits;
  searchTerm = "";
  error;

  @wire(MessageContext) messageContext;
  @wire(searchCircuit, { searchTerm: "$searchTerm" })
  connectedCallback() {
    this.loadCircuits();
  }

  loadCircuits() {
    //GET CIRCUITS AND ADD AN IMGURL FIELD
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
  
  //POST THE DATA OF THE ACTUAL RECORD ON THE MESSAGE CHANNEL
  handleCircuitClick(event) {
    const circuitId = event.target.value;
    const selectedCircuit = this.circuits.find(circuit => circuit.Id === circuitId);

    if (selectedCircuit) {
        const circuitData = {
            circuitId: selectedCircuit.Id,
            Name: selectedCircuit.Name,
            Location: selectedCircuit.Location__c,
            Length: selectedCircuit.Length__c,
            Turns: selectedCircuit.Turns__c,
            Surface: selectedCircuit.Surface__c,
            StartYear: selectedCircuit.Start_Year__c,
            IsActive: true
        };

        publish(this.messageContext, CIRCUIT_TILES_UPDATE_MESSAGE, {
            record: circuitData
        });
    }
}

}