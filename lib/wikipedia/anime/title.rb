# -*- coding: utf-8 -*-

module Wikipedia
  module Anime

    # タイトルクラス
    #
    # 1つのアニメタイトルをあらわします。
    #
    # Examples
    #
    #   title = Wikipedia::Anime::Title.find('けいおん!')
    #   # => #<Title ...>
    #
    class Title
      attr_accessor :page

      # Public: Title を初期化します。
      #
      # title - String, タイトル名
      #
      def initialize(title)
        @page = Wikipedia.find(title)
      end

      # Public: アニメタイトルを返します。
      #
      # title - String, タイトル名
      #
      # Wikipedia::Anime::Title オブジェクトを返します。
      def self.find(title)
        self.new(title)
      end

      # Public: キャラクターリストを返します。
      #
      # Wikipedia::Anime::Character の配列を返します。
      def characters
        @characters ||= Wikipedia::Anime::CharacterParser.new(@page).execute.characters
      end

      # Public: キャラクター名リストを返します。
      #
      # String の配列を返します。
      def character_names
        return @character_names if @character_names
        @character_names = []
        characters.each { |character| @character_names << character.name }
        @character_names
      end

      # Public: 声優名リストを返します。
      #
      # String の配列を返します。
      def seiyu_names
        return @seiyu_names if @seiyu_names
        @seiyu_names = []
        characters.each { |character| @seiyu_names << character.seiyu }
        @seiyu_names
      end
    end
  end
end
