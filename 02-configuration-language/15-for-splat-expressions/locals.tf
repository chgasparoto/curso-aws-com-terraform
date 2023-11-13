locals {
  files                 = ["ips.json", "report.csv", "sitemap.xml"]
  file_extensions       = [for file in local.files : regex("\\.[0-9a-z]+$", file)]
  file_extensions_upper = { for ext in local.file_extensions : ext => upper(ext) if ext != ".json" }

  ips = [
    {
      public : "123.123.123.22",
      private : "123.123.123.23",
    },
    {
      public : "122.123.123.32",
      private : "122.123.123.33",
    }
  ]
}
