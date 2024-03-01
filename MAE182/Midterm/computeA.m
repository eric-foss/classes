function out1 = computeA(x,y,z,u,v,w,mu,J2,Cd,S,H,Re,m,r0,rho0,thetadot)
%computeA
%    OUT1 = computeA(X,Y,Z,U,V,W,MU,J2,Cd,S,H,Re,M,R0,RHO0,THETADOT)

%    This function was generated by the Symbolic Math Toolbox version 9.0.
%    29-Feb-2024 16:59:24

t2 = abs(w);
t3 = sign(w);
t4 = thetadot.*x;
t5 = thetadot.*y;
t6 = Re.^2;
t7 = x.^2;
t8 = y.^2;
t9 = z.^2;
t10 = z.^3;
t12 = 1.0./H;
t13 = 1.0./m;
t11 = t2.^2;
t14 = t5+u;
t15 = -t4;
t23 = t7+t8+t9;
t16 = abs(t14);
t17 = sign(t14);
t18 = t15+v;
t24 = 1.0./t23;
t28 = sqrt(t23);
t19 = abs(t18);
t20 = sign(t18);
t21 = t16.^2;
t25 = t24.^2;
t26 = t24.^3;
t29 = 1.0./t28;
t32 = t24.*z.*3.0;
t33 = -t28;
t37 = t9.*t24.*(3.0./2.0);
t22 = t19.^2;
t27 = t25.^2;
t30 = t29.^3;
t31 = t29.^5;
t34 = t10.*t25.*3.0;
t35 = r0+t33;
t38 = J2.*t6.*t9.*t26.*3.0;
t44 = t37-1.0./2.0;
t36 = -t34;
t39 = t11+t21+t22;
t40 = t38.*x;
t41 = t38.*y;
t42 = t12.*t35;
t43 = J2.*t6.*t9.*t27.*x.*y.*2.4e+1;
t49 = J2.*t6.*t24.*t44;
t50 = J2.*t6.*t25.*t44.*2.0;
t55 = J2.*t6.*t25.*t44.*z.*-2.0;
t56 = J2.*t6.*t26.*t44.*x.*y.*8.0;
t57 = J2.*t6.*t26.*t44.*x.*z.*8.0;
t58 = J2.*t6.*t26.*t44.*y.*z.*8.0;
t45 = exp(t42);
t46 = sqrt(t39);
t48 = t32+t36;
t51 = t50.*x;
t52 = t50.*y;
t53 = t50.*z;
t54 = t49-1.0;
t59 = -t57;
t60 = -t58;
t76 = t43+t56;
t47 = 1.0./t46;
t61 = J2.*t6.*t24.*t48;
t62 = J2.*t6.*t25.*t48.*x.*2.0;
t63 = J2.*t6.*t25.*t48.*y.*2.0;
t64 = (Cd.*S.*rho0.*t13.*t45.*t46)./2.0;
t65 = mu.*t30.*t54;
t68 = mu.*t31.*t54.*x.*y.*3.0;
t69 = mu.*t31.*t54.*x.*z.*3.0;
t70 = mu.*t31.*t54.*y.*z.*3.0;
t74 = t40+t51;
t75 = t41+t52;
t85 = mu.*t29.*t76;
t66 = t64.*thetadot;
t67 = -t64;
t71 = -t68;
t72 = -t69;
t73 = -t70;
t77 = mu.*t30.*t74.*y;
t78 = mu.*t30.*t75.*x;
t79 = mu.*t30.*t74.*z;
t80 = mu.*t30.*t75.*z;
t86 = -t85;
t87 = t55+t61;
t81 = -t77;
t82 = -t78;
t83 = -t79;
t84 = -t80;
t88 = mu.*t30.*t87.*x;
t89 = mu.*t30.*t87.*y;
mt1 = [0.0,0.0,0.0,t65+mu.*t29.*(t38+t50-J2.*t6.*t7.*t9.*t27.*2.4e+1-J2.*t6.*t7.*t26.*t44.*8.0)-mu.*t7.*t31.*t54.*3.0-mu.*t30.*t74.*x.*2.0+t12.*t14.*t29.*t64.*x+(Cd.*S.*rho0.*t13.*t14.*t19.*t20.*t45.*t47.*thetadot)./2.0,t66+t71+t81+t82+t86-(Cd.*S.*rho0.*t13.*t19.*t20.*t45.*t47.*thetadot.*(t4-v))./2.0-(Cd.*S.*rho0.*t12.*t13.*t29.*t45.*t46.*x.*(t4-v))./2.0,t72+t83+t88-mu.*t29.*(t57-t62+J2.*t6.*t24.*(t10.*t26.*x.*1.2e+1-t25.*x.*z.*6.0)+J2.*t6.*t10.*t27.*x.*6.0)+t12.*t29.*t64.*w.*x+(Cd.*S.*rho0.*t13.*t19.*t20.*t45.*t47.*thetadot.*w)./2.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
mt2 = [t71+t81+t82+t86+t12.*t14.*t29.*t64.*y-(Cd.*S.*rho0.*t13.*t45.*t46.*thetadot)./2.0-(Cd.*S.*rho0.*t13.*t14.*t16.*t17.*t45.*t47.*thetadot)./2.0,t65+mu.*t29.*(t38+t50-J2.*t6.*t8.*t9.*t27.*2.4e+1-J2.*t6.*t8.*t26.*t44.*8.0)-mu.*t8.*t31.*t54.*3.0-mu.*t30.*t75.*y.*2.0+(Cd.*S.*rho0.*t13.*t16.*t17.*t45.*t47.*thetadot.*(t4-v))./2.0-(Cd.*S.*rho0.*t12.*t13.*t29.*t45.*t46.*y.*(t4-v))./2.0,t73+t84+t89-mu.*t29.*(t58-t63+J2.*t6.*t24.*(t10.*t26.*y.*1.2e+1-t25.*y.*z.*6.0)+J2.*t6.*t10.*t27.*y.*6.0)+t12.*t29.*t64.*w.*y-(Cd.*S.*rho0.*t13.*t16.*t17.*t45.*t47.*thetadot.*w)./2.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
mt3 = [t72+t83+t88-mu.*t29.*(t57-t62+J2.*t6.*t10.*t27.*x.*1.8e+1-J2.*t6.*t26.*x.*z.*6.0)+t12.*t14.*t29.*t64.*z,t73+t84+t89-mu.*t29.*(t58-t63+J2.*t6.*t10.*t27.*y.*1.8e+1-J2.*t6.*t26.*y.*z.*6.0)-(Cd.*S.*rho0.*t12.*t13.*t29.*t45.*t46.*z.*(t4-v))./2.0,t65+mu.*t29.*(t50-J2.*t6.*t24.*(t24.*3.0-t9.*t25.*1.5e+1+t9.^2.*t26.*1.2e+1)-J2.*t6.*t9.*t26.*t44.*8.0+J2.*t6.*t25.*t48.*z.*4.0)-mu.*t9.*t31.*t54.*3.0+mu.*t30.*t87.*z.*2.0+t12.*t29.*t64.*w.*z,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,t67-(Cd.*S.*rho0.*t13.*t14.*t16.*t17.*t45.*t47)./2.0];
mt4 = [(Cd.*S.*rho0.*t13.*t16.*t17.*t45.*t47.*(t4-v))./2.0,Cd.*S.*rho0.*t13.*t16.*t17.*t45.*t47.*w.*(-1.0./2.0),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,Cd.*S.*rho0.*t13.*t14.*t19.*t20.*t45.*t47.*(-1.0./2.0),t67+(Cd.*S.*rho0.*t13.*t19.*t20.*t45.*t47.*(t4-v))./2.0,Cd.*S.*rho0.*t13.*t19.*t20.*t45.*t47.*w.*(-1.0./2.0),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,Cd.*S.*rho0.*t2.*t3.*t13.*t14.*t45.*t47.*(-1.0./2.0),(Cd.*S.*rho0.*t2.*t3.*t13.*t45.*t47.*(t4-v))./2.0,t67-(Cd.*S.*rho0.*t2.*t3.*t13.*t45.*t47.*w)./2.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t29.*t74+t30.*t54.*x,t29.*t75+t30.*t54.*y,-t29.*t87+t30.*t54.*z,0.0];
mt5 = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,mu.*t29.*(t6.*t9.*t26.*x.*3.0+t6.*t25.*t44.*x.*2.0)+mu.*t6.*t31.*t44.*x,mu.*t29.*(t6.*t9.*t26.*y.*3.0+t6.*t25.*t44.*y.*2.0)+mu.*t6.*t31.*t44.*y,-mu.*t29.*(t6.*t24.*t48-t6.*t25.*t44.*z.*2.0)+mu.*t6.*t31.*t44.*z,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,S.*rho0.*t13.*t14.*t45.*t46.*(-1.0./2.0),(S.*rho0.*t13.*t45.*t46.*(t4-v))./2.0,S.*rho0.*t13.*t45.*t46.*w.*(-1.0./2.0),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
mt6 = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
out1 = reshape([mt1,mt2,mt3,mt4,mt5,mt6],18,18);
