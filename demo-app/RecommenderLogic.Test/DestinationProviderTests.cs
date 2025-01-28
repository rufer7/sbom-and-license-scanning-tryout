using FluentAssertions;
using RecommenderLogic.Destinations;
using RecommenderLogic.Parameters;

namespace RecommenderLogic.Test;

public class DestinationProviderTests
{
    public static IEnumerable<object[]> GetParameterCombinations()
    {
        foreach (var ageCategory in Enum.GetValues<AgeCategory>().Where(_ => _ != AgeCategory.Unknown))
        {
            foreach (var companion in Enum.GetValues<Companion>().Where(_ => _ != Companion.Unknown))
            {
                foreach (var reason in Enum.GetValues<Reason>().Where(_ => _ != Reason.Unknown))
                {
                    yield return new object[] { ageCategory, companion, reason };
                }
            }
        }
    }

    [Theory]
    [MemberData(nameof(GetParameterCombinations))]
    public void RecommendationExists(AgeCategory ageCategory, Companion companion, Reason reason)
    {
        DestinationProvider destinationProvider = new();
        var recommendation = destinationProvider.GetDestination(ageCategory, companion, reason);

        recommendation.Should().NotBeNull();
    }
}
