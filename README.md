
# Touch\_Up

My mini-alternative to [markdown](http://daringfireball.net/projects/markdown/syntax).
It uses `Regexp` (I know, I know)
  and is most likely useless for your needs.

Most likely, I will stop using this and
just use [RedCarpet](https://github.com/vmg/redcarpet).

That is what you should do: don't use this.
Use [RedCarpet](https://github.com/vmg/redcarpet).

## Installation

    gem 'touch_up'

## Usage


```ruby
require 'touch_up'

puts Touch_Up.new(<<-EOF).to_html
  This is /slanted/.
  This is *strong*.
  This is ~~strike~~.
  This is *my link* www.megauni.com.
  This is lovefm.co.jp.
EOF
```
