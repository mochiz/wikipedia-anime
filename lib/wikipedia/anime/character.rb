# -*- coding: utf-8 -*-

module Wikipedia
  module Anime

    # キャラクタークラス
    #
    # 1つのキャラクターをあらわします。
    #
    # Examples
    #
    #   character = Wikipedia::Anime::Character.new(name: '平沢唯', kana: 'ひらさわゆい', seiyu: '豊崎愛生')
    #   # => #<Character ...>
    #
    class Character
      attr_accessor :name, :kana, :seiyu, :text

      # Public: Character を初期化します。
      #
      # args - 属性のハッシュ
      #        :nama  - String, キャラクター名
      #        :kana  - String, キャラクターかな名
      #        :seiyu - String, 声優名
      #
      def initialize(args = {})
        @name  = args[:name]
        @kana  = args[:kana]
        @seiyu = args[:seiyu]
      end

      # Public: 属性値の配列を返します。
      #
      # Array を返します。
      def values
        [@name, @kana, @seiyu]
      end
    end
  end
end
