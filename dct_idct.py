import numpy as np
################## verilog DCT-2 #####################
N=4;
a1=117.3226;
a2=89.8017;
a3=48.26;
x0=16;x1=16;x2=4;x3=2;

X0=(x0+x1+x2+x3)*a2;
X1=(x0-x3)*a1 +(x1-x2)*a3;
X2=(x0+x3-x1-x2)*a2;
X3=(x0-x3)*a3 -(x1-x2)*a1

#X=[X0*np.sqrt(2),X1,X2,X3]

#print("DCT",X0,X1,X2,X3)
X0=X0/127;
X1=X1/127;
X2=X2/127;
X3=X3/127;
X=[X0*np.sqrt(2),X1,X2,X3]
print(X)





print("DCT_verilog",X)
#don't forget x0/sqrt(2)
##############################################

############### wiki DCT-2 ###################
X=np.zeros((4))

X1=[x0,x1,x2,x3]


for k in range(0,4):
   sum_te=0;
   for n in range(0,4):
	sum_te=sum_te+X1[n]*np.cos((np.pi*k/4)*(n + 0.5))
   X[k]=sum_te



print("DCT_wiki",X)
###################################

########### wiki IDCT-2 ###################

x=np.zeros((4))

for k in range(0,4):
   sum_te=0;
   for n in range(1,4):
	sum_te=sum_te+X[n]*np.cos((np.pi*n/4)*(k+0.5))
   x[k]=((X[0]/2)+sum_te)/2

print("IDCT",x)
	
##################################

#X[0]=X[0]/np.sqrt(2)
############## verilog IDCT2 ################
x0=0.5*X[0]+X[1]*(np.cos(np.pi/8))+X[2]*(np.cos(2*np.pi/8))+X[3]*(np.cos(np.pi*3/8))
x1=0.5*X[0]+X[1]*(np.cos(3*np.pi/8))-X[2]*(np.cos(2*np.pi/8))-X[3]*(np.cos(np.pi/8))
x2=0.5*X[0]-X[1]*(np.cos(3*np.pi/8))-X[2]*(np.cos(2*np.pi/8))+X[3]*(np.cos(np.pi/8))
x3=0.5*X[0]-X[1]*(np.cos(np.pi/8))+X[2]*(np.cos(2*np.pi/8))-X[3]*(np.cos(3*np.pi/8))
print("IDCT_VERILOG",x0/2,x1/2,x2/2,x3/2)

