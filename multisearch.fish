function multisearch
    set query $argv[1]
    set sites "https://yts.mx/browse-movies/$query/all/all/0/latest/0/all" "https://limetorrents.proxyninja.org/search/all/$query/date/1/" "https://1337x.proxyninja.org/sort-search/$query/time/desc/1/" "https://bt4gprx.com/search?q=$query&orderby=seeders&p=1" "https://btdig.com/search?order=0&q=$query" "https://solidtorrents.to/search?q=$query&sort=seeders" "https://vimeo.com/search?q=$query" "https://www.dailymotion.com/search/$query/top-results"
    for url in $sites
        xdg-open $url
    end
end
