Map { 
  background-color: @land;
  font-directory: url('font');
}

// =====================================================================
// WATER AREAS
// =====================================================================

#water {
  polygon-fill: @water;
  ::pattern { 
    polygon-pattern-file: url('img/pattern/water.svg');
    [zoom<10] { polygon-pattern-opacity: 0.2; }
    [zoom>=10] { polygon-pattern-opacity: 0.4; }
    polygon-pattern-alignment: local;
    comp-op: overlay;
  }
  [zoom<=5] {
    polygon-gamma: 0.4;
  }
  ::blur {
    polygon-fill: #ffffff;
    comp-op: soft-light;
    image-filters: agg-stack-blur(4,4);
    image-filters-inflate: true;
    polygon-geometry-transform: translate(2,2);
    polygon-clip: false;
  }
}

// =====================================================================
// WATER WAYS
// =====================================================================

#waterway[zoom>=8][zoom<=11],
#waterway[class='river'][zoom>=12],
#waterway[class='canal'][zoom>=12] {
  line-color: @water;
  [zoom=8] { line-width: 0.1; }
  [zoom=9] { line-width: 0.2; }
  [zoom=10] { line-width: 0.4; }
  [zoom=11] { line-width: 0.6; }
  [zoom=12]{ line-width: 0.8; }
  [zoom=13]{ line-width: 1; }
  [zoom>12]{
    line-cap: round;
    line-join: round;
  }
  [zoom=14]{ line-width: 1.5; }
  [zoom=15]{ line-width: 2; }
  [zoom=16]{ line-width: 3; }
  [zoom=17]{ line-width: 4; }
  [zoom=18]{ line-width: 5; }
  [zoom=19]{ line-width: 6; }
  [zoom>19]{ line-width: 7; }
}

#waterway[class='stream'][zoom>=13],
#waterway[class='stream_intermittent'][zoom>=13] {
  line-color: @water;
  [zoom=13]{ line-width: 0.2; }
  [zoom=14]{ line-width: 0.4; }
  [zoom=15]{ line-width: 0.6; }
  [zoom=16]{ line-width: 0.8; }
  [zoom=17]{ line-width: 1; }
  [zoom=18]{ line-width: 1.5; }
  [zoom=19]{ line-width: 2; }
  [zoom>19]{ line-width: 2.5; }
  [class='stream_intermittent'] {
    [zoom>=13] { line-dasharray:20,3,2,3,2,3,2,3; }
    [zoom>=15] { line-dasharray:30,6,4,6,4,6,4,6; }
    [zoom>=18] { line-dasharray:40,9,6,9,6,9,6,9; }
  }
}

#waterway[class='ditch'][zoom>=15],
#waterway[class='drain'][zoom>=15] {
  line-color: @water;
  [zoom=15]{ line-width: 0.1; }
  [zoom=16]{ line-width: 0.3; }
  [zoom=17]{ line-width: 0.5; }
  [zoom=18]{ line-width: 0.7; }
  [zoom=19]{ line-width: 1; }
  [zoom>19]{ line-width: 1.5; }
}

// =====================================================================
// LANDUSE
// =====================================================================

#landuse[zoom>=7] {
  polygon-opacity: 0.5;
  [class='pitch'] {
    polygon-fill: @pitch;
    [zoom>14] {
      line-width:0.8;
      line-color:lighten(@pitch,8);
    }
    [zoom=16] { line-width:1; }
    [zoom=17] { line-width:1.2; }
    [zoom=18] { line-width:1.4; }
  }
  [class='school'] {
    polygon-fill: @school;
    polygon-opacity: 0.5;
  }
  [class='cemetery'] {
    polygon-fill: @cemetery;
  }
  [class='hospital'] {
    polygon-fill: @hospital;
  }
  [class='parking'] {
    polygon-fill: @parking;
  }
  [class='sand'] {
    polygon-fill: @sand;
    polygon-pattern-file: url(img/pattern/sand.png);
  }
  [class='rock'] {
    polygon-fill: @rock;
  }
  [class='industrial'] {
    polygon-fill: @industrial;
  }
  [class='agriculture'] {
    polygon-fill: @agriculture;
  }
  [class='glacier'],
  [class='piste'] {
    polygon-fill: @snow;
  }
  [class='park'] {
    polygon-fill: @park;
    polygon-opacity: 0.7;
    [zoom=7] { polygon-opacity: 0.2; }
    [zoom=8] { polygon-opacity: 0.4; }
    [zoom=9] { polygon-opacity: 0.6; }
    [zoom=10]{ polygon-opacity: 0.8; }
    [zoom>=11] {
      line-color: #480;
      line-opacity: 0.5;
      line-join: round;
      [zoom>=10] { 
        line-width: 1.2;
        line-offset: -1;
      }
      [type='common'] [zoom>=15] { 
        line-color: #2e5f01;
        line-width: 2;
        line-dasharray: 4,1;
      }
    }
  }
  [class='wood'] {
    polygon-fill: @wood;
    polygon-opacity: 0.25;
    ::pattern {
      [zoom=15] {
        polygon-pattern-file: url('img/pattern/forest-low.png');
        polygon-pattern-opacity: 0.1;
        polygon-pattern-alignment: local;
        comp-op: darken;
      }
      [zoom=16] {
        polygon-pattern-file: url('img/pattern/forest-med.png');
        polygon-pattern-opacity: 0.2;
        polygon-pattern-alignment: local;
        comp-op: darken;
      }
      [zoom>=17] {
        polygon-pattern-file: url('img/pattern/forest-high.png');
        polygon-pattern-opacity: 0.25;
        polygon-pattern-alignment: local;
        comp-op: darken;
      }
    }
  }
  [class='grass'] {
    polygon-fill: @grass;
    polygon-opacity: 0.25;
  }
  [class='scrub'] {
    polygon-fill: darken(@grass, 10);
    polygon-opacity:0.25;
  }
}

