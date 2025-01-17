#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2023.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Tue May 14 16:14:13 CEST 2024
# SW Build 3865809 on Sun May  7 15:04:56 MDT 2023
#
# IP Build 3864474 on Sun May  7 20:36:21 MDT 2023
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim oled_top_behav -key {Behavioral:sim_1:Functional:oled_top} -tclbatch oled_top.tcl -log simulate.log"
xsim oled_top_behav -key {Behavioral:sim_1:Functional:oled_top} -tclbatch oled_top.tcl -log simulate.log

