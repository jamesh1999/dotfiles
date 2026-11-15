# Naming Guidelines

General principles for good variable, function, type, and module names. These are not language-specific conventions (camelCase vs snake_case) -- they apply to any language.

## General Principle: Names Should Express Intent

A name is the cheapest form of documentation. Good names make the code self-explanatory. Readers should not have to guess what a name refers to.

---

## Avoid Single-Letter Names

**Single-letter variables (`i`, `x`, `j`) are acceptable only in loop iterators and mathematical contexts.** Everywhere else, they hurt readability.

**Acceptable:**
- `for i in range(...)` -- loop iterator
- `let x = 0` inside a short mathematical expression where the domain is obvious
- Pattern matching / deconstruction where the meaning is structurally clear

**Unacceptable as general variables:**
- `x`, `y`, `z` for coordinates in a function of 10+ lines
- `i`, `j`, `k` outside of loops
- `a`, `b`, `c` for data fields or parameters
- `e` for exceptions (use `err`, `exc`, `error`)

**Why:** Single-letter names carry zero semantic information. The reader must trace back through scope to understand what they refer to, which is a waste of cognitive effort.

---

## Avoid Abbreviations

**Abbreviated names are almost always bad.** They force the reader to decode the name rather than read it. What is obvious to the author is opaque to everyone else.

**Unacceptable:**
- `usr` for `user`
- `acc` for `account` or `accept` or `accuracy` or `acceleration` (which one?)
- `cfg` for `config`
- `req` for `request` (fine as a very local loop variable, bad as a function parameter)
- `mgr` for `manager`

**Acceptable (established conventions):** `id`, `url`, `http`, `api`, `db`, `env`, `args`, `kwargs`

**Rule:** If the unabbreviated name would fit on one line (45 characters is generous), use it. Never abbreviate unless there is a strong, language-wide or project-wide convention.

---

## Names Should Be Pronounceable

If you cannot say a name out loud, you will struggle to discuss it in code reviews, meetings, and bug triage. `DataTransformerV2` is worse than `DataProcessor`. `AsyncRequestCompletionHandler` is worse than `RequestHandler`.

---

## Names Should Be Descriptive of Scope

The longer the scope, the longer the name. A parameter to a 3-line function can be brief. A class-level field should be fully descriptive. A global variable needs a namespace prefix.

---

## Verbs for Functions, Nouns for Types

Functions do things -- name them with verbs or verb phrases. Types represent things -- name them with nouns.

- `calculate_total()` -- good
- `total()` -- ambiguous, possibly bad
- `UserService` -- good
- `User` -- acceptable if the type represents the user entity itself

---

## Boolean Names

Boolean names should read as questions or properties. Prefix with `is_`, `has_`, `can_`, `should_` where natural.

- `is_authenticated` -- good
- `status` -- bad (what does status=1 mean? status=0?)
- `active` -- acceptable on its own

---

## Avoid Redundant Names

Do not repeat the type or context already in the name.

- `User user` -- redundant
- `ErrorMessage message` -- redundant
- `Order order_id` -- redundant (the `_id` suffix already signals it is an identifier)

---

## Avoid Misleading Names

Check for names that could refer to different concepts in different languages or contexts. `Connection` could mean database, network, HTTP, or user session. Use `DbConnection`, `TcpConnection`, `HttpSession` instead.
