
# Example Mediaranker Project
This project is intended to demonstrate Unit testing on a Model & Controller Testing.  

## When Testing a Model

When Unit-testing a model some things you can look for include:
- Testing Validations so required fields are required and testing any formatting.
- Testing any custom methods on the model

## When Doing Functional Testing on a Controller
- Ensure the right Parameters and HTTP Verbs work with the controller methods
- Ensure that the methods have the correct effect (creating new items, deleting items, changing items).
- Handle unexpected behavior including:
	- Acting on resources not in the database, i.e. deleting/editing/showing items no longer in the database.
	- Handling incorrect parameters.
	
