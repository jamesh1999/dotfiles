# Comments and Docstrings Guidelines

Principles for when to use comments, docstrings, and inline documentation in code.

## Core Principle

The code itself should be self-documenting. Comments are for things the code cannot express. Good comments explain *why* something is done, not *what* it does.

## The Self-Documenting Baseline

Names, structure, and types should convey intent. If you need a comment to explain what the code does, rewrite the code first.

```python
# Bad -- the code explains itself; the comment is redundant
increment = increment + 1

# Good -- the comment explains the non-obvious decision
# Using dict lookup instead of linear scan because the lookup
# dominates the cost profile (~3x measured improvement)
user_cache: dict[str, User] = {}
```

## When Comments Are Warranted

Comments earn their place when they explain reasoning the code cannot:

- **Gotchas** -- correct but surprising behaviour
- **Bugfixes** -- link to the issue, explain the root cause, note when the workaround can be removed
- **Hacks** -- workarounds for platform bugs, race conditions, or API limitations
- **Performance trade-offs** -- optimisations that obscure intent but are necessary
- **Non-obvious design decisions** -- why one approach was chosen over alternatives

## When Comments Are Not Warranted

- Restating the obvious (`i += 1 # increment i`)
- Step-by-step narration of control flow
- Duplicated information from docs or type signatures
- Usage examples (point to docs instead)
- Temporal commentary ("Changed in v2.0 to fix X" -- git has the history)

## Docstrings

Docstrings belong on public interfaces. They are the reader's first exposure to a function or class.

### The Perfect Docstring

One sentence. A clear summary of what the thing does -- nothing more.

```python
def load_config(path: str) -> dict:
    """Load and validate a JSON configuration file from disk."""
```

### When One Sentence Is Not Enough

Complex functionality, branching behaviour, or subtle invariants justify more. Include:

- Behaviour that depends on parameters or state
- Non-obvious side effects
- Edge cases and error conditions

### Docstring Anti-patterns

- Parameter-by-parameter restatements of the function signature
- Tutorials or walkthroughs
- Implementation details (the code shows this)
- Changelogs ("Fixed in v1.2" -- git handles this)

## Inline Code Comments

Inline comments should be unusual -- they flag something worth pausing over. A blank line above the comment helps it visually stand out from surrounding code.

A good inline comment has two parts: the context (what is happening on the next line) is obvious from the code itself; the value-add is the reasoning.

```python
# The database does not support optimistic locking on this table,
# so we fall back to a SELECT-then-UPDATE with a uniqueness check.
# See: internal-bug-tracker/issue/421
await row.upsert()
```

## Naming Over Commenting

Before reaching for a comment, check whether a better name would solve the problem. A well-chosen function name is worth a one-line comment every time.

```python
# Bad -- comment needed because the intent is unclear
result = calculate(x, y)

# Good -- the name is self-explanatory
result = calculate_moving_average(raw_x, raw_y)
```
