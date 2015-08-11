// *********************************************************************
// HUMANITARIAN
// *********************************************************************

// =====================================================================
// FONTS
// =====================================================================

// Language
@name: '[name]';

// set up font sets for various weights and styles
@sans_lt:           "DIN Offc Pro Medium", "Open Sans Regular","Arial Unicode MS Regular";
@sans_lt_italic:    "DIN Offc Pro Medium Italic", "Open Sans Italic","Arial Unicode MS Regular";
@sans:              "DIN Offc Pro Bold", "Open Sans Semibold","Arial Unicode MS Regular";
@sans_bold:         "DIN Offc Pro Black", "Open Sans Bold","Arial Unicode MS Regular";
@sans_italic:       "DIN Offc Pro Bold Italic", "Open Sans Semibold Italic","Arial Unicode MS Regular";
@sans_bold_italic:  "DIN Offc Pro Black Italic", "Open Sans Bold Italic","Arial Unicode MS Regular";

// =====================================================================
// LANDUSE & LANDCOVER COLORS
// =====================================================================

@land:              #fff9e8;
@water:             #5bb3f2;
@grass:             #e9f2ba;
@sand:              #F7ECD2;
@rock:              #dfdfdf;
@park:              #d4e8b2;
@cemetery:          #D5DCC2;
@wood:              #d1e9bf;
@industrial:        #c4c4c4;
@agriculture:       #faedd8;
@snow:              #EDE5DD;
@crop:              #f4efd5;
@building:          #c4ad9f;
@hospital:          #F2E3E1;
@school:            #fbe670;
@pitch:             #CAE6A9;
@sports:            @park;

@parking:           darken(@industrial, 15);

@aeroway:           #eaeaea;

// =====================================================================
// BOUNDARY COLORS
// =====================================================================

@admin_2:           #0c1b29;
@admin_3:           #2a4d6f;
@admin_4:           #43607e;

// =====================================================================
// LABEL COLORS
// =====================================================================

// We set up a default halo color for places so you can edit them all
// at once or override each individually.
@place_halo:        #fff;

@country_text:      @land * 0.2;
@country_halo:      @place_halo;

@state_text:        #111;
@state_halo:        @place_halo;

@city_text:         #111;
@city_halo:         @place_halo;

@town_text:         #222;
@town_halo:         @place_halo;

@poi_text:          @poi_text;  

@road_text:         #222;
@road_halo:         #fff;

@other_text:        #333;
@other_halo:        @place_halo;

@locality_text:     #333;
@locality_halo:     @land;

// Also used for other small places: hamlets, suburbs, localities
@village_text:      #444;
@village_halo:      @place_halo;

@transport_text:    #222;

/**/