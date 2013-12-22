# -*- coding: utf-8 -*-

# 日本語Wiki用に設定を変更します
#
# Wikipedia APIの接続先をjaに変更します
Wikipedia.Configure do
  domain 'ja.wikipedia.org'
  path   'w/api.php'
end
