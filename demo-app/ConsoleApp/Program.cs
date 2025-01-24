using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using RecommenderLogic.Extensions;

namespace ConsoleApp;

internal static class Program
{
    public static async Task Main(string[] args)
    {
        using (var host = Host.CreateDefaultBuilder(args).ConfigureServices(AddServices).Build())
        {
            await host.StartAsync();
            var lifetime = host.Services.GetRequiredService<IHostApplicationLifetime>();
            var chatService = host.Services.GetRequiredService<ChatService>();

            chatService.StartAndCompleteConversation();

            lifetime.StopApplication();
            await host.WaitForShutdownAsync();
        }
    }

    private static void AddServices(HostBuilderContext hostContext, IServiceCollection services)
    {
        services.AddLogging(
            builder =>
            {
                builder.AddConsole();
                builder.AddDebug();
            }
        );

        services.AddTravelAgency();
        services.AddTransient<ChatService>();
    }
}
