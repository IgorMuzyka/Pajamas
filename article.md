# BDD approach for CLI application development in Swift

[TOC]

## Behaviour Driven Development in Swift

### What is BDD?

In software engineering, **behavior-driven development (BDD)** is a software development process that emerged from **test-driven development (TDD).**

#### Then what is TDD?

**Test-driven development** is a software development process that relies on the **repetition of** a very **short** development **cycle**: **requirements** are **turned** into very **specific test cases**, then the **software is improved** to **pass** the **new tests, only**. 

#### And back to BDD 

**Behavior-driven development** **combines** the general **techniques** and **principles** of **TDD** with **ideas** from **domain-driven design** and **object-oriented analysis** and **design** to provide software development and management teams with **shared tools** and a **shared process** to **collaborate on** software **development**.

So, speaking in human terms developers get to work closer with management by first writing test cases to the specification provided by management which are more about interaction with the app and how it should happen and then make code satisfy this new test cases.

#### Why bother?

##### If it's not tested it's not working

While BDD is more about management than development if we as developers can accept that writing tests is a must, cause if it's not tested it's not working. If we owe to make some quality code it must be tested. 

Yet even better if we do development TDD style why not go one step further and try BDD approach. 

##### Story vs. Specification

The big difference between TDD and BDD is that while applying BDD you write test to the specifiation and test describes behaviour rather than unit of implementation, so it's simpler to comprehend for humans. 

### How to approach it?

#### Workflow

Test-driven development is a software development methodology which essentially states that for each unit of software, a software developer must:

- define a test set for the unit *first*.
- make the tests fail.
- then implement the unit.
- finally verify that the implementation of the unit makes the tests succeed.

This definition is rather non-specific in that it allows tests in terms of high-level software requirements, low-level technical details or anything in between. One way of looking at BDD therefore, is that it is a continued development of TDD which makes more specific choices than TDD.

Behavior-driven development specifies that tests of any unit of software should be specified in terms of the desired behavior of the unit.

Borrowing from agile software development the "desired behavior" in this case consists of the requirements set by the business — that is, the desired behavior that has business value for whatever entity commissioned the software unit under construction.

#### Quick & Nimble

There is more than one framework but for no particular reason i settled on **Quick** which is accompanied by **Nimble**. So i'm much obliged to at least introduce them.

##### Quick

> Quick is a behavior-driven development framework for Swift and Objective-C. Inspired by [RSpec](https://github.com/rspec/rspec), [Specta](https://github.com/specta/specta), and [Ginkgo](https://github.com/onsi/ginkgo).

Quick is the one thing that will actually run your tests and which allows you to define specifications.

##### Nimble

> Use Nimble to express the expected outcomes of Swift or Objective-C expressions. Inspired by [Cedar](https://github.com/pivotal/cedar).

Nimble is a matcher framework for Quick which provides you with an awesome DSL for setting your expectations from low to high.

#### Specification DSL

Today most of testing frameworks utilize some kind of DSL to express tests. 

DSL is a computer langauge specialized to a particular application domain. 

When you write your tests to match specification which are mostly plain english you get benefit of your test cases looking almost exactly the same as specification to which they are done. 

Or even better if you are developing software as a sole proprietor tests can literally describe user interaction with an app and all specifications you need is your tests.

![test.case.dsl.example.png](images/test.case.dsl.example.png)


```swift
context("If Project was not previously created") {
    it("should initialize successfully") {
        expect(SwiftShell.run(bash: "\(binary) init Pajamas").stdout)
            .to(equal("Good luck with your new project: Pajamas"))
    }
}
```


And if test framework logs everything in a right way, log provides understanding of what's broken for even non technical humans on the project.

![failing.test.readability.example](images/failing.test.readability.example.png)



## Swift Package Manager

### What is SPM?

The Swift Package Manager is a tool for managing distribution of source code, aimed at making it easy to share your code and reuse others’ code. The tool directly addresses the challenges of compiling and linking Swift packages, managing dependencies, versioning, and supporting flexible distribution and collaboration models.

Apple designed the system to make it easy to share packages on services like GitHub, but packages are also great for private personal development, sharing code within a team, or at any other granularity.

Note that at this time the Package Manager has no support for iOS, watchOS, or tvOS platforms.

The Package Manager is included in Swift 3.0 and above.

### Pros

- Generating Xcode project on the fly, no more conflicts in Xcode project ever.
- Manage your dependencies by editing a single file which is Package.swift.
- Build, run and test on linux and macOS and even in Xcode.
- File structure is a single point of trust, rearrange your files and just generate Xcode project and it all synced up.
- You can use system C libraries on linux/bsd/macOS from Swift by just defining a package for them in a right way.
- Edit mode for your dependencies.
- Define Targets, Products and their Dependencies in Package.swift.

### Cons

- Currently does not support building for iOS, watchOs or tvOS (this one is pretty much enough to discourage anyone not interested in Swift on the backend from using SPM).
- Commands to use SPM is a bit verbose unlike the new iPhone names.



## Developing Command Line Interface application in Swift

### What is CLI?

Command line interface (CLI) is a text-based interface that is used to operate software and operating systems while allowing the user to respond to visual prompts by typing single commands into the interface and receiving a reply in the same way.

CLI is quite different from the graphical user interface (GUI) that is presently being used in the latest operating systems.

### Why develop CLI applications?







### Testing on linux

## Goodies

### Makefile





## Loolz

Here is an image of a test after and before it was fixed to run on linux.

![Screen Shot 2018-10-22 at 18.57.07](../../../Screenshots/Screen Shot 2018-10-22 at 18.57.07.png)

Well here is why

![Screen Shot 2018-10-23 at 12.59.33](../../../Screenshots/Screen Shot 2018-10-23 at 12.59.33.png)
