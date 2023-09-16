# UH-60L DCS Mod
A free UH-60L Black Hawk mod for Digital Combat Simulator
## Download
After reading this readme, [click here to download the latest version from the releases page.](https://github.com/Kinkkujuustovoileipa/uh-60l/releases)
## Guide
- [Link](https://docs.google.com/presentation/d/1kCJf5Nk-fU_21eO7W1ozYfb9FKt488ax65IbeuIGVtA/edit?usp=sharing)
- Manual is also available in-game
## Installation
- Extract the ‘Mods’ folder from the zip file into C:\Users\###\Saved Games\DCS\ folder (Steam) or C:\Users\###\Saved Games\DCS.OpenBeta\ (Standalone if Open Beta installed)
- You may require the latest [C++ redistributables](https://docs.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-170) for this mod to work properly
- If you use SRS, copy and paste the “DCS-SimpleRadioStandalone.lua” file to “C:\Users\###\Saved Games\DCS\Mods\Services\DCS-SRS\Scripts\” - BACK UP THE ORIGINAL!
- In the mission editor, make sure the Historical Filter is disabled
## Changelog
### 1.4
#### Bugs/Corrections
- ASN-128B would decrement from waypoint 0 to waypoint 69 - credit: Sniporbob
- ASN-128B would always edit the waypoint being navigated to instead of the waypoint selected to edit - credit: Sniporbob
- ARC-186 MAN and PRE mode would not match the position of the AM/FM/MAN/PRE switch - credit: Sniporbob
- Key binding for formation light decrease had invalid logic preventing use - credit: Tanuki44
- Situation where key binding for Stabilator Auto - ON and Stabilator Auto - OFF could have inverted functionality - credit: Sniporbob
- HSI course deviation bar only worked flying towards VOR, not away - credit: Sniporbob
- HSI km readout digits could all turn independently of each other - credit: Sniporbob
- HSI km readout digits would spin backwards when crossing from 9 to 0 - credit: Sniporbob
- HSI displayed true north instead of magnetic north - credit: twanmal
- Ground crew would only talk to the pilot through the pilot's door instead of other open doors - credit: Sniporbob
- Typo in APR39 sound file names caused errors to appear in DCS log file - credit: Sniporbob
- APR39 was not properly classifying and calling out SAM threats with their SA number - credit: Lynx13D
- Filename conflict caused certain Combined Arms and WWII Asset Pack vehicle sounds to be absent - credit: DD_Friar and DD_Sid
- Exterior noises were only heard when the Pilot door was open - credit: Sniporbob
Complete ARC-201 Overhaul - credit: Sniporbob
- ARC-201 MAN preset could be changed by simply pressing the CLR key
- ARC-201 display would remain on when function switch set to LD
- ARC-201 frequency input was not left justified
- ARC-201 allowed input of invalid frequencies
- ARC-201 was willing to wait forever for user to input a frequency
#### New Features
- ARC-201 Self Test function (decorative only, does not check for damage)
- ARC-201 editable single channel presets
- ARC-201 single channel offset feature
- ARC-201 Zeroize and Stow functions (be careful!)
- ARC-201 SINCGARS frequency hopping mode, enabled by choosing FH or FM-M (SRS compatible)
- ARC-201 hopset clearing, loading hopset from preset into working memory, storing to preset, and editing NET ID
- ARC-201 sound effects (beep for self test and for certain hopset manipulations)
- ARC-201 full implementation of single channel preset scanning and all relevant commands** (SRS compatible)
**NOTE: Scanning feature REQUIRES use of the UH-60's "SRS PTT" key binding as well as selecting which radio the player desires to transmit on via ICP panel knob. The SRS key bindings should NOT be used to control the radio. Failure to use the in-cockpit controls will result in broken and unintelligible transmissions on any radio actively utilizing the scan feature.
### 1.3.2 - Hotfix
#### Bugs/Corrections
- Radios now works again with SRS
### 1.3
#### Feature Changes
- Added option for unsprung cyclic
- Added option for pedal trim
- Flight model improvements
#### Bugs/Corrections
- Stabilator behaviour overhauled
- Added Internal Cargo support
- Added more countries
- Fuel Probe now shows in ME preview
- Wiper switch updated
- Removed SRS script
- Changed bright mode of lighted switches to use CAP panel dimmer logic
- Fixed wind direction
### 1.2
#### Feature Changes
- Air source requirement added to engine start procedure
- Flight model updated - more accurate torque/transmission behaviour (ETL, mass, etc.)
- Flight Path Stabilization & Trim System improved
- Flare countermeasures added
- Configurable intenal cargo added
- Cockpit model updated for scale
- Many many many wonderful keybinds
#### Bugs/Corrections
- Wheelbrakes fixed
- Autostart enhancement added
- Damage to ground fire fixed
- Rename wheel lock binds correction
- Toggle Keybinds for CISP/MODE buttons enhancement
- Inclinometer movement bug fixed
- Removable seats added
- uh-60 hover issue with "Solo Flight" Checked in ME bug fixed
- Chaff and Flare Dispensers correction fixed
- No starter/engine noise when starting #1 engine fixed
- Add HDG bug, COURSE bug, radio preset inc / decrease key bindings
- Add more instant Action Missions enhancement
- Heat/Start Air Source switch seems to be inop
- Add rudder binds for keyboard and controller
- Add pitch/roll binds for keyboard and controller
- 10' ft Hover TQ required does not change with weight increase/decrease
- VSI/HSI Flags showing incorrectly
- APU ON advisory illuminates early
- Collective position
- Pedal authority is too strong
- ICS/XMIT Next and Previous keybinds dont work
- Nr (Rotor Speed) not Driven by Np(Engine Speed)
- Multiplayer Disconnect issues
- Master caution does not appear with caution advisory panel cautions
- [Feature request] Separate key bindings for extending and retracting the fuel probe enhancement 
- Have Num+/Num- be default for collective inc/dec enhancement
- Anticollision, Position, NAV, Cabin Light keybinds missing enhancement
- Add more Fuel probe AAR keybinds enhancement
- NG at idle correction
### 1.1
#### Feature Changes
- Radios refactored - FM1, UHF, VHF, FM2 radios all work in game
- Communications must be reboud to 'PTT - Push To Talk (Game Comms)' key - Communication key will not work
- Easy Comms mode no longer necessary
- VRS improved
- Flight model improved
- FPS improved
- Pedal trim enabled by default - option to disable to come later
#### Bugs/Corrections
- GPS - We have to manually Enter N for North bug fixed
- Nav flags during ILS bug fixed
- Engine TGT too low correction fixed
- Radar Altitude on HMD brightness doesn't adjust fixed
- Startup without APU bug fixed
- Cockpit flood light correction fixed
- Main Gen's should drop offline at 85% Nr in-flight and 95% Nr on the ground correction fixed
- SearchLight not synced in MP bug fixed
- Starter drop out correction fixed
- VSI Roll Command based on Heading not on Track bug fixed
- HUD brightness switchs bug fixed
- HUD Radar Altitude (AGL) Readout Formats correction fixed
- Radios only work with Easy Comms enabled bug fixed
- Aircraft too fast, too rapid acceleration bug fixed
- HUD Bearing to Waypoint Pointer "V" behavior correction fixed
- Aircraft trim in cruise bug fixed
- Engine torque linked to helicopter pitch, not blade pitch correction fixed
- Tail rotor angle wrong bug fixed
- External sound bug bug fixed
- VRS - too rapid onset; too gentle descent enhancement fixed
- Roll command bar is jittery bug fixed
- FPS on during hot start enhancement fixed
- Clock time runs beyond 2400 bug fixed
- Battery low caution bug fixed
- Tail wheel switch label and operation. correction fixed
- Turning CIS Heading mode ON disables SAS1 bug fixed
- HUD Horizon Line Does Not Roll 0 - 359° correction fixed
- Start without APU bug fixed
- Stabilator Auto Control Mode should be on during startup. correction fixed
- PDU press to test correction fixed
- Radar altimeter low and high correction fixed
- Stabilator Manual Slew Switch correction fixed
- ILS Course Deviation Pointer Is Opposite Steering correction fixed
- Tailwheel Switch Pushbutton lights correction fixed
- HUD Barometric Altitude shows more than 20,000 ft correction fixed
- HUD Changes to "36" when approaching "N" bug fixed
- Torque should not change with forward or aft cyclic movements bug fixed
- Search light correction fixed
- artificial Horizon bug fixed
- ETA to waypoint not working bug fixed
- Fuel Quantity Digital Readout on CDI should display in 10 lb increments correction fixed
- Radar Altimeter Indications correction fixed
- upper and lower beacon light switch - function inverted bug fixed
- Add Checklist to kneeboard documentation enhancement fixed
- Radar Alt HI light not coming over when over Set High Alt bug fixed
- Cabin light switch inverted bug fixed
- HUD Radar Altitude (AGL) Analog Bar Appearance correction fixed
- Have the course and heading knobs adjust by 1 with mouse wheel bug fixed
- HUD Distance to Waypoint shows more than 999.9 km correction fixed
- HUD Indicated Airspeed goes above 180kts correction fixed
### 1.0
- Initial release
