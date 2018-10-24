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

There is more than one framework but for no particular reason i settled on **Quick** which is accompanied by **Nimble**. So i'm much obliged to tell a bit about them.

##### Quick

> Quick is a behavior-driven development framework for Swift and Objective-C. Inspired by [RSpec](https://github.com/rspec/rspec), [Specta](https://github.com/specta/specta), and [Ginkgo](https://github.com/onsi/ginkgo).



##### Nimble





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

## Command Line Interfaces in Swift

### What is CLI?

## Swift Package Manager

### What is SPM?

### Why and how to use SPM?

#### Crossplatform

### When not to use SPM?

### Great profits of SPM

#### Generating Xcode project from Swift.package

#### Testing on linux

## Goodies

### Makefile





## Loolz

Here is an image of a test after and before it was fixed to run on linux.

![Screen Shot 2018-10-22 at 18.57.07](../../../Screenshots/Screen Shot 2018-10-22 at 18.57.07.png)

Well here is why

![Screen Shot 2018-10-23 at 12.59.33](../../../Screenshots/Screen Shot 2018-10-23 at 12.59.33.png)
