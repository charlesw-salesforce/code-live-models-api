public with sharing class ModelsAPIChatGenerations {
  @AuraEnabled
  public static Map<String, Object> createChatGenerations(
    String input,
    String modelName
  ) {
    List<ChatMessage> chatLog = (List<ChatMessage>) JSON.deserialize(
      input,
      List<ChatMessage>.class
    );

    // Instantiate the API class
    aiplatform.ModelsAPI modelsAPI = new aiplatform.ModelsAPI();

    // Prepare the request and body objects
    aiplatform.ModelsAPI.createChatGenerations_Request request = new aiplatform.ModelsAPI.createChatGenerations_Request();
    aiplatform.ModelsAPI_ChatGenerationsRequest body = new aiplatform.ModelsAPI_ChatGenerationsRequest();

    // Specify model
    request.modelName = modelName;

    // Create a list to hold chat messages
    List<aiplatform.ModelsAPI_ChatMessageRequest> messageRequestList = new List<aiplatform.ModelsAPI_ChatMessageRequest>();

    // Define models that do not require the system prompt
    Set<String> modelsWithoutSystemPrompt = new Set<String>{
      'sfdc_ai__DefaultBedrockAnthropicClaude3Haiku',
      'sfdc_ai__DefaultGPT35TurboInstruct'
    };

    // Add a system prompt if the model is not in the predefined set
    if (!modelsWithoutSystemPrompt.contains(modelName)) {
      String systemPrompt = 'You are a helpful, smart, kind, and efficient AI assistant. You always fulfill the user\'s requests to the best of your ability.';
      aiplatform.ModelsAPI_ChatMessageRequest systemMessage = new aiplatform.ModelsAPI_ChatMessageRequest();
      systemMessage.content = systemPrompt;
      systemMessage.role = 'system';
      messageRequestList.add(systemMessage);
    }

    // Loop through the chatlog and create message requests
    for (ChatMessage chat : chatLog) {
      aiplatform.ModelsAPI_ChatMessageRequest messageRequest = new aiplatform.ModelsAPI_ChatMessageRequest();
      messageRequest.content = chat.message != null ? chat.message : ''; // Handle null message
      messageRequest.role = chat.role != null ? chat.role : 'user'; // Handle null role
      messageRequestList.add(messageRequest);
    }

    // Set the messages in the request body
    body.messages = messageRequestList;

    // Set the request body and model name
    request.body = body;

    // Initialize the response map
    Map<String, Object> responseMap = new Map<String, Object>();

    try {
      // Call the API and get the response
      aiplatform.ModelsAPI.createChatGenerations_Response apiResponse = modelsAPI.createChatGenerations(
        request
      );

      // Check that we have a non-null response
      if (
        apiResponse?.Code200?.generationDetails?.generations != null &&
        !apiResponse.Code200.generationDetails.generations.isEmpty()
      ) {
        // Set the variable from the response
        responseMap.put(
          'generation',
          apiResponse.Code200.generationDetails.generations[0].content
        );
      } else {
        // Handle the case where response is null
        Map<String, String> errorDetails = new Map<String, String>();
        errorDetails.put('code', 'NO_CONTENT');
        errorDetails.put('message', 'No content generated');
        responseMap.put('error', errorDetails);
      }
    } catch (aiplatform.ModelsAPI.createChatGenerations_ResponseException e) {
      System.debug('Response code: ' + e.responseCode);
      System.debug('The following exception occurred: ' + e);

      // Add error to the output
      Map<String, String> errorDetails = new Map<String, String>();
      errorDetails.put('code', String.valueOf(e.responseCode));
      errorDetails.put('message', 'Unable to get a valid response.');
      responseMap.put('error', errorDetails);
    }

    return responseMap;
  }
}
