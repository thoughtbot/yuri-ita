# Yuri-Ita

The yuri-ita (揺り板), Japanese for "rocking plate" is a traditional wooden gold
pan used in Japan.

## Introduction

The goal of this library is to provide developers with a powerful set of tools
to build expressive user interfaces for filtering, searching, and sorting data.

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

There are a few steps needed to get started.

- Define a [Query Definition][1] with Filters
- Call `Yuriita.filter` passing an initial relation, the query string, and the
  query definition

  ```ruby
  result = Yuriita.filter(
    Post.all,
    'ruby author:eebs is:published label:"good code"',
    query_definition: definition,
  )
  ```
- Check if the [Result][2] a is success or an error

[1]: #defining-a-query-definition
[2]: #result-object

### Defining a Query Definition

#### Static Filters

#### Value Filters

### Query Input

### Result object

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eebs/yuri-ita.
