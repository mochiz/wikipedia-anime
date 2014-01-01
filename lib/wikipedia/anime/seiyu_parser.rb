# -*- coding: utf-8 -*-

module Wikipedia
  module Anime
    # 声優パーサークラス
    #
    # Wikipediaページのコンテンツテキストから声優情報をパースします。
    #
    # Examples
    #
    #   page = Wikipedia.find('日笠陽子')
    #   parser = Wikipedia::Anime::SeiyuParser.new(page).execute
    #   parser.seiyu => #<Wikipedia::Anime::Seiyu...>
    #
    class SeiyuParser
      attr_accessor :seiyu, :page, :content

      # Public: 新しいインスタンスを生成します。
      #
      # page - Wikipedia::Pageインスタンス
      def initialize(page)
        @page    = page
        @content = page.content
      end

      # Public: 声優情報をパースします。
      #
      # 自分自身を返します。
      def execute
        return nil unless @content
        @seiyu = parsed_seiyu
        self
      end

      private

      # Public: 声優情報をパースして返します。
      #
      # Wikipedia::Anime::Seiyu オブジェクトを返します。
      def parsed_seiyu
        Seiyu.new(name: name,
                  kana: kana,
                  gender: gender,
                  twitter_username: twitter_username,
                  wikipedia_url: wikipedia_url,
                  )
      end

      # Internal: 名前を返します。
      #
      # String を返します。
      def name
        @content.match(/名前\s*=(.*)/) do |match|
          return match[1].gsub(/\s+/, '')
        end
        @content.match(/芸名\s*=(.*)/) do |match|
          return match[1].gsub(/\s+/, '')
        end
        @page.title
      end

      # Internal: ふりがなを返します。
      #
      # String を返します。
      def kana
        @content.match(/ふりがな\s*=(.*)/) do |match|
          return match[1].strip
        end
        name.tr('ァ-ン', 'ぁ-ん')
      end

      # Internal: 性別を返します。
      #
      # String または nil を返します。
      def gender
        if @page.categories
          return '女性' if @page.categories.include?('Category:日本の女性声優')
          return '女性' if @page.categories.include?('Category:日本の女優')
          return '男性' if @page.categories.include?('Category:日本の男性声優')
          return '男性' if @page.categories.include?('Category:日本の俳優')
        end
        @content.match(/性別\s*=(.*)/) do |match|
          return match[1].gsub(/\[\[|\]\]/, '').strip
        end
        nil
      end

      # Internal: Twitterユーザー名を返します。
      #
      # String または nil を返します。
      def twitter_username
        @content.match(/{{Twitter\|(.*?)\|/) { |match| match[1] }
      end

      # Internal: Wikipedia URLを返します
      #
      # String を返します。
      def wikipedia_url
        URI.encode("http://ja.wikipedia.org/wiki/#{@page.title}")
      end
    end
  end
end
