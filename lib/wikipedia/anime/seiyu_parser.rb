# -*- coding: utf-8 -*-

module Wikipedia
  module Anime
    class SeiyuParser

      # Public: 新しいインスタンスを生成します。
      #
      # page - Wikipedia::Pageインスタンス
      def initialize(title)
        @page = Wikipedia.find(title)
        @content = @page.content.gsub(' ', '').gsub('：', ':')
      end

      # Public: 声優情報のハッシュを返します。
      #
      # Hash を返します。
      def execute
        parsed_voice_actor
      end

      private

      def parsed_voice_actor
        { name: name,
          sort_name: sort_name,
          gender: gender,
          twitter_username: twitter_username,
          wikipedia_url: wikipedia_url,
          search_text: search_text,
        }
      end

      # Internal: 名前を返します。
      #
      # String を返します。
      def name
        name = @content.scan(/名前=(.*)/)[0][0] if @content.match('名前=')
        name ||= @content.scan(/芸名=(.*)/)[0][0] if @content.match('芸名=')
        return name.gsub(/{{.*\|/, '').gsub('}}', '') if name
        @page.title
      end

      # Internal: ふりがなを返します。
      #
      # String を返します。
      def sort_name
        return name.tr('ァ-ン', 'ぁ-ん') unless @content.match('ふりがな=')
        return name.tr('ァ-ン', 'ぁ-ん') if @content.scan(/ふりがな=(.*)/)[0][0].empty?
        @content.scan(/ふりがな=(.*)/)[0][0]
      end

      # Internal: 性別を返します。
      #
      # String または nil を返します。
      def gender
        return 'male'   if @page.categories.index('Category:日本の男性声優')
        return 'female' if @page.categories.index('Category:日本の女性声優')
        return nil unless @content.match('性別=')
        gender_string = @content.scan(/性別=(.*)/)[0][0].gsub('[[', '').gsub(']]', '')
        gender_string == '男性' ? 'male' : 'female'
      end

      # Internal: Twitterユーザー名を返します。
      #
      # String または nil を返します。
      def twitter_username
        return nil unless @content.match(/{{Twitter\|(.*?)\|/)
        @content.scan(/{{Twitter\|(.*?)\|/)[0][0]
      end

      # Internal: 検索用テキストを返します。
      #
      # String または nil を返します。
      def search_text
        return nil unless @content.match(/愛称=/)
        @content.scan(/愛称=(.*)/)[0][0] \
          .gsub(/<ref>.*?<\/ref>/, '') \
          .gsub(/{{.*?}}/, '') \
          .gsub(/<.*?>/, '') \
          .gsub('、', ' ')
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
