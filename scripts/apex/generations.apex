// Instantiate the API class and create the request
aiplatform.ModelsAPI modelsAPI = new aiplatform.ModelsAPI();
aiplatform.ModelsAPI.createGenerations_Request request = new aiplatform.ModelsAPI.createGenerations_Request();

// Specify model and create request body with prompt
request.modelName = 'sfdc_ai__DefaultGPT35Turbo';
request.body = new aiplatform.ModelsAPI_GenerationRequest();
request.body.prompt = 'What is the capital of Michigan?';

// Make the request and get the response
aiplatform.ModelsAPI.createGenerations_Response response = modelsAPI.createGenerations(request);
String promptResponse = response.Code200.generation.generatedText;
System.debug(promptResponse);