# User

- **Query string**:  Raw input that the user entered manually or was generated via the UI

- **Lexer**:  breaks the query string into tokens

- **Parser**:  Takes the list of tokens and produces a query object

- **Query object**:  Holds a list of expression inputs, keywords, and scope inputs

- **Expression input**:  A qualifier and a term used to apply a developer defined filter to a relation

- **Keyword**:  A search term, potentially in quotes.

- **Scope input**:  An expression input whose qualifier is "in" which is used to scope the keyword search to an attribute of the relation

- **Sort input**: An expression input whose qualifier is "sort" which is used to sort the relation.

# Developer

- **Definition**:  a list of expression filters and keyword filters that define how to apply a query object to a relation

- **Filter**:   A set of matchers, a combination, and a block that produce a list of clauses

    - **Expression filter**:  A filter that can be applied to a list of expression inputs 

    - **Keyword filter**:  A filter that can be applied to a list of keywords and optional scope inputs

    - **Sorter**: A filter that can be applied to a sort input.

- **Matcher**:  A test for whether to apply a given filter or keyword search to a given expression input or scope input

- **Combination**:  How one or more inputs for a given filter are combined (ex: label:red label:blue, combination says whether it's Or or And)

- **Block**:  How a relation is queried/scoped/filtered for the given input (ex: category:dog returns any item in the dog category, however the developer has defined that.)

# Yuri-ita
- **Clause**:  The conditions to be applied to the relation and how they are applied (e**x: where.not(category:fruit) )

- **Sift**:  Takes a relation, definition, and query string.  Uses the definition and the relation to create a runner and then runs the query through the runner. 

- **Assembleer**:  Takes a query and definition and returns clauses

- **Executor**:  Takes clauses and a relation and returns a "filtered" relation

- **Runner**:  Builds a query using the query input, lexer, and parser.  Creates an assembler using the query and definition. Applies clauses to the relation using the executor. Returns a result, which is either success or failure. We'd really prefer that it return a relation. There should be error handling?

- **Result**:  Either a relation or an exception, produced by Sift
