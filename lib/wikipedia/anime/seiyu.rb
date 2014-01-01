# -*- coding: utf-8 -*-

module Wikipedia
  module Anime
    # 声優クラス
    #
    # 1つの声優をあらわします。
    #
    # Examples
    #
    #   seiyu = Wikipedia::Anime::Seiyu.find('豊崎愛生')
    #   # => #<Wikipedia::Anime::Seiyu ...>
    #
    class Seiyu
      attr_accessor :name, :kana, :gender, :twitter_username, :wikipedia_url

      # Public: Character を初期化します。
      #
      # args - 属性のハッシュ
      #        :nama             - String, 名前
      #        :kana             - String, かな名
      #        :gender           - String, 性別 male or female
      #        :twitter_username - String, @なしのTwitterユーザー名
      #        :wikipedia_url    - String, WikipediaページのURL
      #
      def initialize(args = {})
        @name             = args[:name]
        @kana             = args[:kana]
        @gender           = args[:gender]
        @twitter_username = args[:twitter_username]
        @wikipedia_url    = args[:wikipedia_url]
      end

      # Public: アニメタイトルを返します。
      #
      # title - String, タイトル名
      #
      # Wikipedia::Anime::Title オブジェクトを返します。
      def self.find(title)
        SeiyuParser.new(Wikipedia.find(title)).execute.seiyu
      end

      # Public: 属性値の配列を返します。
      #
      # Array を返します。
      def values
        [@name, @kana, @gender, @twitter_username, @wikipedia_url]
      end
    end
  end
end
