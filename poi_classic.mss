// =====================================================================
// POINTS OF INTEREST
// =====================================================================

#poi_label [maki!='hospital'] [type!='Clinic'] { 
  [zoom<=14][scalerank<=1],
  [zoom=15][scalerank<=2],
  [zoom=16][scalerank<=3],
  [zoom=17][scalerank<=4][localrank<=2],
  [zoom>=18] {
    ::icon[maki!=null] {
      marker-fill:#000;
      marker-line-width: 0;
      [zoom<=15] { 
        marker-file:url('img/maki/[maki]-18.svg'); 
        marker-width: 15; 
      }
      [zoom>=16] { 
        marker-file:url('img/maki/[maki]-24.svg'); 
        marker-width: 20;
        marker-ignore-placement: true;
      }
    }
    ::label {
      text-name: [name];
      text-face-name: @sans_italic;
      text-size: 10;
      text-fill: #000;
      text-halo-radius: 0.9;
      text-wrap-width: 70;
      text-line-spacing:	-2;
      text-wrap-width: 22;
      [maki!=null] { 
        text-dy: 8;
        [zoom>=19] { 
          text-allow-overlap: true;
          text-size: 10;
          text-line-spacing: -4;
          text-wrap-width: 15;
        }
      }
    }
  }
}