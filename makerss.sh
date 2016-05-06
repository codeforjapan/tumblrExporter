#!/bin/bash

cd `dirname $0`
cat << EOF > rss.xml
<?xml version="1.0" encoding="UTF-8" ?>
<rss xmlns:dc="http://purl.org/dc/elements/1.1/" version="2.0">
  <channel>
    <description>
      市民参加型のコミュニティ運営を通じて、地域の課題を解決するためのアイディアを考え、テクノロジーを活用して公共サービスの開発や運営を支援していく非営利団体です。
    </description>
    <title>Code for Japan - ともに考え、ともにつくる</title>
    <generator>Tumblr (3.0; @next-c4j)</generator>
    <link>http://code4japan.org/</link>
EOF
cat ./out/*.xml >> rss.xml
cat << EOF >> rss.xml
  </channel>
</rss>
EOF

