use <motherboard.scad>
use <acdc.scad>
use <hdd.scad>
use <power-entry.scad>
use <fan40.scad>



translate([13, 5.5, 0.1]) {
rotate([90, 0, 0]) {
    power_inlet();
}}

translate([0, 16, 0]) {
rotate([0, 0, -90]) {
    hard_drive();
}}


translate([10.5, 16.5, 0]) {
rotate([0, 0, -90]) {
    acdc();
}}

translate([0, 0, 3.5]) {
rotate([0, 0, 0]) {
    mb();
}}

translate([15, 18.5, 2]) {
rotate([0, -90, 90]) {
    fan40();
}}
