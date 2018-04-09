# Install

```
mysql -u root -p < db.sql
php -S localhost:8080 -t .
```

todo:
 - mel bych predelat reference v routeru tak ze muzu nacitat ruzna data s ruznyma templatama.
 - active classu v menu by si mel resit ten template a ne router, tzn. predavat naky request_uri do dat
 - data pro template by mely zustat zapouzdrene v tagu <data> aby se predeslo konfliktu nazvu
 - route value predavat do dat, tim se da nahradit ten <title>
 - v xsl templatech umoznit modifikovat headers abych mohl treba srat textovy output jako api nebo rss