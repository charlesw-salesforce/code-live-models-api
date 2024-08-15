public class ChatMessage {
  public String role { get; set; }
  public String message { get; set; }

  public ChatMessage() {
  }

  public ChatMessage(String role, String message) {
    this.role = role;
    this.message = message;
  }
}
