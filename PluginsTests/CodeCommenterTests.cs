using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.SemanticKernel;
using System.Threading.Tasks;
using Plugins;
using Microsoft.AspNetCore.Builder;

namespace Plugins;

[TestClass]
public class CodeCommenterTests
{
    private Kernel _kernel;
    private CodeCommenter _plugin;

    [TestInitialize]
    public void Setup()
    {
        
        var configuration = WebApplication.CreateBuilder().Configuration;

        var deploymentName = configuration["TextGen:ModelDeploymentName"];
        var endpoint = configuration["TextGen:Endpoint"];
        var apiKey = configuration["TextGen:ApiKey"];

        // Verification 
        if (string.IsNullOrWhiteSpace(deploymentName))
            throw new InvalidOperationException("Model Deployment Name not found in configuration.");

        if (string.IsNullOrWhiteSpace(endpoint))
            throw new InvalidOperationException("Endpoint not found in configuration.");

        if (string.IsNullOrWhiteSpace(apiKey))
            throw new InvalidOperationException("API Key not found in configuration.");

        _kernel = Kernel.CreateBuilder()
            .AddAzureOpenAIChatCompletion(
                deploymentName: deploymentName,
                endpoint: endpoint,
                apiKey: apiKey)
            .Build();

        _plugin = new CodeCommenter(_kernel);
    }

    [TestMethod]
    public async Task CommentCode_ValidCSharpCode_ReturnsWithComments()
    {
        string codeToComment = @"
        public class WeatherForecastCache
        {
            private readonly IMemoryCache _cache;
            private readonly ILogger<WeatherForecastCache> _logger;
            private readonly IWeatherService _weatherService;
            private const string CacheKey = ""WeatherForecast"";
            private static readonly TimeSpan CacheDuration = TimeSpan.FromHours(1);

            public WeatherForecastCache(
                IMemoryCache cache,
                ILogger<WeatherForecastCache> logger,
                IWeatherService weatherService)
            {
                _cache = cache ?? throw new ArgumentNullException(nameof(cache));
                _logger = logger ?? throw new ArgumentNullException(nameof(logger));
                _weatherService = weatherService ?? throw new ArgumentNullException(nameof(weatherService));
            }

            public async Task<WeatherForecast> GetForecastAsync(string city)
            {
                if (string.IsNullOrWhiteSpace(city))
                    throw new ArgumentException(""City name cannot be empty"", nameof(city));

                if (_cache.TryGetValue(GetCacheKeyForCity(city), out WeatherForecast forecast))
                {
                    _logger.LogInformation(""Cache hit for city: {City}"", city);
                    return forecast;
                }

                _logger.LogInformation(""Cache miss for city: {City}"", city);
                forecast = await _weatherService.GetForecastAsync(city);

                var cacheOptions = new MemoryCacheEntryOptions()
                    .SetAbsoluteExpiration(CacheDuration)
                    .RegisterPostEvictionCallback((key, value, reason, state) =>
                    {
                        _logger.LogDebug(""Weather forecast evicted for {Key}. Reason: {Reason}"", key, reason);
                    });

                _cache.Set(GetCacheKeyForCity(city), forecast, cacheOptions);
                return forecast;
            }

            private string GetCacheKeyForCity(string city) => $""{CacheKey}_{city.ToLowerInvariant()}"";
        }


"; // Your existing code sample

        // Updated method call
        string commentOutput = await _plugin.CommentCode(codeToComment);
        Console.WriteLine(commentOutput);

        Assert.IsNotNull(commentOutput, "Analysis should not be null");
        Assert.IsFalse(string.IsNullOrWhiteSpace(commentOutput), "Analysis should contain meaningful content");
        Assert.IsTrue(commentOutput.Contains("Summary", StringComparison.OrdinalIgnoreCase),
            "Comments should contain a summary section");
        Assert.IsTrue(commentOutput.Contains("Patterns", StringComparison.OrdinalIgnoreCase),
            "Comments should identify programming patterns");
    }

    [TestMethod]
    public async Task CommentCode_EmptyCode_ReturnsErrorMessage()
    {
        // Arrange
        string emptyCode = "";

        // Act - Updated method name
        string commentOutput = await _plugin.CommentCode(emptyCode);
        Console.WriteLine(commentOutput);

        // Assert
        Assert.IsNotNull(commentOutput, "Code should not be null");
        Assert.IsTrue(commentOutput.Contains("No code provided", StringComparison.OrdinalIgnoreCase),
            "Should return a message about empty code");
    }

    [TestMethod]
    public async Task CommentCode_DifferentProgrammingLanguage_ReturnsWithComments()
    {
        // Your existing Python code test with updated method name
        string pythonCode = @"
def calculate_average(numbers):
    if not numbers:
        return 0
    return sum(numbers) / len(numbers)

def main():
    numbers = [1, 2, 3, 4, 5]
    average = calculate_average(numbers)
    print(f'Average: {average}')
";

        // Updated method call
        string commentOutput = await _plugin.CommentCode(pythonCode);
        Console.WriteLine(commentOutput);

        Assert.IsNotNull(commentOutput, "Analysis should not be null");
        Assert.IsFalse(string.IsNullOrWhiteSpace(commentOutput), "Analysis should contain meaningful content");
    }

    [TestCleanup]
    public void Cleanup()
    {
        _kernel = null;
        _plugin = null;
    }
}