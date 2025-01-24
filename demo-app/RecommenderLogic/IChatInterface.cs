namespace RecommenderLogic;

public interface IChatInterface
{
    string StartConversation();
    string GetAnswerForMessage(string? message);
}
