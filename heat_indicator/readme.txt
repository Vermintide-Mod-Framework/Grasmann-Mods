Author: Walterr
Ported: grasmann

Description :
When charging the Bolt staff or Fireball staff, a colored marker will be shown on the HUD
indicating the current 'charge level'.
The Bolt staff has discrete charge levels, which are shown as: green=1, orange=2, red=3.
The Fireball staff doesn't have discrete levels and charging just continuously increases damage and area, 
so the levels I've chosen are kind of arbitrary: 
green=(3 <= damage < 5, 0.75 <= area < 2.25), orange=(5 <= damage < 6, 2.25 <= area < 3), red=(damage = 6, area = 3).
Where 'damage' means AoE instantaneous damage to normal targets, not including impact damage or DoT.

Changelog
2.0.1 - Fix to prevent crash with incorrect load order
2.0.0 - Updated for vmb and vt2
1.4.0 - Updated for latest vmf
1.3.0 - Port to official bundle format
1.2.0 - Update walters script to new structure
1.1.0 - Walter uploaded his script to moddb
1.0.0 - Release