using Microsoft.SemanticKernel;
using System.ComponentModel;
using Microsoft.SemanticKernel.Connectors.OpenAI;

namespace Plugins;

public class LessonPlanCreator
{
    private readonly Kernel _kernel;

    public LessonPlanCreator(Kernel kernel)
    {
        _kernel = kernel;
    }

    [KernelFunction]
    [Description("Creates a detailed lesson plan based on provided specifications")]
    public async Task<string> CreateLessonPlan(
        string subject,
        string studentAgeRange,
        int numberOfStudents,
        string specialConsiderations,
        int classDuration,
        string classDays,
        string standardsType,
        bool collaborativeLearning,
        bool presentationSkills,
        bool classDiscussions,
        bool researchSkills,
        string testPrep,
        bool funFridays)
    {
        // Construct the dynamic parts of the prompt based on input parameters
        var focusAreas = new List<string>();
        if (collaborativeLearning) focusAreas.Add("Collaborative Learning");
        if (presentationSkills) focusAreas.Add("Presentation Skills");
        if (classDiscussions) focusAreas.Add("Class Discussions");
        if (researchSkills) focusAreas.Add("Research Skills");

        // Our prompt template with dynamic field insertion
        const string promptTemplate = @"
                                            Create a detailed lesson plan for a {{$subject}} class with the following specifications:

                                            STUDENT CONTEXT:
                                            - Age Range: {{$studentAgeRange}}
                                            - Class Size: {{$numberOfStudents}} students
                                            - Special Considerations: {{$specialConsiderations}}

                                            CLASS LOGISTICS:
                                            - Duration: {{$classDuration}} minutes
                                            - Teaching Days: {{$classDays}}
                                            - Standards Framework: {{$standardsType}}

                                            LEARNING ENVIRONMENT:
                                            Focus Areas: {{$focusAreas}}

                                            TEST PREPARATION:
                                            Include specific preparation for: {{$testPrep}}

                                            FORMAT REQUIREMENTS:
                                            1. Clear learning objectives aligned with {{$standardsType}}
                                            2. Detailed lesson flow with timing breakdowns
                                            3. Required materials and resources
                                            4. Differentiated instruction strategies for {{$specialConsiderations}}
                                            5. Assessment methods
                                            6. Homework/extension activities
                                            {{#if $funFridays}}
                                            7. Include engaging, interactive elements while maintaining educational value
                                            {{/if}}

                                            Please provide a complete lesson plan that can be executed in {{$classDuration}} minutes, incorporating 
                                            all specified elements while maintaining engagement for {{$numberOfStudents}} students in the {{$studentAgeRange}} age range.";

        // Create our semantic function
        var lessonPlanFunction = _kernel.CreateFunctionFromPrompt(promptTemplate);

        // Execute the function with our parameters
        var context = new KernelArguments
        {
            ["subject"] = subject,
            ["studentAgeRange"] = studentAgeRange,
            ["numberOfStudents"] = numberOfStudents.ToString(),
            ["specialConsiderations"] = specialConsiderations,
            ["classDuration"] = classDuration.ToString(),
            ["classDays"] = classDays,
            ["standardsType"] = standardsType,
            ["focusAreas"] = string.Join(", ", focusAreas),
            ["testPrep"] = testPrep,
            ["funFridays"] = funFridays
        };

        var result = await _kernel.InvokeAsync(lessonPlanFunction, context);
        return result.GetValue<string>() ?? "Lesson plan creation could not be completed.";
    }
}