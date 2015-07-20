// ---------------------------------------------------------------------

// =====================================================================
// ROAD COLORS
// =====================================================================

@caseMotorway:  #40006a;
@fillMotorway:  #903777;

@caseTrunk:     #5f016a;
@fillTrunk:     #b0569e;

@casePrimary:   #78054e;
@fillPrimary:   #b7658b;

@caseSecondary: #7e0c5e;
@fillSecondary: #db96ad;

@caseTertiary:  #5b255c;
@fillTertiary:  #ede0ed;

@caseStreet:    #6a6a6a;
@fillStreet:    #fffdff;

@path_line:     #323232;

// Roads are split across 3 layers: #road, #bridge, and #tunnel. Each
// road segment will only exist in one of the three layers. The
// #bridge layer makes use of Mapnik's group-by rendering mode;
// attachments in this layer will be grouped by layer for appropriate
// rendering of multi-level overpasses.

// The main road style is for all 3 road layers and divided into 2 main
// attachments. The 'case' attachment is 

#road, #bridge, #tunnel {
  
  ::case[zoom>=3]['mapnik::geometry_type'=2] {
    [class='motorway'][zoom>=5] {
      line-join:round;
      line-color: @caseMotorway;
      #road { line-cap: round; }
      #tunnel { line-dasharray:3,2; }
      line-width:0.75;
      [zoom<=8] { line-opacity: 0.5; }
      [zoom>=6]  { line-width:1.25; }
      [zoom>=7]  { line-width:2; }
      [zoom>=8] { line-width:3; }
      [zoom>=10]  { line-width:4; }
      [zoom>=13] { line-width:4.5;  }
      [zoom>=14] { line-width:6.5; }
      [zoom>=15] { line-width:8.5; }
      [zoom>=16] { line-width:11; }
    }
    [class='motorway_link'][zoom>=13] {
      line-join:round;
      line-color: @caseMotorway;
      #road { line-cap: round; }
      #tunnel { line-dasharray:3,2; }
      [zoom>=13] { line-width:1; }
      [zoom>=14] { line-width:3; }
      [zoom>=15] { line-width:5; }
      [zoom>=16] { line-width:6.5; }
    }
    [type='trunk'] {
      line-join:round;
      line-color: @caseTrunk;
      #road { line-cap: round; }
      #tunnel { line-dasharray:3,2; }
      [zoom<=10] { line-opacity: 0.5; }
      [zoom>=6] { line-width:0.5; }
      [zoom>=7] { line-width:0.8; }
      [zoom>=10] { line-width:3.4; }
      [zoom>=13] { line-width:6.5; }
      [zoom>=14] { line-width:8; }
      [zoom>=15] { line-width:9; }
      [zoom>=16] { line-width:12; }
    }
    [type='primary']{
      line-join:round;
      line-color: @casePrimary;
      #road { line-cap: round; }
      #tunnel { line-dasharray:3,2; }
      [zoom<=8] { line-opacity: 0.5; }
      [zoom>=6] { line-width:0.2; }
      [zoom>=7] { line-width:0.4; }
      [zoom>=8] { line-width:1.5; }
      [zoom>=10] { line-width:2.4; }
      [zoom>=13] { line-width:4.5; }
      [zoom>=14] { line-width:5.5; }
      [zoom>=15] { line-width:6.5; }
      [zoom>=16] { line-width:8.5; }
    }
    [type='secondary']{
      line-join:round;
      line-color: @caseSecondary;
      line-width:1;
      #road { line-cap: round; }
      #tunnel { line-dasharray:3,2; }
      [zoom<=13] { line-opacity: 0.5; }
      [zoom>=13] { line-width:2.5; }
      [zoom>=14] { line-width:4; }
      [zoom>=15] { line-width:5; }
      [zoom>=16] { line-width:7.5; }
    }
    [type='tertiary']{
      line-join:round;
      line-color: @caseTertiary;
      line-width:1;
      #road { line-cap: round; }
      #tunnel { line-dasharray:3,2; }
      [zoom<=13] { line-opacity: 0.5; }
      [zoom>=13] { line-width:2.3; }
      [zoom>=14] { line-width:3.8; }
      [zoom>=15] { line-width:4.8; }
      [zoom>=16] { line-width:6.8; }
      [zoom>=17] { line-width:7.8; }
    }
    [class='main'][type='']{
      line-join:round;
      line-color: @casePrimary;
      line-width:1;
      line-opacity:0.35;
      #road { line-cap: round; }
      #tunnel { line-dasharray:3,2; }
      [zoom>=13] { line-width:2.5; }
      [zoom>=14] { line-width:4; }
      [zoom>=15] { line-width:5; }
      [zoom>=16] { line-width:7.5; }
    }
    [class='street'],[class='street_limited'][zoom>=10] {
      line-join:round;
      #road { line-cap: round; }
      #tunnel { line-dasharray:3,2; }
      line-color: @caseStreet;
      [zoom<=13] { line-opacity: 0.5; }
      [zoom>=10] { line-width:0.5; }
      [zoom>=14] { line-width:3; }
      [zoom>=15] { line-width:3.5; }
      [zoom>=16] { line-width:5.5; }
    }
    [class='service'][zoom>=10] {
      #tunnel { line-opacity: 0.2; }
      line-color: @caseStreet;
      [zoom<=13] { line-opacity: 0.5; }
      [zoom>=10] { line-width:0.2; }
      [zoom>=14] { line-width:2.8; }
      [zoom>=15] { line-width:3.3; }
      [zoom>=16] { line-width:5.3; }
      [type='track'] { 
        line-dasharray: 11,3; 
        line-join: miter; 
        line-cap: butt; }
    }
    [class='path'][zoom>=14] {
      ['mapnik::geometry_type'=2] {
        line-color: @path_line;
        line-opacity: 0.7;
        line-dasharray: 6 , 1.5;
        line-width: 0.75;
        [zoom>=15] { line-width: 0.9; line-dasharray: 7, 2.5; }
        [zoom>=16] { line-width: 1.4; line-dasharray: 8, 3; }
      }
    }
  }
  ::fill[zoom>=6]['mapnik::geometry_type'=2] {
    [class='motorway'][zoom>=8] {
      line-join:round;
      #road, #bridge { line-cap:round; }
      line-color:@fillMotorway;
      #tunnel { line-color:lighten(@fillMotorway,4); }
      [zoom>=8] { line-width:1.5; }
      [zoom>=10] { line-width:2; }
      [zoom>=13] { line-width:2.5; }
      [zoom>=14] { line-width:3.5; }
      [zoom>=15] { line-width:5; }
      [zoom>=16] { line-width:7; }
    }
    [class='motorway_link'][zoom>=14] {
      line-join:round;
      #road, #bridge { line-cap: round; }
      line-color: @fillMotorway;
      //[zoom<=14] { line-color: darken(@motorway, 10); }
      #tunnel {  line-color:lighten(@fillMotorway, 4); }
      [zoom>=14] { line-width:1.5; }
      [zoom>=15] { line-width:3; }
      [zoom>=16] { line-width:4.5; }
    }
    [type='trunk'] {
      line-join:round;
      line-color: @fillTrunk;
      //[zoom<=14] { line-color: darken(@main, 10); }
      line-width: 0;
      [zoom>=10] { line-width:1.5; }
      [zoom>=13] { line-width:4.0; }
      [zoom>=14] { line-width:5.0; }
      [zoom>=15] { line-width:6.0; }
      [zoom>=16] { line-width:9.0; }
      #road, #bridge { line-cap: round; }
      #tunnel { line-color:lighten(@fillTrunk,4); }
    }
    [type='primary'][zoom>=8] {
      line-join:round;
      line-color:@fillPrimary;
      line-width: 0;
      [zoom>=8] { line-width:0.3; }
      [zoom>=10] { line-width:0.8; }
      [zoom>=12] { line-width:1.2; }
      [zoom>=13] { line-width:2.75; }
      [zoom>=14] { line-width:3.7; }
      [zoom>=15] { line-width:4.2; }
      [zoom>=16] { line-width:5.5; }
      #road, #bridge { line-cap: round; }
      #tunnel { line-color:lighten(@fillPrimary, 10); }
    }
    [type='secondary']{
      line-join:round;
      #road, #bridge { line-cap: round; }
      line-color:@fillSecondary;
      line-width:0;
      #tunnel { line-color:lighten(@fillSecondary,4); }
      [zoom>=13] { line-width:1.5; }
      [zoom>=14] { line-width:2.5; }
      [zoom>=15] { line-width:3.5; }
      [zoom>=16] { line-width:5.0; }
    }
    [type='tertiary']{
      line-join:round;
      #road, #bridge { line-cap: round; }
      line-color:@fillTertiary;
      line-width:0;
      #tunnel { line-color:lighten(@fillTertiary,4); }
      [zoom>=13] { line-width:1.3; }
      [zoom>=14] { line-width:2.3; }
      [zoom>=15] { line-width:3.3; }
      [zoom>=16] { line-width:4.8; }
    }
    [class='street'],[class='street_limited'][zoom>=14] {
      line-join:round;
      line-color:@fillStreet;
      line-width:0;
      #road, #bridge { line-cap: round; }
      [zoom>=14] { line-width:1.8;  }
      [zoom>=15] { line-width:2;  }
      [zoom>=16] { line-width:3.5; }
    }
    [class='service'][zoom>=14] {
      line-color:@fillStreet;
      line-width:0;
      [zoom>=14] { line-width:1.5;  }
      [zoom>=15] { line-width:1.7;  }
      [zoom>=16] { line-width:3.2; }
      [type='track'] { 
        line-dasharray: 11,3; 
        line-join: miter; 
        line-cap: butt; }
    }
    [class='major_rail'] {
      line-width: 0.9;
      line-color: #444;
      line-opacity: 0.6;
       // Hatching
       h/line-width: 2.5;
       h/line-color: #444;
       h/line-dasharray: 1,8;
       h/line-opacity: 0.6;
      [zoom>=16] {
        
        line-width: 1.5;
        line-color: #444;
        
      	// Hatching
      	h/line-width: 8;
      	h/line-color: #444;
      	h/line-dasharray: 1,15;
      }
    }    
  }
}