# Getting started

## Principles

- providing relations so you can use existing scopes
- self-contained queries

- Filtering
- Searching
- Sorting


A note on design: Avoid tables, too much data, sorting as a means of
  filtering, etc

## Creating a table

### The relation

### The input string

### The configuration


## Rendering a table

### The query input

### Clearing the query input

You may wish to add a means to clear the current filters, searches, and sorts to
your UI. Yuri-ita does provide an explicit means to reset the filters, but it
does allow you to query the table to determine if it is currently filtered or
not.

```ruby
table = Yuriita::Table.new(param_key: :q, params: { q: "is:published" })
table.filtered? #=> true

table = Yuriita::Table.new(param_key: :q, params: { q: "" })
table.filtered? #=> false
```

You may use this `.fitlered?` method to conditionally render a link to reload
the page without any query parameters.

```erb
<% if table.filtered? %>
  <%= link_to "Clear all", posts_path %>
<% end %>
```

This will reload the page without the table's query parameter, effectively
resetting the table. There is no explicit reset because we want to leave it up
to you to decide what "resetting" means. Resetting for your application may be
reloading the page with some other default parameters.


```erb
<% if table.filtered? %>
  <%= link_to "Clear all", posts_path(list: "mine") %>
<% end %>
```

### Rendering Options

For some types of collections, Yuri-ita provides an API which you can use to
generate the UI of your choosing.


```erb
<% table.options_for(:status).each do |option| %>
  <% classes = option.selected? ? ["active"] : [] %>
  <% link_to option.name, posts_path(option.params), class: classes %>
<% end %>

# Generated HTML:
# <a href="/posts?q=is:published" class="active">Published</a>
# <a href="/posts?q=is:draft">draft</a>
```
