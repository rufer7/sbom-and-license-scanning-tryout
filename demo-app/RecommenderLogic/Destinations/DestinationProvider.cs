using RecommenderLogic.Parameters;

namespace RecommenderLogic.Destinations;

internal class DestinationProvider
{
    private readonly List<Destination> destinations =
    [
        new("Bali", "Lounge on beaches, devour Nasi Goreng, and perfect the art of doing nothing.", AgeCategory.YoungAdult, Companion.Solo, Reason.EatSleepRepeat),
        new("Santorini", "Whitewashed walls and sunsets so pretty your Instagram will crash.", AgeCategory.YoungAdult, Companion.Solo, Reason.FlexOnSocialMedia),
        new("Chiang Mai", "Co-working cafes by day, street food by night; pretend you’re 'finding yourself' while working.", AgeCategory.YoungAdult, Companion.Solo, Reason.SecretlyWorking),
        new("Maldives", "Water villas and private dinners; say 'Sorry, no Wi-Fi!' with your partner.", AgeCategory.YoungAdult, Companion.Partner, Reason.EatSleepRepeat),
        new("Positano", "Hold hands, drink wine, and make your friends cry over your Amalfi Coast views.", AgeCategory.YoungAdult, Companion.Partner, Reason.FlexOnSocialMedia),
        new("Lisbon", "Cute alleys for selfies and Wi-Fi cafes to sneakily check your emails.", AgeCategory.YoungAdult, Companion.Partner, Reason.SecretlyWorking),
        new("Orlando", "Theme parks for the kids, buffet lines for you. Mickey Mouse is your spirit animal.", AgeCategory.YoungAdult, Companion.Family, Reason.EatSleepRepeat),
        new("Dubai", "Indoor skiing, luxury malls, and family photos that scream 'we made it!'", AgeCategory.YoungAdult, Companion.Family, Reason.FlexOnSocialMedia),
        new("Phuket", "Juggle beach time with kids and secret Zoom calls from your balcony.", AgeCategory.YoungAdult, Companion.Family, Reason.SecretlyWorking),

        new("Tuscany", "Sip wine, eat pasta, and nap under the Italian sun like royalty.", AgeCategory.Adult, Companion.Solo, Reason.EatSleepRepeat),
        new("Machu Picchu", "Post selfies on ancient ruins and claim you 'hiked' all the way up.", AgeCategory.Adult, Companion.Solo, Reason.FlexOnSocialMedia),
        new("Kyoto", "Zen gardens for inner peace and coworking spaces to crush deadlines.", AgeCategory.Adult, Companion.Solo, Reason.SecretlyWorking),
        new("Seychelles", "Forget your problems while sipping cocktails in paradise with your partner.", AgeCategory.Adult, Companion.Partner, Reason.EatSleepRepeat),
        new("Paris", "Kiss by the Eiffel Tower and hashtag #NoFilter for maximum envy points.", AgeCategory.Adult, Companion.Partner, Reason.FlexOnSocialMedia),
        new("Barcelona", "Squeeze in emails between tapas bars and Gaudí architecture tours.", AgeCategory.Adult, Companion.Partner, Reason.SecretlyWorking),
        new("Cancún", "All-inclusive resorts mean zero effort while the kids are busy with sandcastles.", AgeCategory.Adult, Companion.Family, Reason.EatSleepRepeat),
        new("Reykjavík", "Post your whole crew under the Northern Lights and wait for 'wow' comments.", AgeCategory.Adult, Companion.Family, Reason.FlexOnSocialMedia),
        new("Hawaii", "Take calls while the kids surf. Your background is too stunning for anyone to care.", AgeCategory.Adult, Companion.Family, Reason.SecretlyWorking),

        new("Provence", "Lavender fields, slow strolls, and cheese that pairs perfectly with naps.", AgeCategory.Senior, Companion.Solo, Reason.EatSleepRepeat),
        new("Banff", "Snap pictures of turquoise lakes and post, 'Oh, just another quiet day.'", AgeCategory.Senior, Companion.Solo, Reason.FlexOnSocialMedia),
        new("Amsterdam", "Cycle along canals and schedule Zoom calls under the guise of 'slow travel.'", AgeCategory.Senior, Companion.Solo, Reason.SecretlyWorking),
        new("Venice", "Gondola rides, endless gelato, and leisurely people-watching with your partner.", AgeCategory.Senior, Companion.Partner, Reason.EatSleepRepeat),
        new("Kyoto", "Cherry blossoms, kimonos, and a feed full of serene beauty.", AgeCategory.Senior, Companion.Partner, Reason.FlexOnSocialMedia),
        new("Dubrovnik", "Claim you’re exploring 'Game of Thrones' spots while answering emails.", AgeCategory.Senior, Companion.Partner, Reason.SecretlyWorking),
        new("Scottsdale", "Spas for you, golf for them, and a schedule that’s empty as your inbox.", AgeCategory.Senior, Companion.Family, Reason.EatSleepRepeat),
        new("Sydney", "Opera House, Bondi Beach, and family photos that scream 'global explorers.'", AgeCategory.Senior, Companion.Family, Reason.FlexOnSocialMedia),
        new("Cape Town", "Safari by day, sneak in emails by night—just don’t let the lions know.", AgeCategory.Senior, Companion.Family, Reason.SecretlyWorking),
    ];

    public Destination GetDestination(AgeCategory ageCategory, Companion companion, Reason reason) =>
        destinations.FirstOrDefault(d => d.AgeCategory == ageCategory && d.Companion == companion && d.Reason == reason);
}