#landuse_overlay[zoom>=12] {
  [class='wetland'] {
    polygon-pattern-opacity: 0.9;
    [zoom>=12] { polygon-pattern-file:url(img/pattern/wetland-12.png);}
    [zoom>=14] { polygon-pattern-file:url(img/pattern/wetland-14.png);}
    [zoom>=15] { polygon-pattern-file:url(img/pattern/wetland-15.png);}
    [zoom>=16] { polygon-pattern-file:url(img/pattern/wetland-16.png);}
    [zoom>=17] { polygon-pattern-file:url(img/pattern/wetland-17.png);}
    [zoom>=18] { polygon-pattern-file:url(img/pattern/wetland-18.png);}
  }
  [class='wetland_noveg'] {
    polygon-pattern-opacity: 0.9;
    [zoom>=12] { polygon-pattern-file:url(img/pattern/wetland-noveg-12.png);}
    [zoom>=14] { polygon-pattern-file:url(img/pattern/wetland-noveg-13.png);}
    [zoom>=16] { polygon-pattern-file:url(img/pattern/wetland-noveg-14.png);}
    [zoom>=18] { polygon-pattern-file:url(img/pattern/wetland-noveg-15.png);}
  }
}


// =====================================================================
// AEROWAYS
// =====================================================================

// lines
#aeroway['mapnik::geometry_type'=2][zoom>9] {
    line-color:darken(@aeroway, 40);
    line-cap:butt;
    line-join:miter;
    [type='runway'] {
      [zoom=10]{ line-width:1; }
      [zoom=11]{ line-width:1.5; }
      [zoom=12]{ line-width:2; }
      [zoom=13]{ line-width:3.5; }
      [zoom=14]{ line-width:5.5; }
      [zoom=15]{ line-width:8.5; }
      [zoom=16]{ line-width:10; }
      [zoom>=17]{ line-width:12; }
    }
    [type='taxiway'] {
      [zoom<13]{ line-width:0.2; }
      [zoom=13]{ line-width:1; }
      [zoom=14]{ line-width:1.5; }
      [zoom=15]{ line-width:2; }
      [zoom=16]{ line-width:3; }
      [zoom>=17]{ line-width:4; }
    }
}


// polygons
#aeroway['mapnik::geometry_type'=3][zoom>=12] {
  polygon-fill: lighten(@aeroway, 40%);
  line-color: #555;
  line-width: 0.5;
  [type='apron'] {
    polygon-fill: @parking;
    polygon-opacity: 0.8;
  }
}


// =====================================================================
// BUILDINGS
// =====================================================================

#building[zoom>12] {
  ::shadow [zoom>=17] {
    polygon-fill: #000;
    polygon-opacity: 0.3;
    polygon-geometry-transform: translate(1.5,1.5);
    image-filters: agg-stack-blur(8,8);
    image-filters-inflate: true;
  }
  ::structure {
    [zoom=13] {  
      polygon-fill:lighten(@building,4);
    }
    [zoom=14] {
      polygon-fill:lighten(@building,2);
    }
    [zoom=15] {
      polygon-fill:lighten(@building,1);
      line-color:darken(@building,30);
      line-width:0.5;
    }
    [zoom>15] {
      polygon-fill:@building;
      line-color:darken(@building,40);
      line-width:0.75;
    }
  }
}


// =====================================================================
// BARRIERS
// =====================================================================

#barrier_line[zoom>=17][class='gate'] {
  line-width:2.5;
  line-color:#7e7f88;
}

#barrier_line[zoom>=17][class='fence'] {
  line-color:@building;
  [zoom=17] { line-width:0.6; }
  [zoom=18] { line-width:0.8; }
  [zoom>18] { line-width:1; }
}

#barrier_line[zoom>=16][class='hedge'] {
  line-width:2.4;
  line-color:darken(@park,20);
  [zoom=16] { line-width: 0.6; }
  [zoom=17] { line-width: 1.2; }
  [zoom=18] { line-width: 1.4; }
  [zoom>18] { line-width: 1.6; }
}

