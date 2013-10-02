# Wikipedia::Anime

TODO: Write a gem description

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
[2] pry(main)> Wikipedia::Anime::CharacterParser.new('けいおん!').execute
=> [{:name=>"平沢唯", :kana=>"ひらさわゆい", :seiyu=>"豊崎愛生"},
 {:name=>"秋山澪", :kana=>"あきやまみお", :seiyu=>"日笠陽子"},
 {:name=>"田井中律", :kana=>"たいなかりつ", :seiyu=>"佐藤聡美"},
 {:name=>"琴吹紬", :kana=>"ことぶきつむぎ", :seiyu=>"寿美菜子"},
 {:name=>"中野梓", :kana=>"なかのあずさ", :seiyu=>"竹達彩奈"},
 {:name=>"山中さわ子", :kana=>"やまなかさわこ", :seiyu=>"真田アサミ"},
 {:name=>"平沢憂", :kana=>"ひらさわうい", :seiyu=>"米澤円"},
 {:name=>"真鍋和", :kana=>"まなべのどか", :seiyu=>"藤東知夏"},
 {:name=>"鈴木純", :kana=>"すずきじゅん", :seiyu=>"永田依子"}]
```

seiyu information.

```ruby
[1] pry(main)> require 'wikipedia/anime'
[2] pry(main)> Wikipedia::Anime::SeiyuParser.new('日笠陽子').execute
=> {:name=>"日笠陽子",
 :sort_name=>"ひかさようこ",
 :gender=>"female",
 :twitter_username=>"hikasayokoSP",
 :wikipedia_url=>
  "http://ja.wikipedia.org/wiki/%E6%97%A5%E7%AC%A0%E9%99%BD%E5%AD%90",
 :search_text=>"ひよっち ぴかしゃなど"}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
