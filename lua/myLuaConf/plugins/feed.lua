return {
    {
        "feed",
        for_cat = "general.always",
        cmd = { "Feed" },
        after = function()
            require("feed").setup({
                feeds = {
                    -- These two styles both work
                    -- "https://neovim.io/news.xml",
                    -- {
                    --     "https://neovim.io/news.xml",
                    --     name = "Neovim News",
                    --     tags = { "tech", "news" }, -- tags given are inherited by all its entries
                    -- },

                    -- the above is equivalent to:
                    news = {
                        tech = {
                            { "https://neovim.io/news.xml", name = "Neovim News" },
                            { "http://www.theverge.com/rss/full.xml", name = "The Verge" },
                        },
                    },

                    announcement = {
                        uni = {
                            {"https://ide.ikcu.edu.tr/Rss", name = "ide"},
                            {"https://sbbf.ikcu.edu.tr/Rss", name = "sbbf"},
                            {"https://ikcu.edu.tr/Rss", name = "ikcu"},
                        },
                    },

                    -- three link formats are supported:
                    -- "https://neovim.io/news.xml", -- Regular links
                    -- "rsshub://rsshub://apnews/topics/apf-topnews", -- RSSHub links
                    "neovim/neovim/releases",     -- GitHub links
                },
            })
        end
    },
}
