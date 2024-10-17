# sbom-and-license-scanning-tryout

[![License](https://img.shields.io/badge/license-Apache%20License%202.0-blue.svg)](https://github.com/rufer7/sbom-and-license-scanning-tryout/blob/main/LICENSE)

This repo is used to test various SBOM and license scanning tools.

## Motivation

**S**oftware **B**ill **o**f **M**aterials (SBOM) tools are an indispensable instrument for maintaining an overview of the libraries used in a software project, including their transitive dependencies - especially from a security perspective, i.e. to detect vulnerable or compromised dependencies.

License scanning tools, on the other hand, help to ensure the license compatibility of dependencies with the license of the software project.

## Tools

My usual tech stack is C# .NET in combination with Typescript (React or Angular). Support for the before mentioned programming languages is therefore a must.

> [!NOTE]  
> This is a subjective, non-exhaustive selection of possible tools

### SBOM

- [ ] [OWASP dep-scan](https://owasp.org/www-project-dep-scan/)
- [ ] [Microsoft sbom-tool](https://github.com/microsoft/sbom-tool)
- [ ] [CycloneDX](https://cyclonedx.org/)

### License Scanning

- [ ] [OSV scanner](https://google.github.io/osv-scanner/experimental/license-scanning/)
- [ ] [OWASP dep-scan](https://owasp.org/www-project-dep-scan/) 

## Troubleshooting

If certificate creation fails during startup, ensure that directory `%AppData%\ASP.NET\https` exists.
