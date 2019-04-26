//Program for DCT and IDCT
module example(input wire clk,output reg A,output [7:0]out);

reg[26:0] delay;
reg[26:0] delay1;
reg [26:0] delay2;
//reg signed [7:0] x0,x1,x2,x3;
reg signed [7:0] x0,x1,x2,x3;
reg signed [7:0] a1,a2,a3,a0;
reg signed [17:0] X0,X1,X2,X3;
reg signed [8:0] A0,A1,B0,B1;
reg signed [17:0] X0,X1,X2,X3;
reg signed [9:0] w1,w2;
reg signed [16:0] pr1,pr2,pr3,pr4;

//Inputs
assign x0=8'b00000010;//2
assign x1=8'b00010000;//16
assign x2=8'b00000010;//2
assign x3=8'b00010000;//16

assign a1=8'b01110101;
assign a2=8'b01011001;
assign a3=8'b00110000;
//Butterfly structure for DCT
assign A0=x0+x3;
assign B0=x0-x3;
assign A1=x1+x2;
assign B1=x1-x2;
assign w1=A0+A1;
assign w2=A0-A1;
assign pr1=B0*a1;
assign pr2=B1*a3;
assign pr3=B0*a3;
assign pr4=B1*a1;

always@(posedge clk) begin
delay = delay+1;
if(delay==27'b101111101011110000100000000)
//101111101011110000100000000
begin
delay=27'b0;
A=!A;
X0=w1*a2;
X2=w2*a2;
X1=pr1+pr2;
X3=pr3-pr4;
X0=X0/90;
X1=X1/127;
X2=X2/127;
X3=X3/127;
end
end

//idct variables

reg signed [15:0] l0,l1,l2,l3,l4,l5;
reg signed [16:0] k1,k2,k3,k4,k5,k6,k7,k8;
reg signed [7:0] i0,i1,i2,i3;
reg signed [17:0] x00,x10,x20,x30;
reg signed [7:0] a0;
assign a0=8'b00111111;
assign i0=X0[7:0];
assign i1=X1[7:0];
assign i2=X2[7:0];
assign i3=X3[7:0];
//Butterfly structure for IDCT
assign l0=a0*i0; 
assign l1=i1*a1;
assign l2=i2*a2;
assign l3=i3*a3;
assign k1=l0+l2; 
assign k2=l1+l3; 
assign k3=l0-l3;
assign k4=l2-l1;
assign k5=l0-l2;
assign l4=i1*a3;
assign l5=i3*a1;
assign k6=l5-l4;
assign k7=l0-l4;
assign k8=l5-l2;

//IDCT caluculatins
always@(posedge clk)begin
delay2 = delay2+1;
if(delay2==27'b101111101011110000100000000)
begin
delay2=27'b0;
x00=k1+k2;
x10=k5-k6;
x20=k7+k8;
x30=k3+k4;
x00=x00/254;
x10=x10/254;
x20=x20/254;
x30=x30/254;
end
end
//Send the output values
always@(posedge clk)begin
delay1 = delay1+1;
case (delay1)
29'b00101111101011110000100000000: out<=x00[7:0];
29'b01011111010111100001000000000: out<=x10[7:0];
29'b10001111000011010001100000000: out<=x20[7:0];
29'b10111110101111000010000000000: out<=x30[7:0];
endcase
end
endmodule
