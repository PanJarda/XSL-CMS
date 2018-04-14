# Install

```
mysql -u root -p < db.sql
php -S localhost:8080 -t .
```

todo:
  - [ ] v xsl templatech umoznit modifikovat headers abych mohl treba srat textovy output jako api nebo rss
  - [ ] generovat adminko
  - [ ] rekurzivni routy
  - [ ] parametrizovane routy +
  - [ ] parametrizovane datove templaty napr. pro preklady (pres <data:param select="xpath query"> pripadne {xpath})
  - [ ] add junction table to entities
  - [ ] rename entittes model from tables to entities and fields
  - [ ] adminko udelam tak ze se bude cist schema db a podle tabulek se bude routovat a data k te route budou jako deklarace te tabulky. z ni se vysere form. Form se odesle na tu
  - create triggers from validation regexes