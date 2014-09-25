cfc_analysis
============

Detailed characterization of cross frequency coupling in neural data.
1) Computes the Modulation Index (tort et al 2010) and weighted Phase Locking Factor (Maris et al 2011), and associated statistical significance.

REQUIREMENTS:
MATLAB
hilbert.m function (available in the MATLAB signal processing toolbox, or adaptable from Octave code)

Included functions:
get_mi
wrap_get_amps
calc_mi
get_wplf
calc_wplf
calc_wplf_custom
randomize_signal

