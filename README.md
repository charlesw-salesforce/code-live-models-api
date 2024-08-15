# Exploring the Models API

This is a companion repository to the ["codeLive: Exploring the Models API (Beta)" livestream](https://www.youtube.com/watch?v=hf95_ghGeNI), which aired on August 15, 2024. It shows how to build and deploy a chatbot that supports multiple models, including OpenAI GPT-4o and Anthropic's Claude Haiku.

![Demo of the Gen AI Chat App being used to ask who won the 2004 NBA Championship.](/demo.gif)

## Using this repository

To use this repository:

1. Create a Custom Einstein AI Playground using the link in the [Get Started with Prompt Builder](https://trailhead.salesforce.com/content/learn/projects/quick-start-prompt-builder/get-started-with-prompt-builder) Trailhead module.
2. Turn on [Einstein Generative AI](https://help.salesforce.com/s/articleView?id=sf.generative_ai_enable.htm&type=5).
3. Clone and pull down this repository.
4. Authorize your newly created Einstein AI Playground.
5. [Deploy the Apex Classes and chatUtility component](https://developer.salesforce.com/docs/platform/sfvscode-extensions/guide/deploy-source.html) to the org.
6. Edit the Sales app in the [App Manager](https://help.salesforce.com/s/articleView?id=sf.apps_lightning_utilities.htm&type=5).
7. Within the Sales app App Manager, add the chatUtility component as a Utility Item.

## Resources

- [Models API Developer Guide](https://developer.salesforce.com/docs/einstein/genai/guide/models-api.html)
- [Access Models API with REST](https://developer.salesforce.com/docs/einstein/genai/guide/access-models-api-with-rest.html)
- [Access Models API with Apex](https://developer.salesforce.com/docs/einstein/genai/guide/access-models-api-with-apex.html)
- [Models API Postman Collection](https://www.postman.com/salesforce-developers/salesforce-developers/collection/onih7sc/models-apis-beta)
- [Activate Einstein Generative AI](https://help.salesforce.com/s/articleView?id=sf.generative_ai_enable.htm&type=5)
