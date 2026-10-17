{config, ...}: {
  xdg.configFile = let
    sanitize = "R?//R*//R|//R://R\\\"//R'//R<//R>//R^//R!//R.//R;//R%//R$//R+//R_//R{//R}//R(//R)//R[//R]//R@//R#//R$//R%//R&//R,//R~//R`//R‘//R’//R“//R”//R-//R //";
    pixiv-refresh = "_TcRJxNdbypK26WzjYf2zUPUOiK5i29Yp3mI2_DFy60";
    dateTime = "-FileModifyDate=\\\"{date:Olocal/%Y-%m-%d %H:%M:%S}\\\" -EXIF:DateTimeOriginal=\\\"{date:Olocal/%Y-%m-%d %H:%M:%S}\\\" -OffsetTimeOriginal=\\\"+03:00\\\" -EXIF:CreateDate=\\\"{date:Olocal/%Y-%m-%d %H:%M:%S}\\\" -OffsetTimeDigitized=\\\"+03:00\\\" -ModifyDate=\\\"{date:Olocal/%Y-%m-%d %H:%M:%S}\\\" -OffsetTime=\\\"+03:00\\\" -IPTC:DateCreated=\\\"{date:Olocal/%Y-%m-%d}\\\" -IPTC:TimeCreated=\\\"{date:Olocal/%H:%M:%S}\\\" -IPTC:DigitalCreationDate=\\\"{date:Olocal/%Y-%m-%d}\\\" -IPTC:DigitalCreationTime=\\\"{date:Olocal/%H:%M:%S}\\\"";
  in {
    "gallery-dl/config.json".text = ''
      {
          "extractor":
          {
              "base-directory": "${config.xdg.userDirs.pictures}/",
              "skip": false,

              "path-remove": "̴̵̶̷̸̡̢̧̨̛̖̗̘̙̜̝̞̟̠̣̤̥̦̩̪̫̬̭̮̯̰̱̲̳̹̺̻̼͇͈͉͍͎̀́̂̃̄̅̆̇̈̉̊̋̌̍̎̏̐̑̒̓̔̽̾̿̀́͂̓̈́͆͊͋͌̕̚ͅ͏͓͔͕͖͙͚͐͑͒͗͛ͣͤͥͦͧͨͩͪͫͬͭͮͯ҃҄҅҆҇͘͜͟͢͝͞͠͡҈҉᪵᪶᪷᪸᪹᪺᪽᪰᪱᪲᪳᪴᪻᪼᪾ᪿᫀ᫃᫄᫊᫁᫂᫅᫆᫇᫈᫉᫋ᫌᫍᫎ᫏⃒⃓⃘⃙⃚⃐⃑⃔⃕⃖⃗⃛⃜⃝⃞⃟⃠⃡⃢⃣⃤⃥⃦⃪⃫⃨⃬⃭⃮⃯⃧⃩⃰",

              "#": "write tags for several *booru sites",
              "postprocessors": [
                  {
                      "name": "metadata",
                      "mode": "tags",
                      "whitelist": ["danbooru", "moebooru", "sankaku"]
                  }
              ],

              "wallhaven":
              {
                  "directory": { "purity == 'sketchy'": [ "__wallpapers_sketchy" ], "purity == 'safe'": [ "__wallpapers_safe" ], "": [ "__wallpapers" ]},
                  "filename": {
                      "purity == 'sfw' and width >= height": "--{id}__{width}x{height}_horiz_sfw_{category!l}.{extension}",
                      "purity == 'sfw' and width < height": "--{id}__{width}x{height}_vert_sfw_{category!l}.{extension}",

                      "purity == 'sketchy' and width >= height": "--{id}__{width}x{height}_horiz_spicy{category!l}.{extension}",
                      "purity == 'sketchy' and width < height": "--{id}__{width}x{height}_vert_spicy_{category!l}.{extension}",


                      "width >= height": "--{id}__{width}x{height}_horiz_{category!l}.{extension}",
                      "width < height": "--{id}__{width}x{height}_vert_{category!l}.{extension}",


                      "" : "--{id}__{width}x{height}_{purity!l}_{category!l}.{extension}"
                  },
                  "postprocessors": [
                      {
                      "name": "exec",
                      "command": ["bash", "-c", "exiftool -sep \";\" -P -overwrite_original_in_place -IPTC:Keywords=\"{tags:J;}\" -IPTC:Keywords=\"rating:{purity!l}; category:{wh_category}\" -XMP:Subject=\"{tags:J;}\" -XMP:Subject=\"rating:{purity!l}; category:{wh_category}\" -XMP:PreservedFileName=\"{filename}\" -XMP:Source=\"{source}\" -XMP:CreatorWorkURL=\"wallhaven.cc\" -FileModifyDate=\"{date:Olocal/%Y-%m-%d %H:%M:%S}\" -EXIF:DateTimeOriginal=\"{date:Olocal/%Y-%m-%d %H:%M:%S}\" -OffsetTimeOriginal=\"+03:00\" -EXIF:CreateDate=\"{date:Olocal/%Y-%m-%d %H:%M:%S}\" -OffsetTimeDigitized=\"+03:00\" -ModifyDate=\"{date:Olocal/%Y-%m-%d %H:%M:%S}\" -OffsetTime=\"+03:00\" -IPTC:DateCreated=\"{date:Olocal/%Y-%m-%d}\" -IPTC:TimeCreated=\"{date:Olocal/%H:%M:%S}\" -IPTC:DigitalCreationDate=\"{date:Olocal/%Y-%m-%d}\" -IPTC:DigitalCreationTime=\"{date:Olocal/%H:%M:%S}\" {_directory}/{_filename}"]
                      }
                  ]
              },

              "twitter":
              {
                  "directory": [ "__clearnet_05_twitter" ],
                  "filename": {
                      "width >= height": "=={author[name]!l:${sanitize}}={author[id]}--{tweet_id}__{width}x{height}_horiz_{category!l}_p{num}.{extension}",

                      "width < height": "=={author[name]!l:${sanitize}}={author[id]}--{tweet_id}__{width}x{height}_vert_{category!l}_p{num}.{extension}",

                      "" : "=={author[name]!l:${sanitize}}={author[id]}--{tweet_id}__{width}x{height}_{category!l}_p{num}.{extension}"
                  },

                  "postprocessors": [
                      {
                          "name": "exec",
                          "command": ["bash", "-c", "exiftool -P -overwrite_original_in_place -IPTC:By-line=\"{author[name]}\" -XMP:Creator=\"{author[name]}\" -XMP:PreservedFileName=\"{filename}\" -XMP:Source=\"https x.com {author[name]} status {tweet_id}\" -XMP:CreatorWorkURL=\"x.com\" -FileModifyDate=\"{date:Olocal/%Y-%m-%d %H:%M:%S}\" -EXIF:DateTimeOriginal=\"{date:Olocal/%Y-%m-%d %H:%M:%S}\" -OffsetTimeOriginal=\"+03:00\" -EXIF:CreateDate=\"{date:Olocal/%Y-%m-%d %H:%M:%S}\" -OffsetTimeDigitized=\"+03:00\" -ModifyDate=\"{date:Olocal/%Y-%m-%d %H:%M:%S}\" -OffsetTime=\"+03:00\" -IPTC:DateCreated=\"{date:Olocal/%Y-%m-%d}\" -IPTC:TimeCreated=\"{date:Olocal/%H:%M:%S}\" -IPTC:DigitalCreationDate=\"{date:Olocal/%Y-%m-%d}\" -IPTC:DigitalCreationTime=\"{date:Olocal/%H:%M:%S}\" {_directory}/{_filename}"]
                      }
                  ]
              },

              "pixiv":
              {
                  "directory": [ "__clearnet_05_pixiv" ],
                  "filename": {
                      "sanity_level == 2 and x_restrict == 0 and width >= height": "=={user[name]!l:${sanitize}}--{id}__{width}x{height}_horiz_g_{category!l}_p{num}.{extension}",
                      "sanity_level == 2 and x_restrict == 0 and width < height": "=={user[name]!l:${sanitize}}--{id}__{width}x{height}_vert_g_{category!l}_p{num}.{extension}",

                      "sanity_level == 4 and x_restrict == 0 and width >= height": "=={user[name]!l:${sanitize}}--{id}__{width}x{height}_horiz_s_{category!l}_p{num}.{extension}",
                      "sanity_level == 4 and x_restrict == 0 and width < height": "=={user[name]!l:${sanitize}}--{id}__{width}x{height}_vert_s_{category!l}_p{num}.{extension}",

                      "sanity_level == 6 and x_restrict == 0 and width >= height": "=={user[name]!l:${sanitize}}--{id}__{width}x{height}_horiz_q_{category!l}_p{num}.{extension}",
                      "sanity_level == 6 and x_restrict == 0 and width < height": "=={user[name]!l:${sanitize}}--{id}__{width}x{height}_vert_q_{category!l}_p{num}.{extension}",

                      "x_restrict == 1 and width >= height": "=={user[name]!l:${sanitize}}--{id}__{width}x{height}_horiz_e_{category!l}_p{num}.{extension}",
                      "x_restrict == 1 and width < height": "=={user[name]!l:${sanitize}}--{id}__{width}x{height}_vert_e_{category!l}_p{num}.{extension}",


                      "width >= height": "=={user[name]!l:${sanitize}}--{id}__{width}x{height}_horiz_{category!l}_p{num}.{extension}",
                      "width < height": "=={user[name]!l:${sanitize}}--{id}__{width}x{height}_vert_{category!l}_p{num}.{extension}",


                      "" : "=={user[name]!l:${sanitize}}--{id}__{width}x{height}_{rating!l}_{category!l}_p{num}.{extension}"
                  },
                  "refresh-token": "${pixiv-refresh}",

                  "translated-tags": true,
                  "tags": "translated",
                  "ugoira": true,
                  "archive": "${config.xdg.userDirs.pictures}/==db--gallerydl/archive-pixiv.db",

                  "postprocessors": [
                      {
                        "name": "exec",
                        "command": ["bash", "-c", "exiftool -sep \";\" -P -overwrite_original_in_place -IPTC:Keywords=\"{tags:J;}\" -IPTC:Keywords=\"pixiv_sanity:{sanity_level};pixiv_rating:{x_restrict!s:R1/explicit/R0/sensitive/R2/nsfl/}\" -XMP:Subject=\"{tags:J;}\" -XMP:Subject=\"pixiv_sanity:{sanity_level};pixiv_rating:{x_restrict!s:R1/explicit/R0/sensitive/R2/nsfl/}\" -IPTC:By-line=\"{user[name]}\" -XMP:Creator=\"{user[name]}\" -XMP:PreservedFileName=\"{filename}\" -XMP:Source=\"https://www.pixiv.net/en/artworks/{id}\" -XMP:CreatorWorkURL=\"pixiv.net\" ${dateTime} \"{_directory}/{_filename}\""]
                      },
                      "ugoira-copy"
                  ]
              },

              "danbooru":
              {
                  "ugoira": true,
                  "postprocessors": ["ugoira-webm"]
              },

              "sankaku":
              {
                  "#": "authentication with cookies is not possible for sankaku",
                  "username": "user",
                  "password": "#secret#"
              },

              "furaffinity": {
                  "#": "authentication with username and password is not possible due to CAPTCHA",
                  "cookies": {
                      "a": "01234567-89ab-cdef-fedc-ba9876543210",
                      "b": "fedcba98-7654-3210-0123-456789abcdef"
                  },

                  "descriptions": "html",
                  "postprocessors": ["content"]
              },

              "deviantart":
              {
                  "#": "download 'gallery' and 'scraps' images for user profile URLs",
                  "include": "gallery,scraps",

                  "#": "use custom API credentials to avoid 429 errors",
                  "client-id": "98765",
                  "client-secret": "0123456789abcdef0123456789abcdef",
                  "refresh-token": "0123456789abcdef0123456789abcdef01234567",

                  "#": "put description texts into a separate directory",
                  "metadata": true,
                  "postprocessors": [
                      {
                          "name": "metadata",
                          "mode": "custom",
                          "directory"       : "Descriptions",
                          "content-format"  : "{description}\n",
                          "extension-format": "descr.txt"
                      }
                  ]
              },

              "flickr":
              {
                  "access-token": "1234567890-abcdef",
                  "access-token-secret": "1234567890abcdef",
                  "size-max": 1920
              },

              "mangadex":
              {
                  "#": "only download safe/suggestive chapters translated to English",
                  "lang": "en",
                  "ratings": ["safe", "suggestive"],

                  "#": "put chapters into '.cbz' archives",
                  "postprocessors": ["cbz"]
              },

              "reddit":
              {
                  "#": "only spawn child extractors for links to specific sites",
                  "whitelist": ["imgur", "redgifs"],

                  "#": "put files from child extractors into the reddit directory",
                  "parent-directory": true,

                  "#": "transfer metadata to any child extractor as '_reddit'",
                  "parent-metadata": "_reddit"
              },

              "imgur":
              {
                  "#": "general imgur settings",
                  "filename": "{id}.{extension}"
              },

              "reddit>imgur":
              {
                  "#": "special settings for imgur URLs found in reddit posts",
                  "directory": [],
                  "filename": "{_reddit[id]} {_reddit[title]} {id}.{extension}"
              },

              "tumblr":
              {
                  "posts"   : "all",
                  "external": false,
                  "reblogs" : false,
                  "inline"  : true,

                  "#": "use special settings when downloading liked posts",
                  "likes":
                  {
                      "posts"   : "video,photo,link",
                      "external": true,
                      "reblogs" : true
                  }
              },

              "ytdl":
              {
                  "#": "enable 'ytdl' extractor",
                  "#": "i.e. invoke ytdl on all otherwise unsupported input URLs",
                  "enabled": false,

                  "#": "use yt-dlp instead of youtube-dl",
                  "module": "yt_dlp"
              },

               "gelbooru_v01":
              {
                  "#": "add a custom gelbooru_v01 instance",
                  "#": "this is just an example, this specific instance is already included!",
                  "allgirlbooru": {"root": "https://allgirl.booru.org"},

                  "#": "the following options are used for all gelbooru_v01 instances",
                  "tag":
                  {
                      "directory": {
                          "locals().get('bkey')": ["Booru", "AllGirlBooru", "Tags", "{bkey}", "{ckey}", "{search_tags}"],
                          ""                    : ["Booru", "AllGirlBooru", "Tags", "_Unsorted", "{search_tags}"]
                      }
                  },
                  "post":
                  {
                      "directory": ["Booru", "AllGirlBooru", "Posts"]
                  },
                  "archive": "${config.xdg.userDirs.pictures}/==db--gallerydl/archive-gelbooru_v01_instances.db",
                  "filename": "{tags}_{id}_{md5}.{extension}",
                  "sleep-request": [0, 1.2]
              },

              "gelbooru_v02":
              {
                  "#": "add a custom gelbooru_v02 instance",
                  "#": "this is just an example, this specific instance is already included!",
                  "tbib":
                  {
                      "root": "https://tbib.org",
                      "#": "some sites have different domains for API access",
                      "#": "use the 'api_root' option in addition to the 'root' setting here"
                  }
              },

              "tbib": {
                  "#": "the following options are only used for TBIB",
                  "#": "gelbooru_v02 has four subcategories at the moment, use custom directory settings for all of these",
                  "tag":
                  {
                      "directory": {
                          "locals().get('bkey')": ["Other Boorus", "TBIB", "Tags", "{bkey}", "{ckey}", "{search_tags}"],
                          ""                    : ["Other Boorus", "TBIB", "Tags", "_Unsorted", "{search_tags}"]
                      }
                  },
                  "pool":
                  {
                      "directory": {
                          "locals().get('bkey')": ["Other Boorus", "TBIB", "Pools", "{bkey}", "{ckey}", "{pool}"],
                          ""                    : ["Other Boorus", "TBIB", "Pools", "_Unsorted", "{pool}"]
                      }
                  },
                  "favorite":
                  {
                      "directory": {
                          "locals().get('bkey')": ["Other Boorus", "TBIB", "Favorites", "{bkey}", "{ckey}", "{favorite_id}"],
                          ""                    : ["Other Boorus", "TBIB", "Favorites", "_Unsorted", "{favorite_id}"]
                      }
                  },
                  "post":
                  {
                      "directory": ["Other Boorus", "TBIB", "Posts"]
                  },
                  "archive": "${config.xdg.userDirs.pictures}/==db--gallerydl/custom-archive-file-for-TBIB.db",
                  "filename": "{id}_{md5}.{extension}",
                  "sleep-request": [0, 1.2]
              },

              "urlshortener": {
                  "tinyurl": {"root": "https://tinyurl.com"}
              }
          },

          "downloader":
          {
              "#": "restrict download speed to 1 MB/s",
              "rate": "1M",

              "#": "show download progress indicator after 2 seconds",
              "progress": 2.0,

              "#": "retry failed downloads up to 3 times",
              "retries": 3,

              "#": "consider a download 'failed' after 8 seconds of inactivity",
              "timeout": 8.0,

              "#": "write '.part' files into a special directory",
              "part-directory": "/tmp/.download/",

              "#": "do not update file modification times",
              "mtime": false,

              "ytdl":
              {
                  "#": "use yt-dlp instead of youtube-dl",
                  "module": "yt_dlp"
              }
          },

          "output":
          {
              "log": {
                  "level": "info",

                  "#": "use different ANSI colors for each log level",
                  "format": {
                      "debug"  : "\u001b[0;37m{name}: {message}\u001b[0m",
                      "info"   : "\u001b[1;37m{name}: {message}\u001b[0m",
                      "warning": "\u001b[1;33m{name}: {message}\u001b[0m",
                      "error"  : "\u001b[1;31m{name}: {message}\u001b[0m"
                  }
              },

              "#": "shorten filenames to fit into one terminal line",
              "#": "while also considering wider East-Asian characters",
              "shorten": "eaw",

              "#": "enable ANSI escape sequences on Windows",
              "ansi": true
          },

          "postprocessor":
          {
              "#": "write 'content' metadata into separate files",
              "content":
              {
                  "name" : "metadata",

                  "#": "write data for every post instead of each individual file",
                  "event": "post",
                  "filename": "{post_id|tweet_id|id}.txt",

                  "#": "write only the values for 'content' or 'description'",
                  "mode" : "custom",
                  "format": "{content|description}\n"
              },

              "#": "put files into a '.cbz' archive",
              "cbz":
              {
                  "name": "zip",
                  "extension": "cbz"
              },

              "#": "various ugoira post processor configurations to create different file formats",
              "ugoira-webm":
              {
                  "name": "ugoira",
                  "extension": "webm",
                  "ffmpeg-args": ["-c:v", "libvpx-vp9", "-an", "-b:v", "0", "-crf", "30"],
                  "ffmpeg-twopass": true,
                  "ffmpeg-demuxer": "image2"
              },
              "ugoira-mp4":
              {
                  "name": "ugoira",
                  "extension": "mp4",
                  "ffmpeg-args": ["-c:v", "libx264", "-an", "-b:v", "4M", "-preset", "veryslow"],
                  "ffmpeg-twopass": true,
                  "libx264-prevent-odd": true
              },
              "ugoira-gif":
              {
                  "name": "ugoira",
                  "extension": "gif",
                  "ffmpeg-args": ["-filter_complex", "[0:v] split [a][b];[a] palettegen [p];[b][p] paletteuse"]
              },
              "ugoira-copy": {
                  "name": "ugoira",
                  "extension": "mkv",
                  "ffmpeg-args": ["-c", "copy"],
                  "libx264-prevent-odd": false,
                  "repeat-last-frame": false
              }
          },

          "#": "use a custom cache file location",
          "cache": {
              "file": "${config.xdg.cacheHome}/gallery-dl/cache.sqlite3"
          }
      }
    '';
  };
}
