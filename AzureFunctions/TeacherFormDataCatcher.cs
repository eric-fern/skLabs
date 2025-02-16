using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace AzureFunctions
{
    /*this azure function will receive an http request 
     *containing all of our form data filled in by a teacher
     *It will call and orchestrate SK plugins to generate a lesson plan, and various 
     *
     *Our APIM can pass on a request to this Azure function by sending request to:
     *https://azurefunctions20250215174351.azurewebsites.net/api/teacherformdatacatcher
    */
    public class TeacherFormDataCatcher
    {
        private readonly ILogger<TeacherFormDataCatcher> _logger;

        public TeacherFormDataCatcher(ILogger<TeacherFormDataCatcher> logger)
        {
            _logger = logger;
        }

        [Function("TeacherFormDataCatcher")]
        public IActionResult Run([HttpTrigger(AuthorizationLevel.Function, "post", Route = "teacherformdatacatcher")] HttpRequest req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");
            return new OkObjectResult("Welcome to Azure Functions!");
        }
    }
}
