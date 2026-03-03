`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/08/18 10:35:31
// Design Name: 
// Module Name: TOP
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

module TOP(
    input i_clk,
    input i_rst,
    // input
    input i_start,

    // input data
    input [`Nt*`Nr*`IN_WIDTH-1:0]H_real_in,
    input [`Nt*`Nr*`IN_WIDTH-1:0]H_imag_in,
    input [`Nt*`IN_WIDTH-1:0]y_real_in,
    input [`Nt*`IN_WIDTH-1:0]y_imag_in,
    input [`Nt*`Nr*`IN_WIDTH-1:0]grad_real_in,
    input [`Nt*`Nr*`IN_WIDTH-1:0]grad_imag_in,
    input [`Nt*`IN_WIDTH-1:0]v_real_in,
    input [`Nt*`IN_WIDTH-1:0]v_imag_in,
    input [`sampler*32-1:0]seed_in,
    
    // output
    output [`Nt*`IN_WIDTH-1:0]x_real_out,
    output [`Nt*`IN_WIDTH-1:0]x_imag_out,
    output o_done
);
// genvar j;
// generate
//     for (j=0; j<`Nt; j=j+1) begin
//         assign x_real_out[j*`IN_WIDTH+39-:`IN_WIDTH] = 
//     end
    
// endgenerate
// 输入每个元素：40bit，Q(8,32)

// reg define
// input data
reg [`Nt*`Nr*`TOTAL_WIDTH_H-1:0]H_real;
reg [`Nt*`Nr*`TOTAL_WIDTH_H-1:0]H_imag;
reg [`Nt*`TOTAL_WIDTH_y-1:0]y_real;
reg [`Nt*`TOTAL_WIDTH_y-1:0]y_imag;
reg [`Nt*`Nr*`TOTAL_WIDTH_grad_preconditioner-1:0]grad_real;
reg [`Nt*`Nr*`TOTAL_WIDTH_grad_preconditioner-1:0]grad_imag;
reg [`Nt*`TOTAL_WIDTH_v-1:0]v_real;
reg [`Nt*`TOTAL_WIDTH_v-1:0]v_imag;
// support data
reg [7:0]sampler_done_cnt;
// output data
reg [`Nt*`TOTAL_WIDTH_xhat-1:0]x_real_r;
reg [`Nt*`TOTAL_WIDTH_xhat-1:0]x_imag_r;
reg write_done;

// wire define
// for control module
wire data_local_en;
wire data_pre_en;
wire cal_en;
wire compare_en;
wire write_en;
wire data_pre_done;
wire [`sampler-1:0]cal_done;
wire compare_done;
// for data prepare module
wire [`Nt*`Nr*`TOTAL_WIDTH_pmat-1:0]pmat_real;
wire [`Nt*`Nr*`TOTAL_WIDTH_pmat-1:0]pmat_imag;
wire [`QAM_order*`TOTAL_WIDTH_xhat-1:0]constellation_norm_real;
wire [`QAM_order*`TOTAL_WIDTH_xhat-1:0]constellation_norm_imag;
wire [`sampler*`Nt*`TOTAL_WIDTH_xhat-1:0]x_real_initial;
wire [`sampler*`Nt*`TOTAL_WIDTH_xhat-1:0]x_imag_initial;
wire [`sampler*`Nt*`TOTAL_WIDTH_r-1:0]r_real_initial;
wire [`sampler*`Nt*`TOTAL_WIDTH_r-1:0]r_imag_initial;
wire [`TOTAL_WIDTH_dqam-1:0]dqam;
wire [`TOTAL_WIDTH_alpha-1:0]alpha;
wire [`sampler*`TOTAL_WIDTH_lr-1:0]lr_initial;
wire [`sampler*`TOTAL_WIDTH_step_size-1:0]step_size_initial;
wire [`sampler*`TOTAL_WIDTH_r_norm-1:0]r_norm_initial;
// for cal module
wire [`sampler*`Nt*`TOTAL_WIDTH_xhat-1:0]x_real_final;
wire [`sampler*`Nt*`TOTAL_WIDTH_xhat-1:0]x_imag_final;
wire [`sampler*`TOTAL_WIDTH_r_norm-1:0]r_norm_final;
// for compare module
wire [7:0]best_index;

// always
// 数据数据本地保存

integer j;

always @(posedge i_clk) begin
    if(i_start)begin
        for (j = 0; j < (`Nt*`Nr); j = j + 1) begin
            H_real[j*`TOTAL_WIDTH_H +: `TOTAL_WIDTH_H] =
                H_real_in[j*`IN_WIDTH + (`IN_FRAC-`FRAC_WIDTH_H) +: `TOTAL_WIDTH_H];
            H_imag[j*`TOTAL_WIDTH_H +: `TOTAL_WIDTH_H] =
                H_imag_in[j*`IN_WIDTH + (`IN_FRAC-`FRAC_WIDTH_H) +: `TOTAL_WIDTH_H];

            grad_real[j*`TOTAL_WIDTH_grad_preconditioner +: `TOTAL_WIDTH_grad_preconditioner] =
                grad_real_in[j*`IN_WIDTH + (`IN_FRAC-`FRAC_WIDTH_grad_preconditioner) +: `TOTAL_WIDTH_grad_preconditioner];
            grad_imag[j*`TOTAL_WIDTH_grad_preconditioner +: `TOTAL_WIDTH_grad_preconditioner] =
                grad_imag_in[j*`IN_WIDTH + (`IN_FRAC-`FRAC_WIDTH_grad_preconditioner) +: `TOTAL_WIDTH_grad_preconditioner];
        end
    end
end

always @(posedge i_clk) begin
    if(i_start)begin
        for (j = 0; j < `Nt; j = j + 1) begin
            y_real[j*`TOTAL_WIDTH_y +: `TOTAL_WIDTH_y] =
                y_real_in[j*`IN_WIDTH + (`IN_FRAC-`FRAC_WIDTH_y) +: `TOTAL_WIDTH_y];
            y_imag[j*`TOTAL_WIDTH_y +: `TOTAL_WIDTH_y] =
                y_imag_in[j*`IN_WIDTH + (`IN_FRAC-`FRAC_WIDTH_y) +: `TOTAL_WIDTH_y];

            v_real[j*`TOTAL_WIDTH_v +: `TOTAL_WIDTH_v] =
                v_real_in[j*`IN_WIDTH + (`IN_FRAC-`FRAC_WIDTH_v) +: `TOTAL_WIDTH_v];
            v_imag[j*`TOTAL_WIDTH_v +: `TOTAL_WIDTH_v] =
                v_imag_in[j*`IN_WIDTH + (`IN_FRAC-`FRAC_WIDTH_v) +: `TOTAL_WIDTH_v];
        end
    end
