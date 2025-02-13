using Aspire.Azure.AI.OpenAI;
using Microsoft.Extensions.Azure;

var builder = DistributedApplication.CreateBuilder(args);

var apiService = builder.AddProject<Projects.skLabs_ApiService>("apiservice");

builder.AddProject<Projects.skLabs_Web>("webfrontend")
    .WithExternalHttpEndpoints()
    .WithReference(apiService)
    .WaitFor(apiService);

builder.Build().Run();
