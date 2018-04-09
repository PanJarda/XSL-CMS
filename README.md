# Install

```
mysql -u root -p < db.sql
php -S localhost:8080 -t .
```

todo:
 [ ] v xsl templatech umoznit modifikovat headers abych mohl treba srat textovy output jako api nebo rss
 [ ] xml schema pro entity, z nich se vygeneruje databaze, zaroven se z nich budou generovat formulare do administrace a daji se pouzit misto sql dotazu, proste zavolam entitu. (musim jeste mapovat prichazejici post pozadavky na tu danou entitu)