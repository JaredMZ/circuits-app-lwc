# Racing Circuits App 🏁

Welcome to the Racing Circuits App! This is a project I created to practice my skills and have a bit of fun.

## Components Included:

1. **Circuit Card Component**: Display circuit shape and name, with a "view details" button.
2. **Circuit Tiles Component**: Present racing circuits in a tile layout.
3. **Circuit Details Component**: Provide details and specifications for each racing circuit.
4. **Circuit Map Component**: A map view to explore the geographical locations of racing circuits.

## Usage

### Cloning the Repository

To integrate these components into your Salesforce org, follow these steps:

1. Open your terminal.
2. Navigate to the directory where you intend to store the project.
3. Execute the following command:

```bash
git clone https://github.com/JaredMZ/circuits-app-lwc.git
```
### Deploying to Salesforce Org

Before deploying the app code to your org, authorize your Salesforce org with the Salesforce CLI, save it with a "circuits-app" alias, and set the current user as the default user:

```bash
sf org login web -s -a circuits-app
```

When a browser window with the Salesforce login page opens, enter your Salesforce org credentials.

``` bash
sf project deploy start -d force-app/main/default
```

### Opening the Org

Once the deployment completes, open your org in a browser:

```bash
sf org open
```

This will launch your Salesforce org in the default web browser.

## Developed by

![logo_jmz_white](https://github.com/JaredMZ/circuits-app-lwc/assets/71626197/62818987-cda0-489d-9de9-57365e40ee6b)

Jared Martinez

