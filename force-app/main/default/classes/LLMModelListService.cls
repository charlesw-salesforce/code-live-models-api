public with sharing class LLMModelListService {
  public class ModelOption {
    @AuraEnabled
    public String code { get; set; }
    @AuraEnabled
    public String label { get; set; }

    public ModelOption(String code, String label) {
      this.code = code;
      this.label = label;
    }
  }

  @AuraEnabled(cacheable=true)
  public static List<ModelOption> getModelOptions() {
    List<ModelOption> options = new List<ModelOption>();
    options.add(
      new ModelOption('sfdc_ai__DefaultOpenAIGPT4Omni', 'OpenAI GPT 4o')
    );
    options.add(
      new ModelOption('sfdc_ai__DefaultOpenAIGPT4Turbo', 'OpenAI GPT 4 Turbo')
    );
    options.add(
      new ModelOption(
        'sfdc_ai__DefaultOpenAIGPT35Turbo',
        'OpenAI GPT 3.5 Turbo'
      )
    );
    options.add(
      new ModelOption(
        'sfdc_ai__DefaultBedrockAnthropicClaude3Haiku',
        'Anthropic Claude 3 Haiku'
      )
    );
    return options;
  }
}
