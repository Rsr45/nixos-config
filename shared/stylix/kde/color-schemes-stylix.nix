{ config, ... }:
''
[ColorEffects:Disabled]
Color=#383838
ColorAmount=1
ColorEffect=0
ContrastAmount=0.6000000000000001
ContrastEffect=1
IntensityAmount=0.2
IntensityEffect=2

[ColorEffects:Inactive]
ChangeSelectionColor=false
Color=#706F6E
ColorAmount=1
ColorEffect=1
ContrastAmount=0.6000000000000001
ContrastEffect=1
Enable=false
IntensityAmount=0.2
IntensityEffect=2

[Colors:Button]
BackgroundAlternate=${config.lib.stylix.colors.withHashtag.base01}
BackgroundNormal=${config.lib.stylix.colors.withHashtag.base00}
DecorationFocus=${config.lib.stylix.colors.withHashtag.base02}
DecorationHover=${config.lib.stylix.colors.withHashtag.base02}
ForegroundActive=#D5C4A1
ForegroundInactive=#3D3D3D
ForegroundLink=#2980B9
ForegroundNegative=#DA4453
ForegroundNeutral=#F67400
ForegroundNormal=${config.lib.stylix.colors.withHashtag.base05}
ForegroundPositive=#27AE60
ForegroundVisited=#7F8C8D

[Colors:Complementary]
BackgroundAlternate=#FFFF7F
BackgroundNormal=#2F4858
DecorationFocus=#006F00
DecorationHover=#006F00
ForegroundActive=#FFFFFF
ForegroundInactive=#7F8C8D
ForegroundLink=#2980B9
ForegroundNegative=#DA4453
ForegroundNeutral=#F67400
ForegroundNormal=${config.lib.stylix.colors.withHashtag.base05}
ForegroundPositive=#27AE60
ForegroundVisited=#7F8C8D

[Colors:Header]
DecorationFocus=#4992A7
DecorationHover=#4992A7

[Colors:Selection]
BackgroundAlternate=#009900
BackgroundNormal=#4992A7
DecorationFocus=${config.lib.stylix.colors.withHashtag.base02}
DecorationHover=${config.lib.stylix.colors.withHashtag.base02}
ForegroundActive=#55FF00
ForegroundInactive=#FFAA00
ForegroundLink=#6CDDFF
ForegroundNegative=#FF92A1
ForegroundNeutral=#FFA953
ForegroundNormal=${config.lib.stylix.colors.withHashtag.base05}
ForegroundPositive=#7EFFA7
ForegroundVisited=#8C8D8D

[Colors:Tooltip]
BackgroundAlternate=${config.lib.stylix.colors.withHashtag.base01}
BackgroundNormal=${config.lib.stylix.colors.withHashtag.base00}
DecorationFocus=${config.lib.stylix.colors.withHashtag.base02}
DecorationHover=${config.lib.stylix.colors.withHashtag.base02}
ForegroundActive=#D5C4A1
ForegroundInactive=#FFFFFF
ForegroundLink=#2980B9
ForegroundNegative=#DA4453
ForegroundNeutral=#F67400
ForegroundNormal=${config.lib.stylix.colors.withHashtag.base05}
ForegroundPositive=#27AE60
ForegroundVisited=#55FF00

[Colors:View]
BackgroundAlternate=${config.lib.stylix.colors.withHashtag.base00}
BackgroundNormal=${config.lib.stylix.colors.withHashtag.base00}
DecorationFocus=${config.lib.stylix.colors.withHashtag.base02}
DecorationHover=${config.lib.stylix.colors.withHashtag.base02}
ForegroundActive=#55FFFF
ForegroundInactive=#3D3D3D
ForegroundLink=#2980B9
ForegroundNegative=#DA4453
ForegroundNeutral=#F67400
ForegroundNormal=${config.lib.stylix.colors.withHashtag.base05}
ForegroundPositive=#4992A7
ForegroundVisited=#55AAFF

[Colors:Window]
BackgroundAlternate=${config.lib.stylix.colors.withHashtag.base01}
BackgroundNormal=${config.lib.stylix.colors.withHashtag.base00}
DecorationFocus=${config.lib.stylix.colors.withHashtag.base02}
DecorationHover=${config.lib.stylix.colors.withHashtag.base02}
ForegroundActive=#D5C4A1
ForegroundInactive=#166880
ForegroundLink=#2980B9
ForegroundNegative=#DA4453
ForegroundNeutral=#F67400
ForegroundNormal=${config.lib.stylix.colors.withHashtag.base05}
ForegroundPositive=#27AE60
ForegroundVisited=#7F8C8D

[General]
Name=Stylix
shadeSortColumn=true

[KDE]
contrast=10

[WM]
activeBackground=#EDA771
activeBlend=#83A598
activeForeground=#F8F8F8
inactiveBackground=#97999B
inactiveBlend=#898F9A
inactiveForeground=#F8F8F8
''
