namespace RecommenderLogic;

internal readonly record struct Outputs
{
    public const string EmptyLine = @"
";
    public const string Header = @"
 _______                  _                                          
|__   __|                | |                                         
   | |_ __ __ ___   _____| |                                         
   | | '__/ _` \ \ / / _ \ |                                         
   | | | | (_| |\ V /  __/ |                                         
 __|_|_|  \__,_| \_/ \___|_|        _   _                            
|  __ \          | | (_)           | | (_)                           
| |  | | ___  ___| |_ _ _ __   __ _| |_ _  ___  _ __                 
| |  | |/ _ \/ __| __| | '_ \ / _` | __| |/ _ \| '_ \                
| |__| |  __/\__ \ |_| | | | | (_| | |_| | (_) | | | |               
|_____/ \___||___/\__|_|_| |_|\__,_|\__|_|\___/|_| |_|   _           
|  __ \                                                 | |          
| |__) |___  ___ ___  _ __ ___  _ __ ___   ___ _ __   __| | ___ _ __ 
|  _  // _ \/ __/ _ \| '_ ` _ \| '_ ` _ \ / _ \ '_ \ / _` |/ _ \ '__|
| | \ \  __/ (_| (_) | | | | | | | | | | |  __/ | | | (_| |  __/ |   
|_|  \_\___|\___\___/|_| |_| |_|_| |_| |_|\___|_| |_|\__,_|\___|_|   
";
    public const string WelcomeMessage = @"
The Travel Destination Recommender is an innovative system that utilises 
advanced algorithms to provide recommendations for travel destinations, 
taking into account a range of factors.
";
    public const string AgeQuestion = @"
What is the age of the primary traveller?

[1] 18-30
[2] 30-60
[3] 60+
";
    public const string CompanionQuestion = @"
Who will be accompanying the primary traveller?

[1] No one
[2] Partner
[3] Family
";
    public const string ReasonQuestion = @"
What is the primary motivation for travelling?

[1]     Eat, Sleep, Repeat: Do nothing but gain weight
[2]     Flex on Social Media: All others should be jealous
[3]     Secretly Working: My boss forces me to go on vacation, but I work anyway
";
    public const string UnknownAnswer = "I'm sorry, I didn't understand that. Please try again.";
    public const string Recommendation = @"
Ok. I found the perfect destination for you:
";
    public static string Concat(params string[] strings) => string.Join(EmptyLine, strings);
    public static string Bold(string value) => $"\x1b[1m{value}\x1b[0m";
}
