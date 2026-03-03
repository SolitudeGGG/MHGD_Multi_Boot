`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/23 10:58:10
// Design Name: 
// Module Name: core_cal_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "BITWIDTH.vh"

module core_cal_tb();

parameter Ntr = 8;
parameter Ntr_2 = 64;
parameter mu = 4;
parameter mu_2 = 16;
parameter iter = 10;
parameter sampler_num = 4;
parameter TOTAL_WIDTH = `IN_WIDTH;
parameter INT_WIDTH = `IN_WIDTH - `IN_FRAC;
parameter FRAC_WIDTH = `IN_FRAC;

reg i_clk;
reg i_rst;
reg i_en;
reg [sampler_num*31:0]i_seed;

reg [Ntr_2*TOTAL_WIDTH-1:0]grad_preconditioner_real;
reg [Ntr_2*TOTAL_WIDTH-1:0]grad_preconditioner_imag;
reg [Ntr_2*TOTAL_WIDTH-1:0]H_real;
reg [Ntr_2*TOTAL_WIDTH-1:0]H_imag;
reg [Ntr*TOTAL_WIDTH-1:0]y_real;
reg [Ntr*TOTAL_WIDTH-1:0]y_imag;
reg [Ntr*TOTAL_WIDTH-1:0]v_real;//*iter
reg [Ntr*TOTAL_WIDTH-1:0]v_imag;//*iter

initial begin
    i_clk = 0;
    i_rst = 0;
    i_en = 0;
    i_seed[0+:32]=268299692;
    i_seed[32+:32]=105789684;
    i_seed[64+:32]=190357023;
    i_seed[96+:32]=547109737;

    // Real part assignments - 从索引0开始向上填充
grad_preconditioner_real[0*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(4.16007394709724);
grad_preconditioner_real[1*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.602181963169771);
grad_preconditioner_real[2*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.735287046404247);
grad_preconditioner_real[3*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.365063360939928);
grad_preconditioner_real[4*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.270024873381977);
grad_preconditioner_real[5*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.62486452687324);
grad_preconditioner_real[6*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.54447417411093);
grad_preconditioner_real[7*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.413381040452030);
grad_preconditioner_real[8*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.602181963169771);
grad_preconditioner_real[9*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(2.45610646485389);
grad_preconditioner_real[10*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.0542800283774978);
grad_preconditioner_real[11*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.866187164535432);
grad_preconditioner_real[12*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.78003564584203);
grad_preconditioner_real[13*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.70576361270718);
grad_preconditioner_real[14*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.544787548582023);
grad_preconditioner_real[15*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.358820496028827);
grad_preconditioner_real[16*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.735287046404247);
grad_preconditioner_real[17*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.0542800283774978);
grad_preconditioner_real[18*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(2.83754153939334);
grad_preconditioner_real[19*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.11908718090566);
grad_preconditioner_real[20*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.58223850652937);
grad_preconditioner_real[21*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.60249493667713);
grad_preconditioner_real[22*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.0405205933953338);
grad_preconditioner_real[23*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.78884566550897);
grad_preconditioner_real[24*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.365063360939928);
grad_preconditioner_real[25*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.866187164535432);
grad_preconditioner_real[26*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.11908718090566);
grad_preconditioner_real[27*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(2.74021872680967);
grad_preconditioner_real[28*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.75935424163820);
grad_preconditioner_real[29*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.558759403306036);
grad_preconditioner_real[30*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.219661161313720);
grad_preconditioner_real[31*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.01846603572116);
grad_preconditioner_real[32*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.270024873381977);
grad_preconditioner_real[33*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.78003564584203);
grad_preconditioner_real[34*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.58223850652937);
grad_preconditioner_real[35*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.75935424163820);
grad_preconditioner_real[36*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(5.37734584648786);
grad_preconditioner_real[37*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.35887521899613);
grad_preconditioner_real[38*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.418648425859151);
grad_preconditioner_real[39*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-3.08623834438177);
grad_preconditioner_real[40*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.62486452687324);
grad_preconditioner_real[41*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.70576361270718);
grad_preconditioner_real[42*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.60249493667713);
grad_preconditioner_real[43*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.558759403306036);
grad_preconditioner_real[44*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.35887521899613);
grad_preconditioner_real[45*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(6.55844138000083);
grad_preconditioner_real[46*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.669721225587125);
grad_preconditioner_real[47*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.193227514362163);
grad_preconditioner_real[48*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.54447417411093);
grad_preconditioner_real[49*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.544787548582023);
grad_preconditioner_real[50*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.0405205933953338);
grad_preconditioner_real[51*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.219661161313720);
grad_preconditioner_real[52*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.418648425859151);
grad_preconditioner_real[53*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.669721225587125);
grad_preconditioner_real[54*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(2.56781727296328);
grad_preconditioner_real[55*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.60907640228592);
grad_preconditioner_real[56*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.413381040452030);
grad_preconditioner_real[57*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.358820496028827);
grad_preconditioner_real[58*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.78884566550897);
grad_preconditioner_real[59*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.01846603572116);
grad_preconditioner_real[60*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-3.08623834438177);
grad_preconditioner_real[61*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.193227514362163);
grad_preconditioner_real[62*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.60907640228592);
grad_preconditioner_real[63*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(4.92591561210320);

// Imaginary part assignments - 从索引0开始向上填充
grad_preconditioner_imag[0*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.00000000000000);
grad_preconditioner_imag[1*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.47375130901209);
grad_preconditioner_imag[2*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.793846601162694);
grad_preconditioner_imag[3*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.0219726189124529);
grad_preconditioner_imag[4*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.21301779460798);
grad_preconditioner_imag[5*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.41753150389390);
grad_preconditioner_imag[6*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.108699286075984);
grad_preconditioner_imag[7*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.213236846983991);
grad_preconditioner_imag[8*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.47375130901209);
grad_preconditioner_imag[9*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.00000000000000);
grad_preconditioner_imag[10*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.296976440112576);
grad_preconditioner_imag[11*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.05900078594880);
grad_preconditioner_imag[12*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.430543973906526);
grad_preconditioner_imag[13*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.27174450934242);
grad_preconditioner_imag[14*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.697523709074868);
grad_preconditioner_imag[15*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.711607988836708);
grad_preconditioner_imag[16*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.793846601162694);
grad_preconditioner_imag[17*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.296976440112576);
grad_preconditioner_imag[18*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.00000000000000);
grad_preconditioner_imag[19*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.24902970157222);
grad_preconditioner_imag[20*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.39988530556044);
grad_preconditioner_imag[21*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.829292588251671);
grad_preconditioner_imag[22*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.0826856781214447);
grad_preconditioner_imag[23*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.298027228148015);
grad_preconditioner_imag[24*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.0219726189124529);
grad_preconditioner_imag[25*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.05900078594880);
grad_preconditioner_imag[26*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.24902970157222);
grad_preconditioner_imag[27*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.00000000000000);
grad_preconditioner_imag[28*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.593602043717190);
grad_preconditioner_imag[29*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-2.75773171869585);
grad_preconditioner_imag[30*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.359944898234291);
grad_preconditioner_imag[31*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.658658849145319);
grad_preconditioner_imag[32*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.21301779460798);
grad_preconditioner_imag[33*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.430543973906526);
grad_preconditioner_imag[34*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.39988530556044);
grad_preconditioner_imag[35*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.593602043717190);
grad_preconditioner_imag[36*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.00000000000000);
grad_preconditioner_imag[37*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(2.43441214630649);
grad_preconditioner_imag[38*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.08138314484989);
grad_preconditioner_imag[39*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(2.14540329500564);
grad_preconditioner_imag[40*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.41753150389390);
grad_preconditioner_imag[41*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.27174450934242);
grad_preconditioner_imag[42*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.829292588251671);
grad_preconditioner_imag[43*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(2.75773171869585);
grad_preconditioner_imag[44*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-2.43441214630649);
grad_preconditioner_imag[45*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.00000000000000);
grad_preconditioner_imag[46*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.70464575125261);
grad_preconditioner_imag[47*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(2.54398019181481);
grad_preconditioner_imag[48*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.108699286075984);
grad_preconditioner_imag[49*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.697523709074868);
grad_preconditioner_imag[50*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.0826856781214447);
grad_preconditioner_imag[51*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.359944898234291);
grad_preconditioner_imag[52*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.08138314484989);
grad_preconditioner_imag[53*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.70464575125261);
grad_preconditioner_imag[54*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.00000000000000);
grad_preconditioner_imag[55*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.688704940350539);
grad_preconditioner_imag[56*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.213236846983991);
grad_preconditioner_imag[57*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.711607988836708);
grad_preconditioner_imag[58*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.298027228148015);
grad_preconditioner_imag[59*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.658658849145319);
grad_preconditioner_imag[60*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-2.14540329500564);
grad_preconditioner_imag[61*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-2.54398019181481);
grad_preconditioner_imag[62*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.688704940350539);
grad_preconditioner_imag[63*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.00000000000000);

// H_real assignments - 从索引0开始向上填充
H_real[0*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.041388);
H_real[1*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.110629);
H_real[2*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.203122);
H_real[3*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.069215);
H_real[4*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.108177);
H_real[5*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.072298);
H_real[6*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.365564);
H_real[7*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.150565);
H_real[8*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.093399);
H_real[9*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.170136);
H_real[10*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.196706);
H_real[11*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.073652);
H_real[12*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.107969);
H_real[13*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.261278);
H_real[14*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.107372);
H_real[15*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.062597);
H_real[16*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.170160);
H_real[17*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.287083);
H_real[18*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.261553);
H_real[19*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.111797);
H_real[20*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.395032);
H_real[21*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.015866);
H_real[22*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.171048);
H_real[23*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.287688);
H_real[24*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.537247);
H_real[25*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.360427);
H_real[26*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.067046);
H_real[27*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.304323);
H_real[28*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.147844);
H_real[29*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.023855);
H_real[30*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.616247);
H_real[31*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.278693);
H_real[32*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.015434);
H_real[33*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.003244);
H_real[34*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.094154);
H_real[35*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.611548);
H_real[36*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.355949);
H_real[37*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.219091);
H_real[38*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.108842);
H_real[39*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.018305);
H_real[40*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.304053);
H_real[41*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.173183);
H_real[42*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.480658);
H_real[43*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.285183);
H_real[44*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.149622);
H_real[45*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.064405);
H_real[46*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.213779);
H_real[47*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.034378);
H_real[48*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.036484);
H_real[49*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.020146);
H_real[50*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.131493);
H_real[51*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.320667);
H_real[52*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.426879);
H_real[53*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.088992);
H_real[54*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.149419);
H_real[55*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.355460);
H_real[56*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.282113);
H_real[57*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.176909);
H_real[58*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.159928);
H_real[59*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.022215);
H_real[60*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.081481);
H_real[61*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.309788);
H_real[62*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.434005);
H_real[63*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.018125);

// H_imag assignments - 从索引0开始向上填充
H_imag[0*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.106345);
H_imag[1*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.192199);
H_imag[2*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.354929);
H_imag[3*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.127146);
H_imag[4*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.069331);
H_imag[5*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.106089);
H_imag[6*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.379635);
H_imag[7*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.080779);
H_imag[8*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.283358);
H_imag[9*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.564939);
H_imag[10*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.239193);
H_imag[11*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.039800);
H_imag[12*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.006812);
H_imag[13*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.005490);
H_imag[14*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.058460);
H_imag[15*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.102579);
H_imag[16*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.047510);
H_imag[17*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.408653);
H_imag[18*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.331182);
H_imag[19*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.001410);
H_imag[20*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.030306);
H_imag[21*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.040500);
H_imag[22*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.121193);
H_imag[23*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.331240);
H_imag[24*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.067127);
H_imag[25*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.198210);
H_imag[26*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.547508);
H_imag[27*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.266750);
H_imag[28*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.032547);
H_imag[29*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.025687);
H_imag[30*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.164009);
H_imag[31*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.033730);
H_imag[32*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.365509);
H_imag[33*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.171063);
H_imag[34*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.273060);
H_imag[35*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.137636);
H_imag[36*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.271996);
H_imag[37*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.402121);
H_imag[38*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.063562);
H_imag[39*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.505321);
H_imag[40*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.250513);
H_imag[41*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.303691);
H_imag[42*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.099044);
H_imag[43*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.602470);
H_imag[44*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.084636);
H_imag[45*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.276027);
H_imag[46*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.019328);
H_imag[47*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.151103);
H_imag[48*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.031254);
H_imag[49*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.309718);
H_imag[50*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.292038);
H_imag[51*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.144738);
H_imag[52*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.370467);
H_imag[53*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.140313);
H_imag[54*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.040889);
H_imag[55*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.053114);
H_imag[56*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.227547);
H_imag[57*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.024448);
H_imag[58*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.048377);
H_imag[59*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.426186);
H_imag[60*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.129699);
H_imag[61*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.243275);
H_imag[62*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.340927);
H_imag[63*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.396455);

// y_real and y_imag assignments - 从索引0开始向上填充
y_real[0*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.861240);
y_imag[0*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.099673);
y_real[1*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.315612);
y_imag[1*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.867884);
y_real[2*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.416445);
y_imag[2*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.223248);
y_real[3*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.337144);
y_imag[3*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(1.190285);
y_real[4*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.392007);
y_imag[4*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.986579);
y_real[5*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-1.079969);
y_imag[5*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.192038);
y_real[6*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.203591);
y_imag[6*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.118094);
y_real[7*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.494067);
y_imag[7*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.265478);

v_real[0*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.757942796);
v_imag[0*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.377266228);
v_real[1*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.0291723981);
v_imag[1*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.103783473);
v_real[2*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.05453844);
v_imag[2*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.310257971);
v_real[3*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.103702165);
v_imag[3*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.234615192);
v_real[4*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.0568528026);
v_imag[4*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.552367806);
v_real[5*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.543557942);
v_imag[5*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.516009748);
v_real[6*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.0658988133);
v_imag[6*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.679140687);
v_real[7*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(-0.0460517444);
v_imag[7*TOTAL_WIDTH +: TOTAL_WIDTH] = float_to_fixed40(0.530342102);

    #10 i_rst = 1; 
    #10 i_rst = 0;
    #5 i_en = 1;
    #10 i_en = 0;
end

always #5 i_clk = ~i_clk;

wire [Ntr_2*TOTAL_WIDTH-1:0]o_pmat_real;
wire [Ntr_2*TOTAL_WIDTH-1:0]o_pmat_imag;
wire [Ntr*TOTAL_WIDTH-1:0]o_pr_prev_real;
wire [Ntr*TOTAL_WIDTH-1:0]o_pr_prev_imag;
wire [mu_2*TOTAL_WIDTH-1:0]o_constellation_norm_real;
wire [mu_2*TOTAL_WIDTH-1:0]o_constellation_norm_imag;
wire [sampler_num*Ntr*TOTAL_WIDTH-1:0]o_x_real;
wire [sampler_num*Ntr*TOTAL_WIDTH-1:0]o_x_imag;
wire [sampler_num*Ntr*TOTAL_WIDTH-1:0]o_r_real;
wire [sampler_num*Ntr*TOTAL_WIDTH-1:0]o_r_imag;
wire [TOTAL_WIDTH-1:0]o_dqam;
wire [TOTAL_WIDTH-1:0]o_alpha;
wire [sampler_num*TOTAL_WIDTH-1:0]o_lr;
wire [sampler_num*TOTAL_WIDTH-1:0]o_step_size;
wire [sampler_num*TOTAL_WIDTH-1:0]o_r_norm;
wire pre_done;

wire [Ntr*TOTAL_WIDTH-1:0]x_real_survival[0:sampler_num-1];
wire [Ntr*TOTAL_WIDTH-1:0]x_imag_survival[0:sampler_num-1];
wire [TOTAL_WIDTH-1:0]r_norm_survival[0:sampler_num-1];
wire [sampler_num-1:0]cal_done;

wire [Ntr*`TOTAL_WIDTH_xhat-1:0]x_real_o;
wire [Ntr*`TOTAL_WIDTH_xhat-1:0]x_imag_o;
wire o_done;

// Data_pre#(
//     .sampler_id(1),
//     .Nt(Ntr),
//     .Nr(Ntr),
//     .mu(mu),
//     .mu_2(mu_2),
//     .sampler_num(sampler_num),
//     .TOTAL_WIDTH(TOTAL_WIDTH),      // 总位宽
//     .INT_WIDTH(INT_WIDTH),         // 整数部分位宽
//     .FRAC_WIDTH(FRAC_WIDTH)  // 小数部分位宽
// )adasd(
//     .i_clk(i_clk),
//     .i_rst(i_rst),
//     // input
//     .data_pre_en(i_en),
//     // complex data
//     .i_H_real(H_real),
//     .i_H_imag(H_imag),
//     .i_y_real(y_real),
//     .i_y_imag(y_imag),
//     .i_grad_real(grad_preconditioner_real),
//     .i_grad_imag(grad_preconditioner_imag),
//     // simple data
//     .i_sigma2(1),
//     .i_seed(i_seed),
// 
//     // output
//     // complex data
//     .o_pmat_real(o_pmat_real),
//     .o_pmat_imag(o_pmat_imag),
//     .o_constellation_norm_real(o_constellation_norm_real),
//     .o_constellation_norm_imag(o_constellation_norm_imag),
//     .o_x_real(o_x_real),
//     .o_x_imag(o_x_imag),
//     .o_r_real(o_r_real),
//     .o_r_imag(o_r_imag),
//     // simple data
//     .o_dqam(o_dqam),
//     .o_alpha(o_alpha),
//     .o_lr(o_lr),
//     .o_step_size(o_step_size),
//     .o_r_norm(o_r_norm),
//     .data_pre_done(pre_done)
// );

TOP test_top(
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_start(i_en),
    .H_real_in(H_real),
    .H_imag_in(H_imag),
    .y_real_in(y_real),
    .y_imag_in(y_imag),
    .grad_real_in(grad_preconditioner_real),
    .grad_imag_in(grad_preconditioner_imag),
    .v_real_in(v_real),
    .v_imag_in(v_imag),
    .x_real_out(x_real_o),
    .x_imag_out(x_imag_o),
    .o_done(o_done)
);

// genvar i;
// generate
// // core cal module
//     for(i=0; i<sampler_num; i=i+1)begin:core_cal_gen
//         Core_cal#(
//             .sampler_id(1),
//             .Nt(Ntr),
//             .Nr(Ntr),
//             .mu(4),
//             .mu_2(16),
//             .iters(10),
//             .lr_approx(0),
//             .TOTAL_WIDTH(TOTAL_WIDTH),      // 总位宽
//             .INT_WIDTH(INT_WIDTH),         // 整数部分位宽
//             .FRAC_WIDTH(FRAC_WIDTH) // 小数部分位宽
//         )tbtybtb(
//             .i_clk(i_clk),
//             .i_rst(i_rst),
//             // input
//             .cal_en(pre_done),
//             // static data
//             .i_H_real(H_real),
//             .i_H_imag(H_imag),
//             .i_y_real(y_real),
//             .i_y_imag(y_imag),
//             .i_v_real(v_real),
//             .i_v_imag(v_imag),
//             .i_grad_real(grad_preconditioner_real),
//             .i_grad_imag(grad_preconditioner_imag),
// 
//             .i_pmat_real(o_pmat_real),
//             .i_pmat_imag(o_pmat_imag),
//             .i_constellation_norm_real(o_constellation_norm_real),
//             .i_constellation_norm_imag(o_constellation_norm_imag),
//             .i_dqam(o_dqam),
//             .i_alpha(o_alpha),
//             // simple data
//             .i_sigma2(0),
//             .i_seed(i_seed[i*32 +: 32]),
// 
//             // output
//             // bianhua data
//             .i_lr(o_lr[i*TOTAL_WIDTH +: TOTAL_WIDTH]),
//             .i_step_size(o_step_size[i*TOTAL_WIDTH +: TOTAL_WIDTH]),
//             .i_r_norm(o_r_norm[i*TOTAL_WIDTH +: TOTAL_WIDTH]),
//             .i_r_norm_survivor(o_r_norm[i*TOTAL_WIDTH +: TOTAL_WIDTH]),
// 
//             .i_x_real(o_x_real[i*Ntr*TOTAL_WIDTH+: Ntr*TOTAL_WIDTH]),
//             .i_x_imag(o_x_imag[i*Ntr*TOTAL_WIDTH+: Ntr*TOTAL_WIDTH]),
//             .i_r_real(o_r_real[i*Ntr*TOTAL_WIDTH+: Ntr*TOTAL_WIDTH]),
//             .i_r_imag(o_r_imag[i*Ntr*TOTAL_WIDTH+: Ntr*TOTAL_WIDTH]),
//             // simple data
//             .o_x_real(x_real_survival[i]),
//             .o_x_imag(x_imag_survival[i]),
//             .o_r_norm(r_norm_survival[i]),
// 
//             .cal_done(cal_done[i])
//         );
//     end
// endgenerate



// 函数：将浮点数转换为40位定点数表示 (8位整数+32位小数)
function [39:0] float_to_fixed40;
    input real val;
    real abs_val;
    integer int_part;
    reg [31:0] frac_part;
    reg sign;
    real temp_frac;
    reg [39:0] result;
    begin
        // 确定符号位
        sign = val < 0;
        abs_val = sign ? -val : val; // 取绝对值
        
        // 提取整数部分
        int_part = $rtoi(abs_val);
        
        // 提取小数部分并转换为32位定点表示
        temp_frac = abs_val - int_part;
        frac_part = 0;
        
        // 使用逐位计算方法
        for (integer i = 0; i < 32; i = i + 1) begin
            temp_frac = temp_frac * 2.0;
            if (temp_frac >= 1.0) begin
                frac_part[31-i] = 1'b1;
                temp_frac = temp_frac - 1.0;
            end else begin
                frac_part[31-i] = 1'b0;
            end
        end
        
        // 组合结果 - 使用补码表示
        if (sign) begin
            // 对于负数，需要计算补码
            result = {1'b1, int_part[6:0], frac_part};
            // 计算补码：取反后加1
            result = ~result + 1;
            result = {1'b1, result[38:0]};
        end else begin
            // 正数直接使用原码
            result = {1'b0, int_part[6:0], frac_part};
        end
        
        float_to_fixed40 = result;
    end
endfunction


endmodule
