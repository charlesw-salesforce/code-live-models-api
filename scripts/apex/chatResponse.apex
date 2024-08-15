String chat = '[{"role": "user", "message": "Hello there!"}]';
String model = 'sfdc_ai__DefaultBedrockAnthropicClaude3Haiku';

Map<String, Object> chatResponse = ModelsAPIChatGenerations.createChatGenerations(
  chat,
  model
);
System.debug(chatResponse);
