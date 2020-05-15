# Yuri-ita

🚧 This gem is in active development 🚧

The yuri-ita (揺り板), Japanese for "rocking plate", is a traditional wooden gold
pan used in Japan.

[Check out a demo application showcasing some of the capabilities of the
library.][demo]

[demo]: https://yuriita-prerelease.herokuapp.com/movies

## What is Yuri-ita?

The goal of this library is to provide developers and designers with a powerful
set of tools to build expressive user interfaces for filtering, searching, and
sorting data in Ruby on Rails. It does not provide UI components but instead
offers a simple API that allows you to build your own UI.

Yuri-ita's primary interface is through a text-based query language. This
provides a means to create behavior as simple or as complex as your needs
require.


```
is:published author:eebs category:rails sort:created-asc "advanced filtering"
```

Yuri-ita allows you to define what each input means within your application.
`is:published` may mean different things in different applications, or even in
different interfaces within the same application. You define what query to run
for each input and Yuri-ita handles combining all the inputs into a valid result.

You can create static filters that always run the same query:

```ruby
input = Yuriita::Inputs::Expression.new("is", "published")

Yuriita::ExpressionFilter.new(input: input) do |relation|
  relation.where(published: true)
end
```

You can also define dynamic filters that use the input term in the query itself:


```ruby
Yuriita::DynamicFilter.new(qualifier: "author") do |relation, input|
  relation.joins(:author).where(users: {username: input.term})
end
```

Some inputs can be specified multiple times in the query input and Yuri-ita
combines them using AND or OR logical expressions depending on how you've
configured the filter definitions. For example, `category:rails category:ruby`
could be defined such that it returns posts in either the "rails" *or* "ruby"
category.

Other features such as searching, sorting, and generating custom UI are possible
with Yuri-ita.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "yuri-ita"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yuri-ita

For instructions on how to integrate Yuri-ita with your Rails application,
[view the Getting Started documentation](docs/getting_started).

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
