// 全局位宽定义
// MIMO系统参数
`define Nt 8
`define Nr 8
`define Nt_2 64
`define mu 4
`define QAM_order 16
`define max_iter 10
`define lr_approx 1
`define sampler 4

`define IN_WIDTH 40
`define IN_FRAC  32

// 位宽定义
// dqam
`define TOTAL_WIDTH_dqam 12
`define INT_WIDTH_dqam 8
`define FRAC_WIDTH_dqam 4
// xhat
`define TOTAL_WIDTH_xhat 12
`define INT_WIDTH_xhat 8
`define FRAC_WIDTH_xhat 4
// alpha
`define TOTAL_WIDTH_alpha 12
`define INT_WIDTH_alpha 4
`define FRAC_WIDTH_alpha 8
// log_pacc
`define TOTAL_WIDTH_log_pacc 12
`define INT_WIDTH_log_pacc 5
`define FRAC_WIDTH_log_pacc 7
// pacc
`define TOTAL_WIDTH_pacc 12
`define INT_WIDTH_pacc 5
`define FRAC_WIDTH_pacc 7
// step_size
`define TOTAL_WIDTH_step_size 10
`define INT_WIDTH_step_size 4
`define FRAC_WIDTH_step_size 6
// r_norm
`define TOTAL_WIDTH_r_norm 13
`define INT_WIDTH_r_norm 7
`define FRAC_WIDTH_r_norm 6
// lr
`define TOTAL_WIDTH_lr 10
`define INT_WIDTH_lr 4
`define FRAC_WIDTH_lr 6
// z_grad
`define TOTAL_WIDTH_z_grad 12
`define INT_WIDTH_z_grad 4
`define FRAC_WIDTH_z_grad 8
// z_prop
`define TOTAL_WIDTH_z_prop 12
`define INT_WIDTH_z_prop 6
`define FRAC_WIDTH_z_prop 6
// x_prop
`define TOTAL_WIDTH_x_prop 12
`define INT_WIDTH_x_prop 5
`define FRAC_WIDTH_x_prop 7
// H
`define TOTAL_WIDTH_H 20
`define INT_WIDTH_H 4
`define FRAC_WIDTH_H 16
// y
`define TOTAL_WIDTH_y 10
`define INT_WIDTH_y 4
`define FRAC_WIDTH_y 6
// v
`define TOTAL_WIDTH_v 10
`define INT_WIDTH_v 4
`define FRAC_WIDTH_v 6
// HH_H
`define TOTAL_WIDTH_HH_H 20
`define INT_WIDTH_HH_H 4
`define FRAC_WIDTH_HH_H 16
// grad_preconditioner
`define TOTAL_WIDTH_grad_preconditioner 16
`define INT_WIDTH_grad_preconditioner 6
`define FRAC_WIDTH_grad_preconditioner 10
// pmat
`define TOTAL_WIDTH_pmat 19
`define INT_WIDTH_pmat 4
`define FRAC_WIDTH_pmat 15
// r
`define TOTAL_WIDTH_r 10
`define INT_WIDTH_r 4
`define FRAC_WIDTH_r 6
// pr_prev
`define TOTAL_WIDTH_pr_prev 12
`define INT_WIDTH_pr_prev 4
`define FRAC_WIDTH_pr_prev 8
// sigma2
`define TOTAL_WIDTH_sigma2 10
`define INT_WIDTH_sigma2 4
`define FRAC_WIDTH_sigma2 6
