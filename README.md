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
  - [ ] adminko udelam tak ze se bude cist schema db a podle tabulek se bude routovat a data k te route budou jako deklarace te tabulky. z ni se vysere form. Form se odesle na tu stejnou routu  na ktere jsem a zkontroluje se jestli zaslany data jsou validni oproti tem datovym typum a validatorum ve schematu. Nezapomenout checkovat injecty.
  - ne tak pujde to uplne bez php , proste bude v datech pro template uvedena naka <data:cond skupina='editor'/> a podle toho se bude ridit pristupnost te routy,
  dale tam muze byt uveden mapping prichazejicich dat pres post na entity: <data:map value="blabla" to="product.feedback">
  validace se budou brat podle toho co je ve shematu v entitach. 
  tzn. ze pokud budu chtit zprovoznit adminko tak si ve schematu zadefinuju users a pripadne role a skupiny a provazuje a potom v route admin budu mit data-file s podminkou <data:entity user in group> ale to musim vymyslet jak jeste asi jakoze se prislusnej post param porovna s datama z entity. a podle toho se rozhodne. Ty podminky muzou byt teoreticky docela komplexni take to promyslet
  <data:auth>
    <data:entity name="user" where="group = 'admin' and username='$username' AND pass = password($password)">
    <data:entity name="user" where="group = 'admin' and cookie='$cookie'">
  </data:auth>

  kdyz jakejkoliv dotaz na entitu skonci nakyma datama tak je to jakoze ok passed auth a jinak ne

  potom prichazejici data se automaticky mapujou oproti entitam co jsou pridane tady ve vyberu
  <data:entity name="objednavka" values="userid = $user"/>
  za dolarama jsou nazvy dat co prichazi v postu a predavaji se automaticky do te sablony (tzn ze musim vzit sablonu a rozsirit ji za behu o prvky xsl:param s tema nazvama a potom zavolat;

