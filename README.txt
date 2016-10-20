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

    bonf_holm.m (from Groppe, 2010)
    calc_mi.m
    calc_wplf.m
    cfcdiff_wilx.m
    chitest.m
    circ_rtest2.m
    circfindpeaks.m
    get_mi.m
    get_miphase.m
    get_miphase_peaks.m
    get_rayz_time.m
    get_wplf.m
    get_wplfphase.m
    make_phase_bins.m (from Valiante, 2011)
    mcnemar.m (from Cardillo, 2007)
    normdiff.m
    randomize_signal.m
    rayz2zpks.m
    stats_anatomy.m
    vararginchk.m
    wrap_get_amps.m


