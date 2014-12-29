cfc_analysis
============

Detailed quantitative and statistical characterization of cross frequency coupling in neural data. Included code

1) calculates the Modulation Index (Tort et al 2010) and weighted Phase Locking Factor (Maris et al 2011), and associated statistical significance.
2) calculates preferred low-frequency phase of high-frequency amplitude coupling
3) determines anatomical distributions of coupling phase and amplitude LFPs
4) calculates the distribution of times of peak phase consistency

I also request that you send me an email if you find this code interesting or useful, at ben.voloh+code@gmail.com. I’d love to know what kind of projects it ends up in! :)


Copyright 2014, Benjamin Voloh 
This code is distributed under a GNU General Public License.


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
mcnemar (from Cardillo, 2007)
bonf_holm (from Groppe, 2010)
make_phase_bins (from Valiante, 2011)
