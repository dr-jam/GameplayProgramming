# Style Guides

## What is a Style Guide?

Style guides are a set of rules in place to help programmers write cleaner and more maintainable code.

## Style Guide for Class

We will be using the .Net style guides for C#

https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions  
https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/naming-guidelines  

Please refer to this document if there are any questions about C# style. For more general style advice including the crafting of comments, follow Microsoft's style guide:

https://docs.microsoft.com/en-us/style-guide/welcome/


# Coding Conventions

## What are coding conventions?

Coding conventions are best practices for programming in a specific language. 
They are usually implicit in programming style guides, however technologies like Unity have their own coding conventions.

## Examples

### Conditionals

#### Good ####
``` C#
if (conditional)
{
    Code here
}
```

#### Bad ####
``` C#
if (conditional) {
    Code here
}
```
### Implicitly Typed Local Variables

#### Good ####
``` C#
// When the type of a variable is clear from the context, use var 
// in the declaration.
var var1 = "This is clearly a string.";
var var2 = 27;
var var3 = Convert.ToInt32(Console.ReadLine());
```

#### Bad ####
``` C#
// Naming the following variable inputInt is misleading. 
// It is a string.
var inputInt = Console.ReadLine();
Console.WriteLine(inputInt);
```

These are all taken from the Microsoft dotnet style guide.
## Coding conventions for Unity

Here is a resource on coding conventions for Unity.

https://unity3d.college/2016/05/16/unity-coding-standards/

The reason why coding conventions are suggested is that they help programmers with creating maintainable codebases. 

## What to avoid

### Public Fields

Avoid public fields and try to create private properties with getters and setters.

### Large Classes

Try to keep class sizes maintainable. In terms of what is maintainable, please keep class sizes around 100 to 200 lines of code. This will help keep classes more maintainable.

### Large Methods 

This is a nail in the coffin. Avoid large methods as much as you can. Smaller methods lead to more maintainable code and more resusability. Samller functions are good.

## Recommendations for class

While it is not required to use Visual Studio for your IDE, we highly recommend that you do.
Visual Studio developed by Microsoft and makes developing C# a more streamlined experience. 
It also has style configuration that will help ensure adherence to the .Net style guide.

Here is a resource for configuring Visual Studio for .Net style.

https://docs.microsoft.com/en-us/visualstudio/ide/reference/options-text-editor-csharp-formatting?view=vs-2019

If any of the documentation is ambiguous, then please email the TA.
