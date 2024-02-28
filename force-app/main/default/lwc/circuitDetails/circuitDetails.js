import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import CIRCUIT_TILES_UPDATE_MESSAGE from '@salesforce/messageChannel/CircuitTilesUpdate__c';

export default class CircuitDetails extends LightningElement {
    subscription = null;
    circuit = {};
    isActive = false;

    @wire(MessageContext)
    messageContext;



    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                CIRCUIT_TILES_UPDATE_MESSAGE,
                (message) => {
                    this.handleCircuitTilesUpdate(message);
                }
            );
        }
    }


    //GET ALL FIELD FROM MESSAGE CHANNEL
    handleCircuitTilesUpdate(message) {
        if (message && message.record) {
            const selectedCircuit = message.record;
    
            this.circuit = {
                Id: selectedCircuit.circuitId,
                Name: selectedCircuit.Name,
                Location__c: selectedCircuit.Location,
                Length__c: selectedCircuit.Length,
                Turns__c: selectedCircuit.Turns,
                Surface__c: selectedCircuit.Surface,
                Start_Year__c: selectedCircuit.StartYear
            };

            this.isActive = selectedCircuit.IsActive || false;
        }
    }    


    connectedCallback() {
        this.subscribeToMessageChannel();
    }

}
