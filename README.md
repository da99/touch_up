
# Touch\_Up

I have no idea.

## Installation

    gem 'touch_up'

## Usage


```ruby
require 'touch_up'

puts Touch_Up.new(<<-EOF).to_html
  This is /slanted/.
  This is *strong*.
  This is *my link* www.megauni.com.
  This is lovefm.co.jp.
EOF
```
