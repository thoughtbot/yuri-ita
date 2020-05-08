- **Query string**:  Raw input that the user entered manually or was generated via the UI

- **Lexer**:  breaks the query string into tokens

- **Parser**:  Takes the list of tokens and produces a query object

- **Query object**:  Holds a list of inputs (including expression inputs, keywords, and scope inputs)

- **Expression**:  An input whose qualifier and a term are used to apply a developer defined filter to a relation

- **Keyword**:  A search term, potentially in quotes.

- **Scope**:  An input whose qualifier is "in" which is used to scope the keyword search to an attribute of the relation

- **Sort**: An input whose qualifier is "sort" which is used to sort the relation.

- **Definition**:  a list of expression filters and keyword filters that define how to apply a query object to a relation
    - **Single**: A definition that permits selection of 0 or 1 options

    - **Multiple**: A definition that permits selection of 0 or more options and has a combination used to combine relations when more than one option is selected.

    - **Exclusive**: A definition that permits selection of exactly 1 option and has a default option for when no option has been selected by the user.

- **Collection**: The result of applying a select to a relation
    - **Multiple collection**: A collection resulting from applying the filter(s) from a multiple select along with the combination from a multiple definition

    - **Exclusive collection**: A collection resulting from applying the filter from an exclusive select

    - **Single collection**: A collection resulting from applying the filter from a single select

    - **Search collection**: A collection resulting from applying the filter(s) from an all or explicit select

- **Clause**: Contains the selected filters and a means to combine them.

- **Select**: Given a definition and a query, returns the filter selected by the query that should be applied to a relation
    - **Multiple**: Returns an array of all selected filters

    - **Exclusive**: Returns either the selected filter or the defalt filter

    - **Single**: Returns either the selected filter or false

    - **All or explicit**: Returns either the selected filter or an array of all filters

- **Filter**:   A set of matchers, a combination, and a block that produce a list of clauses

    - **Expression filter**:  A filter that can be applied to a list of expression inputs

    - **Keyword filter**:  A filter that can be applied to a list of keywords and optional scope inputs

    - **Sorter**: A filter that can be applied to a sort input.

- **Configuration**: A list of definitions and scopes that can be applied to a relation

- **Parameter**:

- **Matcher**:  A test for whether to apply a given filter or keyword search to a given expression input or scope input

- **Combination**:  How one or more inputs for a given filter are combined (ex: label:red label:blue, combination says whether it's Or or And)

- **Block**:  How a relation is queried/scoped/filtered for the given input (ex: category:dog returns any item in the dog category, however the developer has defined that.)

# Yuri-ita
- **Yuriita**:  Takes a relation, definition, and query string.  Uses the definition and the relation to create a runner and then runs the query through the runner to return a result.

- **Table**: A combination of a relation, a query input, and a configuration that can return items filtered by the query input or options for a given key, as defined by the configuration.

- **View Option**: An option, selector, and parameters that are used by a table to represent options for a definition.

- **Assembler**:  Takes a configuration and returns clauses

- **Executor**:  Takes clauses and a relation and returns a "filtered" relation

- **Runner**:  Builds a query using the query input, lexer, and parser.  Creates an assembler using the query and definition. Applies clauses to the relation using the executor. Returns a result, which is either success or failure. We'd really prefer that it return a relation. There should be error handling?

- **Result**:  Either a relation or an exception, produced by Yuriita
