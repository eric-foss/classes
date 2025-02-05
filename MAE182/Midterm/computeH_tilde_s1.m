function out1 = computeH_tilde_s1(x,y,z,u,v,w,xs1,ys1,zs1,theta,thetadot)
%computeH_tilde_s1
%    OUT1 = computeH_tilde_s1(X,Y,Z,U,V,W,XS1,YS1,ZS1,THETA,THETADOT)

%    This function was generated by the Symbolic Math Toolbox version 9.0.
%    29-Feb-2024 16:59:25

t2 = cos(theta);
t3 = sin(theta);
t4 = u.*x;
t5 = u.*xs1;
t6 = u.*ys1;
t7 = v.*xs1;
t8 = v.*y;
t9 = v.*ys1;
t10 = x.*xs1;
t11 = w.*z;
t12 = w.*zs1;
t13 = x.*ys1;
t14 = xs1.*y;
t15 = y.*ys1;
t16 = x.*2.0;
t17 = x.^2;
t18 = xs1.*2.0;
t19 = xs1.^2;
t20 = y.*2.0;
t21 = y.^2;
t22 = ys1.*2.0;
t23 = ys1.^2;
t24 = z.*2.0;
t25 = z.^2;
t26 = zs1.*2.0;
t27 = zs1.^2;
t40 = z.*zs1.*-2.0;
t28 = t10.*2.0;
t29 = t13.*2.0;
t30 = t14.*2.0;
t31 = t15.*2.0;
t32 = t24.*zs1;
t33 = -t18;
t34 = -t20;
t35 = -t26;
t36 = -t7;
t37 = -t12;
t38 = -t14;
t41 = t2.*t16;
t42 = t2.*t18;
t43 = t2.*t20;
t44 = t2.*t22;
t45 = t3.*t16;
t46 = t3.*t18;
t47 = t3.*t20;
t48 = t3.*t22;
t49 = t2.*xs1.*-2.0;
t50 = t2.*y.*-2.0;
t51 = t10+t15;
t52 = t5+t9;
t39 = -t30;
t53 = t24+t35;
t54 = t13+t38;
t55 = t28+t31;
t56 = t6+t36;
t58 = t2.*t52;
t59 = t3.*t51.*thetadot;
t66 = t33+t41+t47;
t67 = t16+t48+t49;
t68 = t22+t45+t50;
t69 = t34+t44+t46;
t57 = t29+t39;
t60 = -t58;
t61 = t2.*t55;
t62 = t3.*t56;
t64 = t2.*t54.*thetadot;
t63 = t3.*t57;
t65 = -t61;
t74 = t4+t8+t11+t37+t59+t60+t62+t64;
t70 = t17+t19+t21+t23+t25+t27+t40+t63+t65;
t71 = 1.0./sqrt(t70);
t72 = t71.^3;
t73 = t71.*w;
t75 = (t53.*t71)./2.0;
t76 = (t53.*t72.*t74)./2.0;
out1 = reshape([(t67.*t71)./2.0,t71.*(u+t3.*thetadot.*xs1+t2.*thetadot.*ys1)-(t67.*t72.*t74)./2.0,t69.*t71.*(-1.0./2.0),t71.*(v-t2.*thetadot.*xs1+t3.*thetadot.*ys1)+(t69.*t72.*t74)./2.0,t75,t73-t76,0.0,t71.*(x-t2.*xs1+t3.*ys1),0.0,-t71.*(-y+t3.*xs1+t2.*ys1),0.0,t71.*(z-zs1),0.0,0.0,0.0,0.0,0.0,0.0,t66.*t71.*(-1.0./2.0),-t71.*(t2.*u+t3.*v-t3.*thetadot.*x+t2.*thetadot.*y)+(t66.*t72.*t74)./2.0,(t68.*t71)./2.0,t71.*(t3.*u-t2.*v+t2.*thetadot.*x+t3.*thetadot.*y)-(t68.*t72.*t74)./2.0,-t75,-t73+t76,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],[2,18]);
