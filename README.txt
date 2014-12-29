cfc_analysis
============

Detailed quantitative and statistical  characterization of cross frequency coupling in neural data.

1) Computes the Modulation Index (Tort et al 2010) and weighted Phase Locking Factor (Maris et al 2011), and associated statistical significance.
2) determines preferred low-frequency phase of high-frequency amplitude coupling
3) determines anatomical distributions of coupling phase and amplitude LFPs
4) 


REQUIREMENTS:
MATLAB


INCLUDED FUNCTIONS:
get_mi
wrap_get_amps
calc_mi
get_wplf
calc_wplf
randomize_signal
get_miphase
get_miphase_peaks
circfindpeaks
normdiff
wilx_cfcdiff
stats_anatomy
t2zpks
chitest
mcnemar
bonf_holm
make_phase_bins


Copyright 2014, Benjamin Voloh 
This code is distributed under a GNU General Public License.
I also request that you send me an email should you use my code at ben.voloh+code@gmail.com, I’d love to know what kind of projects it ends up in :)