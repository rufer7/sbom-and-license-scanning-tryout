using Microsoft.Extensions.DependencyInjection;
using RecommenderLogic.Destinations;

namespace RecommenderLogic.Extensions;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddTravelAgency(this IServiceCollection services)
    {
        ArgumentNullException.ThrowIfNull(services);
        services.AddTransient<IChatInterface, TravelAgent>();
        services.AddTransient<DestinationProvider>();
        return services;
    }
}