#barrier_line[zoom>=13][class='land'] {
  ['mapnik::geometry_type'=2][zoom>=14] {
    // These shouldn't be scaled based on pixel scaling
    line-color:@land;
    [zoom=14] { line-width: 0.75; }
    [zoom=15] { line-width: 1.5; }
    [zoom=16] { line-width: 3; }
    [zoom=17] { line-width: 6; }
    [zoom=18] { line-width: 12; }
    [zoom=19] { line-width: 24; }
    [zoom>19] { line-width: 48; }
  }
  ['mapnik::geometry_type'=3] {
    polygon-fill:@land;
  }
}

#barrier_line[zoom>=14][class='cliff'] {
  line-pattern-file: url(img/pattern/cliff-md.png);
  [zoom>=16] { line-pattern-file: url(img/pattern/cliff-lg.png); }
}


// =====================================================================
// ADMINISTRATIVE BOUNDARIES
// =====================================================================

#admin[zoom>=2] {
  ::lev2outline[admin_level=2][maritime=0] {
    opacity: 0.7;
    line-join: round;
    line-cap: round;
    line-color: #fff;
    [zoom>=2][zoom<=3] { line-width: 0.4 + 2; }
    [zoom>=4][zoom<=5] { line-width: 0.8 + 2; }
    [zoom>=6][zoom<=7] { line-width: 1.2 + 3; }
    [zoom>=8][zoom<=9] { line-width: 1.8 + 3; }
    [zoom>=10][zoom<=11] { line-width: 2.2 + 3; }
    [zoom>=12][zoom<=13] { line-width: 2.6 + 3; }
    [zoom>=14][zoom<=15] { line-width: 3.0 + 3; }
    [zoom>=16] { line-width: 4.0 + 3; }
  }
  ::lev2[admin_level=2] {
    opacity: 0.75;
    line-join: round;
    line-color: @admin_2;
    [maritime=1] {
      line-color: #001642;
      line-opacity: 0.2;
    }
    [zoom>=2][zoom<=3] { line-width: 1.4; }
    [zoom>=4][zoom<=5] { line-width: 1.8; }
    [zoom>=6][zoom<=7] { line-width: 2.2; }
    [zoom>=8][zoom<=9] { line-width: 2.8; }
    [zoom>=10][zoom<=11] { line-width: 3.2; }
    [zoom>=12][zoom<=13] { line-width: 3.6; }
    [zoom>=14][zoom<=15] { line-width: 4.0; }
    [zoom>=16] { line-width: 5.0; }
    [disputed=1][zoom<=5] { line-dasharray: 4 , 3; }
    [disputed=1][zoom>=6][zoom<=7] { line-dasharray: 5 , 3; }
    [disputed=1][zoom>=8][zoom<=9] { line-dasharray: 7 , 4; }
    [disputed=1][zoom>=10][zoom<=11] { line-dasharray: 9 , 5; }
    [disputed=1][zoom>=12][zoom<=13] { line-dasharray: 11 , 6; }
    [disputed=1][zoom>=14][zoom<=15] { line-dasharray: 13 , 7; }
    [disputed=1][zoom>=16] { line-dasharray: 15 , 8; }
  }
  ::lev34outline[admin_level>=3][maritime=0] {
    opacity: 0.8;
    line-join: round;
    line-cap: round;
    line-color: #fff;
    line-opacity: 0.75;
    [zoom=5] { line-width: 0.4 + 2; }
    [zoom>=6][zoom<=7] { line-width: 0.8 + 3; }
    [zoom>=8][zoom<=9] { line-width: 1.2 + 3; }
    [zoom>=10][zoom<=11] { line-width: 1.6 + 3; }
    [zoom>=12][zoom<=13] { line-width: 2.0 + 3; }
    [zoom>=14][zoom<=15] { line-width: 2.4 + 3; }
    [zoom>=16] { line-width: 2.8 + 2; }
  }
  ::lev34[admin_level>=3] {
    [admin_level=3] {
      line-color: @admin_3;
      line-opacity: 0.65;
      line-dasharray: 12, 3;
    }
    [admin_level=4] {
      line-color: @admin_4;
      line-opacity: 0.7;
      line-dasharray: 10, 2;
    }
    [maritime=1] { line-opacity: 0.04; }
    [zoom>=2][zoom<=3] { line-width: 1.2; }
    [zoom>=4][zoom<=5] { line-width: 1.4; }
    [zoom>=6][zoom<=7] { line-width: 1.8; }
    [zoom>=8][zoom<=9] { line-width: 2.2; }
    [zoom>=10][zoom<=11] { line-width: 2.6; }
    [zoom>=12][zoom<=13] { line-width: 3.0; }
    [zoom>=14][zoom<=15] { line-width: 3.4; }
    [zoom>=16] { line-width: 2.8; }
  }
}