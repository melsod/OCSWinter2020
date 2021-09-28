#Details pertinent to the scripts run for Comparison of infant sex (male/female) and age-language. TS-Aug-20-2021

#makeTextGrid script used in it's original form. TS
# Praat script by Kevin Ryan 9/05
# Parts inspired by Katherine Crosswhite and Jennifer Hay (as indicated)

#f0_f1_f2_intensity script modified to include local directories from where praat retrieves files for analysis. TS
# This script is distributed under the GNU General Public License.
# Copyright 4.7.2003 Mietta Lennes
# This script was first modified by Dan McCloy (drmccloy@uw.edu) in December 2011 and
# later modified to add intensity and labels from other tiers by Esther Le GrÃ©zause (elg1@uw.edu) in May 2016.

3 files that failed the scripts, were added manually. The pitch and formant settings were set to repeat the setting for the script. They are
as follows:

Pitch range settings:
positive Minimum_pitch_(Hz) 75
positive Maximum_pitch_(Hz) 400
Analysis method - autocorrelation
positive Pitch_time_step 0.01
Formant settings:
Maximum formant (Hz) 2500
Number of formants: 2
positive Time_step 0.01
real Preemphasis_from_(Hz) 50
Pitch analysis parameters
positive Pitch_time_step 0.01
positive Window_length_(s) 0.025

Get duration (midpoint = (start + end) / 2)
f1_50 = Get value at time
f2_50 = Get value at time
f0_50 = Get value at time

They are the following three files:

1.0598745689
2.0875516069
3.0922328882


