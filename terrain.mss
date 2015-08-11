#hillshade {
  ::0[zoom<=14],
  ::1[zoom=15],
  ::2[zoom=16],
  ::3[zoom>=17] {
    image-filters-inflate: true;
    comp-op: hard-light;
    [class='shadow'] {
      polygon-fill: rgba(0,0,0,0.1);
    }
    [class='highlight'] {
      polygon-fill: rgba(255,255,255,0.125);
    }
  }
  ::1 { image-filters: agg-stack-blur(4,4); }
  ::2 { image-filters: agg-stack-blur(8,8); }
  ::3 { image-filters: agg-stack-blur(12,12); }
}

#landcover {
  ::0 [zoom<=6],
  ::1 [zoom=7],
  ::2 [zoom=8],
  ::3 [zoom=9],
  ::4 [zoom=10],
  ::5 [zoom=11],
  ::6 [zoom>=12] {
    [class='scrub'] { polygon-fill: mix(@wood,@crop,67%); }
    [class='grass'] { polygon-fill: mix(@wood,@crop,33%); }
    [class='crop'] { polygon-fill: @crop; }
    [class='snow'] { polygon-fill: #eff; }
    [class='wood'] {
      polygon-fill: @wood;
      ::pattern {
        [zoom=15] {
          polygon-pattern-file: url('img/pattern/forest-low.png');
          polygon-pattern-opacity: 0.15;
          polygon-pattern-alignment: local;
        }
        [zoom=16] {
          polygon-pattern-file: url('img/pattern/forest-med.png');
          polygon-pattern-opacity: 0.25;
          polygon-pattern-alignment: local;
        }
        [zoom>=17] {
          polygon-pattern-file: url('img/pattern/forest-high.png');
          polygon-pattern-opacity: 0.3;
          polygon-pattern-alignment: local;       
        }
      }
    }
  }
}

#contour.line[index!=-1] {
  [zoom>=10] {
    line-width: 0.5;
    line-opacity: 0.1;
  }
  [zoom>=12] {
    line-width: 0.65;
    line-opacity: 0.18;
  }
  [zoom>=14] {
    line-width: 0.75;
    line-opacity: 0.35;
    [index>=5] { line-width: 1.5; }
  }
}

#contour.label::label {
  [index=5][zoom>=15] {
    text-name: "[ele]+' m'";
    text-face-name: @sans;
    text-placement: line;
    text-size: 9;
    text-fill: #666;
    text-avoid-edges: true;
    text-halo-fill: fadeout(@land,80%);
    text-halo-opacity: 0.5;
    text-halo-radius: 2;
    text-halo-rasterizer: fast;
    text-min-distance: 50;
  }
  [index=10][zoom>=13] {
    text-name: "[ele]+' m'";
    text-face-name: @sans;
    text-placement: line;
    text-size: 8;
    text-fill: #666;
    text-avoid-edges: true;
    text-halo-fill: fadeout(@land,80%);
    text-halo-opacity: 0.3;
    text-halo-radius: 2;
    text-halo-rasterizer: fast;
    text-min-distance: 50;
  }
}
