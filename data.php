<?php
$q = '
  <data>
    <articles limit="10" orderby="articles.published" order="asc">
      <title />
      <content />
      <published />
      <users>
        <id match="articles.userId" hide="true"/>
        <nickname />
      </users>
      <categories>
        <name equals="research" />
        <id match="articles.categoryId" hide="true" />
      </categories>
    </articles>
    <users>
    </users>
  </data>
';

$queryTree = simplexml_load_string($q);

function constructQuery($queryTree) {
  foreach($queryTree->children() as $from => $columns) {
    $select = [];
    $where = [];
    $leftjoin = [];
    $others = [];
    $asc;
    foreach($columns->attributes() as $key => $value) {
      if ($key == 'order') {
        $asc = $value == 'asc';
        continue;
      }
      $others[$key] = (string) $value;
    }

    if (!count($columns->children())) {
      array_push($select, '*');
    } else {
      foreach($columns->children() as $colname => $col) {
        if (count($col->children())) {
          foreach($col->children() as $joinedColName => $col) {
            if (!$col['hide'])
              array_push($select, $colname . '.' . $joinedColName);
            if ($col['match'])
              array_push($leftjoin, [$colname, $colname . '.' . $joinedColName . ' = ' . $col['match']]);
            if ($col['equals'])
              array_push($where, $colname . '.' . $joinedColName . ' = ' . '"' . $col['equals'] . '"');
          }
          continue;
        }
        if (!$col['hide'])
          array_push($select, $from . '.' . $colname);

        if ($col['equals'])
          array_push($where, $from . '.' . $colname . ' = ' . '"' . $col['equals'] . '"');
      }
    }
    $res = 'SELECT ' . join(', ', $select) . ' FROM ' . $from;

    if (count($where))
      $res .= ' WHERE ' . join(' AND ', $where);

    foreach($leftjoin as $join1) {
      $res .= ' LEFT JOIN ' . $join1[0] . ' ON ' . $join1[1];
    }
    foreach($others as $key => $val) {
      $res .= ' ' . $key . ' ' . $val;
    }
    $res .= $asc  ? ' ASC' : ' DESC';

    echo $res;
  }
}

constructQuery($queryTree);

?>

<data>
  <table name="articles" limit="10">
    <count>Ahoj</count>
    <col>Title</col>
    <col>Content</col>
    <col orderby="true">Published</col>
    <col id="userId" hide="true">UserId</col>
    <col id="categoryId" hide="true">CategoryId</col>
    <leftjoin>
      <table name="users">
        <col on="#userId" hide="true">id</col>
        <col>Name</col>
      </table>
      <table name="categories">
        <col on="#categoryId" hide="true">id</col>
        <col equals="research" hide="true">Name</col>
      </table>
    </leftjoin>
  </table>
</data>
