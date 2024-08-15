// Instantiate the API class and create the request
aiplatform.ModelsAPI modelsAPI = new aiplatform.ModelsAPI();
aiplatform.ModelsAPI.createChatGenerations_Request request = new aiplatform.ModelsAPI.createChatGenerations_Request();

// Specify the model
request.modelName = 'sfdc_ai__DefaultGPT35Turbo';

// List of message maps
List<Map<String, String>> messagesData = new List<Map<String, String>>{
    new Map<String, String>{'role' => 'system', 'content' => 'You are helpful, smart, kind, and efficient AI assistant.'},
    new Map<String, String>{'role' => 'user', 'content' => 'Write a short poem'}
};

// Create a list to hold chat messages
List<aiplatform.ModelsAPI_ChatMessageRequest> messagesList = new List<aiplatform.ModelsAPI_ChatMessageRequest>();

// Loop over the message data to create message requests
for (Map<String, String> messageData : messagesData) {
    aiplatform.ModelsAPI_ChatMessageRequest messageRequest = new aiplatform.ModelsAPI_ChatMessageRequest();
    messageRequest.role = messageData.get('role');
    messageRequest.content = messageData.get('content');
    messagesList.add(messageRequest);
}

// Create the request body and set the messages
request.body = new aiplatform.ModelsAPI_ChatGenerationsRequest();
request.body.messages = messagesList;

// Call the API and get the response
aiplatform.ModelsAPI.createChatGenerations_Response apiResponse = modelsAPI.createChatGenerations(request);
String response = apiResponse.Code200.generationDetails.generations[0].content;

System.debug(response);