end
// genvar j, k;
// generate
//     for(j=0; j<`Nt; j=j+1) begin
//         always @(posedge i_clk) begin
//             if(data_local_en)begin
//                y_real[j*`TOTAL_WIDTH_y+:`TOTAL_WIDTH_y] <= y_real_in[j*`IN_WIDTH+35-:10];
//                y_imag[j*`TOTAL_WIDTH_y+:`TOTAL_WIDTH_y] <= y_imag_in[j*`IN_WIDTH+35-:10];
//                v_real[j*] <= v_real_in[35-:10];
//                v_imag[j*] <= v_imag_in[35-:10];
//             end 
//         end
//     end
// endgenerate
// generate
//     for(k=0; k<`Nt*`Nr; k=k+1) begin
//         always @(posedge i_clk) begin
//            if(i_rst)begin
//                H_real <= 0;
//                H_imag <= 0;
//                y_real <= 0;
//                y_imag <= 0;
//                grad_real <= 0;
//                grad_imag <= 0;
//                v_real <= 0;
//                v_imag <= 0;
//            end else if(data_local_en)begin
//                H_real <= H_real_in[35-:20];
//                H_imag <= H_imag_in[35-:20];
//                y_real <= y_real_in[35-:10];
//                y_imag <= y_imag_in[35-:10];
//                grad_real <= grad_real_in[37-:16];
//                grad_imag <= grad_imag_in[37-:16];
//                v_real <= v_real_in[35-:10];
//                v_imag <= v_imag_in[35-:10];
//            end 
//         end
//     end
// endgenerate

always @(posedge i_clk) begin
    if(i_rst)begin
        sampler_done_cnt <= 0;
    end else if(cal_done)begin
        sampler_done_cnt <= sampler_done_cnt + 1;
    end
    else if(compare_en)begin
        sampler_done_cnt <= 0;
    end else begin
        sampler_done_cnt <= sampler_done_cnt;
    end
end

