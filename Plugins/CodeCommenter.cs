using Microsoft.SemanticKernel;
using System.ComponentModel;
using Microsoft.SemanticKernel.Connectors.OpenAI;

namespace Plugins;

public class CodeCommenter
{
    private readonly Kernel _kernel;

    public CodeCommenter(Kernel kernel)
    {
        _kernel = kernel;
    }

    [KernelFunction]
    [Description("Comments to code to provide a summary, identify patterns, and give line-by-line explanations")]
    public async Task<string> CommentCode(string code)
    {
        if (string.IsNullOrEmpty(code))
            return "No code provided for analysis.";

        // Our prompt template guides the AI in how to comment on the code
        const string promptTemplate = @"
                                            Comment and analyze the following code. Provide:
                                            1. The two most important patterns or concepts used in this code, explaining why they're significant (in all caps surrounded by asterisks)
                                            2. A clear, concise summary of what the code does (step by step format 3-4 sentences each bullet). The first line should always say SUMMARY in between asterisks. 
                                            3. Line-by-line comments explaining the code's functionality
                                            
                                            If there are already comments, try not to change them too much, but you can improve them and add minor clarifications.
                                            EVERY line needs a comment, it's imperative. 

                                            Code to comment:
                                            {{$input}}

                                            Format your response as follows:
                                            **SUMMARY**
                                            [Your summary here]

                                            KEY PATTERNS/CONCEPTS:
                                            **First pattern/concept** and its significance
                                            **Second pattern/concept** and its significance

                                            [Original code with line-by-line comments]";

        // Create our semantic function using the kernel's CreateFunctionFromPrompt method
        var analysisFunction = _kernel.CreateFunctionFromPrompt(promptTemplate);

        // Execute the comments with our code as input
        var context = new KernelArguments
        {
            ["input"] = code
        };

        var result = await _kernel.InvokeAsync(analysisFunction, context);
        return result.GetValue<string>() ?? "Commenting could not be completed.";
    }
}