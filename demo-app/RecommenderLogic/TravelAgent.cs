using RecommenderLogic.Destinations;
using RecommenderLogic.Parameters;

namespace RecommenderLogic;

internal class TravelAgent(DestinationProvider DestinationProvider) : IChatInterface
{
    private AgeCategory ageCategory = AgeCategory.Unknown;
    private Companion companion = Companion.Unknown;
    private Reason reason = Reason.Unknown;

    public string StartConversation() => Outputs.Concat(Outputs.Header, Outputs.WelcomeMessage, Outputs.AgeQuestion);

    public string GetAnswerForMessage(string? message)
    {
        if (ageCategory == AgeCategory.Unknown)
        {
            return Enum.TryParse(message, out ageCategory)
                ? Outputs.CompanionQuestion
                : Outputs.Concat(Outputs.UnknownAnswer, Outputs.AgeQuestion);
        }

        if (companion == Companion.Unknown)
        {
            return Enum.TryParse(message, out companion)
                ? Outputs.ReasonQuestion
                : Outputs.Concat(Outputs.UnknownAnswer, Outputs.CompanionQuestion);
        }

        if (reason == Reason.Unknown)
        {
            if (Enum.TryParse(message, out reason))
            {
                var destination = DestinationProvider.GetDestination(ageCategory, companion, reason);
                return Outputs.Concat(Outputs.Recommendation, Outputs.Bold(destination.Name), destination.Description);
            }

            return Outputs.Concat(Outputs.UnknownAnswer, Outputs.ReasonQuestion);
        }

        return "Press Ctrl+C to shut down";
    }
}
