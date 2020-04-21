# Yuri-ita

🚧 This gem is in active development 🚧

The yuri-ita (揺り板), Japanese for "rocking plate", is a traditional wooden gold
pan used in Japan.

The goal of this library is to provide developers with a powerful set of tools
to build expressive user interfaces for filtering, searching, and sorting data
in Ruby on Rails. It does not provide UI components but instead offers a simple
interface that allows you to build your own UI.

[Check out a demo application showcasing some of the capabilities of the
library.][demo]

[demo]: https://yuriita-prerelease.herokuapp.com/movies

## Introduction

Yuri-ita offers a powerful set of tools to build powerful user interfaces that
allow users to find exactly what they need while allowing designers and
developers full control of the UI, filtering, and searching. Powerful primitives
allow developers to compose the query and sorting behavior while using
ActiveRecord scopes that already exist in your application.

Yuri-ita allows you to define a "Table" which represents a particular set of
data, how that data can be filtered and searched, and the current query. Each
table is created from a flexible configuration of behaviors. Developers define
collections of filters, sort options, and search fields. For each collection
they define how each option changes the data, and how options interact with each
other. Two options may be mutually exclusive and so cannot be selected
simultaneously. Two other options may be complementary and combine to either
expand or reduce the filtered data. All of this behavior is chosen by the
developer or designer within a modest set of constraints.

Yuri-ita supports configurable keyword searching in one or more fields. Each
table defines options for searching and how to combine those options.

Through the configuration an expressive query language is created. Each filter,
sort, or search option defines a textual representation. This text
representation can be used directly in a text field to apply filters. Not all
filters need to have an associated UI component, which allows for each table to
have powerful advanced search behavior that can be accessed when needed without
causing visual clutter.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yuri-ita'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yuri-ita

## Usage

### Creating a Table

- The Base Relation
- Params
- Table Configuration

#### Rendering a table

- Options
- Items
- Query input

### Table Configuration

- Filtering and Sorting
  - Exclusive
  - Multiple
  - Single
- Searching
- Dynamically creating options

### Clearing all filters, searches, and sorts

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

## Examples

## Contributing

See the [CONTRIBUTING] document. Thank you, [contributors]!

  [CONTRIBUTING]: CONTRIBUTING.md
  [contributors]: https://github.com/thoughtbot/yuri-ita/graphs/contributors

## License

Open source templates are Copyright (c) 2020 thoughtbot, inc.
It contains free software that may be redistributed
under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## About

![thoughtbot](http://presskit.thoughtbot.com/images/thoughtbot-logo-for-readmes.svg)

Yuri-ita is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We love open source software!
See [our other projects][community]
or [hire us][hire] to help build your product.

  [community]: https://thoughtbot.com/community?utm_source=github
  [hire]: https://thoughtbot.com/hire-us?utm_source=github
