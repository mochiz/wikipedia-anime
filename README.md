# Wikipedia::Anime

[![Build Status](https://travis-ci.org/mochiz/wikipedia-anime.png?branch=master)](https://travis-ci.org/mochiz/wikipedia-anime)
[![Code Climate](https://codeclimate.com/github/mochiz/wikipedia-anime.png)](https://codeclimate.com/github/mochiz/wikipedia-anime)

## Installation

Add this line to your application's Gemfile:

    gem 'wikipedia-anime'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wikipedia-anime

## Usage

anime characters.

```ruby
[1] pry(main)> require 'wikipedia/anime'
[2] pry(main)> title = Wikipedia::Anime::Title.find('けいおん!')
=> #<Wikipedia::Anime::Title:0x007f81a3117340...
[3] pry(main)> title.characters
=> [#<Wikipedia::Anime::Character:0x007f81a40b5a18
  @kana="ひらさわ ゆい",
  @name="平沢唯",
  @seiyu="豊崎愛生">,...
[4] pry(main)> title.character_names
=> ["平沢唯",
 "秋山澪",...
[5] pry(main)> title.seiyu_names
=> ["豊崎愛生",
 "日笠陽子",...
```

anime staffs.

```ruby
[1] pry(main)> require 'wikipedia/anime'
[2] pry(main)> title = Wikipedia::Anime::Title.find('けいおん!')
=> #<Wikipedia::Anime::Title:0x007f81a3117340...
[3] pry(main)> title.staffs
=> [#<Wikipedia::Anime::Staff:0x007f9a9db508a8 @name="山田尚子", @position="監督">,
 #<Wikipedia::Anime::Staff:0x007f9a9db50420 @name="吉田玲子", @position="シリーズ構成">,
 ...
[4] pry(main)> title.staffs.first.values
=> ["監督", "山田尚子"]
```

seiyu information.

```ruby
[1] pry(main)> require 'wikipedia/anime'
[2] pry(main)> seiyu = Wikipedia::Anime::Seiyu.find('日笠陽子')
=> #<Wikipedia::Anime::Seiyu:0x007ff2e22ff4e0
 @gender="女性",
 @kana="ひかさ ようこ",
 @name="日笠陽子",
 @twitter_username="hikasayokoSP",
 @wikipedia_url="http://ja.wikipedia.org/wiki/%E6%97%A5%E7%AC%A0%E9%99%BD%E5%AD%90">
[3] pry(main)> seiyu.values
=> ["日笠陽子",
 "ひかさ ようこ",
 "女性",
 "hikasayokoSP",
 "http://ja.wikipedia.org/wiki/%E6%97%A5%E7%AC%A0%E9%99%BD%E5%AD%90"]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
