Raffi: Hey there,
What do many people do in January?
They plan their year and they plan their vacations.
To help everyone find the perfect vacation destination, I have developed a tool that makes great recommendations based on certain parameters.

Are you interested in this tool?

# RNU: Demo -> Show demo app

Unfortunately, I am only a hobby developer and still need some support before I can bring the tool to market.
Fortunately, Marc is helping me with this. He already prepared something and is now going to show us... 


Raffi: Hey Marc, thanks for having a look at my tool. You already mentioned that we should create an SBOM for it. What exactly is an SBOM?
Marc: Great question, Raffi! An SBOM stands for Software Bill of Materials. It’s essentially a detailed inventory of all the components that make up a piece of software.

Raffi: Oh, like a list of ingredients for a recipe?

Marc: Exactly! Just like you’d want to know what goes into your food, an SBOM tells you what’s inside your software, including proprietary and open-source components, their versions, licenses, and dependencies.

Raffi: Can you show me such an ingredients list and how to create it?

Marc: Sure! -> Show SBOM file, tell about standardized formats

# Marc: Demo -> show how to create an SBOM for a .NET application on you device

dotnet CycloneDX ./demo-app/TravelDestinationRecommender.sln --out ./

## Known standards
1. **SPDX** (Software Package Data Exchange): A standard supported by the Linux Foundation.
2. **CycloneDX**: A lightweight format specifically designed for security use cases.
3. **SWID Tags** (Software Identification Tags): An ISO standard for software identification.

Raffi: Why is it so important to have this "ingredient list" for software?

Marc: There are a few reasons. First, transparency. With an SBOM, you can clearly see what components are being used, which is especially helpful when you’re working with third-party or open-source software.

Raffi: That makes sense. But transparency is not so important to me, do I have other advantages?

Marc: An SBOM helps identify vulnerabilities. If a specific version of a library or tool is found to have a security flaw, you can quickly check your SBOM to see if your software uses it. It’s a crucial part of vulnerability management.

Raffi: Got it. So, it’s like spotting an expired ingredient in your fridge before it causes problems.

Marc: Exactly! Plus, it’s useful for compliance. An SBOM includes licensing details, so you can ensure your software complies with all relevant licenses and avoid legal trouble.

Raffi: I have seen that OWASP has published a tool that also maintains an inventory of my software. May I show you this solution?

# Raffi: Demo -> Generate and upload SBOM
# Raffi: Demo -> Dependency Track UI

Marc: Fine, I show you my approach

# Marc: Demo -> License Compliance Check

# Comparison