// control module
main_control#(
    .sampler_num(`sampler)
)controller(
    .i_clk(i_clk),
    .i_rst(i_rst),
    // start and done signal
    .i_start(i_start),
    .o_done(o_done),
    // state signal
    .sampler_cnt(sampler_done_cnt),
    .cal_done(&cal_done),
    .data_pre_done(data_pre_done),
    .compare_done(compare_done),
    .write_done(write_done),
    .data_local_en(data_local_en),
    .data_pre_en(data_pre_en),
    .cal_en(cal_en),
    .compare_en(compare_en),
    .write_en(write_en)
);

// data prepare module
Data_pre#(
    .sampler_id(1)
)data_pre(
    .i_clk(i_clk),
    .i_rst(i_rst),
    .data_pre_en(data_pre_en),
    .i_H_real(H_real),
    .i_H_imag(H_imag),
    .i_y_real(y_real),
    .i_y_imag(y_imag),
    .i_grad_real(grad_real),
    .i_grad_imag(grad_imag),
    .i_sigma2(),
    .i_seed(seed_in),                       // wait for input

    .o_pmat_real(pmat_real),
    .o_pmat_imag(pmat_imag),
    .o_constellation_norm_real(constellation_norm_real),
    .o_constellation_norm_imag(constellation_norm_imag),
    .o_x_real(x_real_initial),
    .o_x_imag(x_imag_initial),
    .o_r_real(r_real_initial),
    .o_r_imag(r_imag_initial),
    // simple data
    .o_dqam(dqam),
    .o_alpha(alpha),
    .o_lr(lr_initial),
    .o_step_size(step_size_initial),
    .o_r_norm(r_norm_initial),
    .data_pre_done(data_pre_done)
);

genvar i;
generate
// core cal module
    for(i=0; i<`sampler; i=i+1)begin:core_cal_gen
        Core_cal#(
            .sampler_id(i)
        )core_cal(
            .i_clk(i_clk),
            .i_rst(i_rst),
            .cal_en(cal_en),
            .i_H_real(H_real),
            .i_H_imag(H_imag),
            .i_y_real(y_real),
            .i_y_imag(y_imag),
            .i_v_real(v_real),
            .i_v_imag(v_imag),
            .i_grad_real(grad_real),
            .i_grad_imag(grad_imag),
            .i_pmat_real(pmat_real),
            .i_pmat_imag(pmat_imag),
            .i_constellation_norm_real(constellation_norm_real),
            .i_constellation_norm_imag(constellation_norm_imag),
            .i_dqam(dqam),
            .i_alpha(alpha),
            .i_sigma2(),
            .i_seed(seed_in[32*i+:32]),                       // wait for input
            .i_lr(lr_initial[i*`TOTAL_WIDTH_lr +: `TOTAL_WIDTH_lr]),
            .i_step_size(step_size_initial[i*`TOTAL_WIDTH_step_size +: `TOTAL_WIDTH_step_size]),
            .i_r_norm(r_norm_initial[i*`TOTAL_WIDTH_r_norm +: `TOTAL_WIDTH_r_norm]),
            .i_r_norm_survivor(r_norm_initial[i*`TOTAL_WIDTH_r_norm +: `TOTAL_WIDTH_r_norm]),
            .i_x_real(x_real_initial[i*`Nt*`TOTAL_WIDTH_xhat+: `Nt*`TOTAL_WIDTH_xhat]),
            .i_x_imag(x_imag_initial[i*`Nt*`TOTAL_WIDTH_xhat+: `Nt*`TOTAL_WIDTH_xhat]),
            .i_r_real(r_real_initial[i*`Nt*`TOTAL_WIDTH_r+: `Nt*`TOTAL_WIDTH_r]),
            .i_r_imag(r_imag_initial[i*`Nt*`TOTAL_WIDTH_r+: `Nt*`TOTAL_WIDTH_r]),
            .o_x_real(x_real_final[i*`Nt*`TOTAL_WIDTH_xhat+: `Nt*`TOTAL_WIDTH_xhat]),
            .o_x_imag(x_imag_final[i*`Nt*`TOTAL_WIDTH_xhat+: `Nt*`TOTAL_WIDTH_xhat]),
            .o_r_norm(r_norm_final[i*`TOTAL_WIDTH_r_norm+: `TOTAL_WIDTH_r_norm]),
            .cal_done(cal_done[i])
        );
    end
endgenerate
// compare module
Comparison#(
    .Nt(`Nt),
    .Nr(`Nr),
    .sampler_num(`sampler),
    .TOTAL_WIDTH(`TOTAL_WIDTH_r_norm)
)compare(
    .i_clk(i_clk),
    .i_rst(i_rst),
    .compare_en(compare_en),
    .i_r_norm(r_norm_final),
    .which_max(best_index),
    .compare_done(compare_done)
);

// output always block
always @(posedge i_clk) begin
    if(i_rst)begin
        x_real_r <= 0;
        x_imag_r <= 0;
        write_done <= 0;
    end
    else if(write_en)begin
        x_real_r <= x_real_final[best_index*`Nt*`TOTAL_WIDTH_xhat+: `Nt*`TOTAL_WIDTH_xhat];
        x_imag_r <= x_imag_final[best_index*`Nt*`TOTAL_WIDTH_xhat+: `Nt*`TOTAL_WIDTH_xhat];
        write_done <= 1;
    end
    else begin
        x_real_r <= x_real_r;
        x_imag_r <= x_imag_r;
        write_done <= 0;
    end
end

endmodule
