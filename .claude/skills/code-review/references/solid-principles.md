# SOLID Principles

Reference for evaluating SOLID adherence in code. These are the five object-oriented design principles introduced by Robert C. Martin. Rate how well each is applied when relevant.

---

## S -- Single Responsibility Principle

A class, module, or function should have **one reason to change**. If a component does two things, consider splitting it.

**Check for:**
- A class with methods that operate on unrelated domains
- A function that performs input validation, business logic, database writes, and logging
- A module with mixed responsibilities (e.g. API handlers mixed with data migration logic)

**Common violations:**
- God classes / god functions that do everything
- Controllers that contain business logic instead of delegating
- Services that are named with "and" (e.g. `UserAndOrderService`)

---

## O -- Open/Closed Principle

Software entities (classes, modules, functions) should be **open for extension but closed for modification**. New behaviour should be added by writing new code, not by changing existing code.

**Check for:**
- Long if/else or switch statements that could be replaced with polymorphism or strategy patterns
- Functions that need to be modified every time a new case is added
- Hard-coded conditional branches where new variants are likely

**Common patterns that help:**
- Polymorphism via interfaces / abstract base classes
- Strategy pattern for interchangeable algorithms
- Composition over hard-coded inheritance chains

---

## L -- Liskov Substitution Principle

Objects of a superclass should be **replaceable** with objects of a subclass without breaking the program. Subtypes must honour the contracts of their base types.

**Check for:**
- Subclasses that throw new exceptions the base class does not declare
- Subclasses that require additional preconditions (e.g. a non-null parameter where the base allows null)
- Subclasses with weaker postconditions (e.g. returning `Optional[T]` where the base guarantees `T`)
- `instanceof` / type checks that break polymorphism

**Rule of thumb:** If a subclass needs special handling by the caller, it violates Liskov.

---

## I -- Interface Segregation Principle

Clients should not be forced to depend on interfaces they do not use. **Many specific interfaces are better than one general-purpose interface.**

**Check for:**
- Fat interfaces with dozens of methods (a "blob" or "god" interface)
- Classes implementing methods they don't need (often throwing `NotImplementedError` or `NoSuchMethodError`)
- One-size-fits-all repository or service interfaces

**Guidance:** Split large interfaces into focused ones. A reader of an interface should be able to reason about all its methods without scanning for the ones they care about.

---

## D -- Dependency Inversion Principle

High-level modules should not depend on low-level modules. **Both should depend on abstractions.** Abstractions should not depend on details; details depend on abstractions.

**Check for:**
- Concrete imports of database drivers, HTTP clients, or filesystem modules in application logic
- Factories or builders instantiated directly inside business logic
- Lack of dependency injection where swapping implementations should be easy

**Helpful signals:**
- Dependencies passed as constructor or function arguments rather than hard-coded
- Abstractions (protocols, interfaces) defining the contract, concrete implementations at the edge of the system
- A dependency graph that flows inward: low-level details depend on high-level abstractions
