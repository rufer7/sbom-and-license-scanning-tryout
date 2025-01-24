using RecommenderLogic.Parameters;

namespace RecommenderLogic.Destinations;

internal readonly record struct Destination(string Name, string Description, AgeCategory AgeCategory, Companion Companion, Reason Reason);
