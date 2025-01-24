using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using RecommenderLogic;

namespace ConsoleApp;

internal sealed class ChatService
(
    ILogger<ChatService> Logger,
    IHostApplicationLifetime AppLifetime,
    IChatInterface ChatInterface
)
{
    public void StartAndCompleteConversation()
    {
        try
        {
            Console.WriteLine(ChatInterface.StartConversation());

            while (!AppLifetime.ApplicationStopping.IsCancellationRequested)
            {
                var message = Console.ReadLine();
                AppLifetime.ApplicationStopping.ThrowIfCancellationRequested();
                var answer = ChatInterface.GetAnswerForMessage(message);
                Console.Write(answer);
            }
        }
        catch (OperationCanceledException ex)
        {
            Logger.LogDebug(ex, "Application stopping");
        }
        catch (Exception ex)
        {
            Logger.LogError(ex, "Unhandled exception!");
        }
    }
}
