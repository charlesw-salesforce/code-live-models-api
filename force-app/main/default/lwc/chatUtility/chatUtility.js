import { LightningElement, track, wire } from 'lwc';
import getModelOptions from '@salesforce/apex/LLMModelListService.getModelOptions';
import createChatGenerations from '@salesforce/apex/ModelsAPIChatGenerations.createChatGenerations';

export default class GenAiChatInterface extends LightningElement {
    @track modelOptions = []; 
    @track selectedModel; // The model that's currently being used
    @track chatLog = []; // Log of messages between user and chatbot
    @track userInput = ''; // Text in the textarea
    @track isLoading = false; 

    // Get a list of models
    @wire(getModelOptions)
    wiredModelOptions({ error, data}) {
        if (data) {
            this.modelOptions = data.map(option => ({
                label: option.label, 
                value: option.code
            }));
            this.selectedModel = this.modelOptions[0].value;
            this.error = undefined; 
        } else if (error) {
            this.error = error;
            this.modelOptions = undefined;
        }
    }
    
    // 
    handleModelChange(event) {
        this.selectedModel = event.detail.value;
    }

    // Send the user's message to a model
    handleSendMessage(event) {
        event.preventDefault(); 
        if (this.userInput.trim()) {
            const userMessage = {
                id: this.chatLog.length + 1,
                message: this.userInput,
                role: 'user',
                isUser: true,
            };

            this.isLoading = true; 
            this.chatLog = [...this.chatLog, userMessage];
            this.scrollToBottom();

            let chatMessages = this.chatLog.map((chat) => ({
                role: chat.role,
                message: chat.message,
            }));

            createChatGenerations({ input: JSON.stringify(chatMessages), modelName: this.selectedModel })
                .then(({ generation, error }) => {
                    if (generation) {
                        this.simulateTypingEffect(generation);
                    } else if (error) {
                        console.log("Error fetching bot response", JSON.stringify(error)); 
                        this.simulateTypingEffect("Something went wrong");
                    }
                })
                .catch((error) => {
                    console.error("Error fetching bot response", JSON.stringify(error));
                    this.simulateTypingEffect("Something went wrong");
                })
                .finally(() => {
                    this.isLoading = false; 
                });

            this.userInput = "";
        }
    }

    handleInputChange(event) {
        this.userInput = event.target.value;
    }

    handleClearChat() {
        this.chatLog = [];
        this.scrollToBottom();
    }

    simulateTypingEffect(fullMessage) {
        const assistantMessage = {
            id: this.chatLog.length + 1,
            message: '',
            role: 'assistant',
            isUser: false, 
        };
        this.chatLog = [...this.chatLog, assistantMessage];
        this.scrollToBottom(); 
    
        let currentIndex = 0;
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        const typingInterval = setInterval(() => {
            if (currentIndex < fullMessage.length) {
                const nextBatch = fullMessage.slice(currentIndex, currentIndex + 10); 
                assistantMessage.message += nextBatch;
                this.chatLog = [...this.chatLog]; 
                currentIndex += 10;
                this.scrollToBottom(); 
            } else {
                clearInterval(typingInterval);
            }
        }, 100); 
    }

    handleEnter(event) {
        const enterKeyCode = 13;
        if (event.keyCode === enterKeyCode && !event.shiftKey) {
            event.preventDefault();
            this.handleSendMessage(event);
        }
    }

    renderedCallback() {
        this.scrollToBottom();
    }

    scrollToBottom() {
        const chatContainer = this.template.querySelector(".slds-scrollable_y");
        if (chatContainer) {
            chatContainer.scrollTop = chatContainer.scrollHeight;
        }
    }
}