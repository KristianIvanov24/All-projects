
function project
clc %�������� ����� ����� �� ��������� ��������

%���������� ���������
a=sqrt(5);
L=3*pi;
tmax=12;

x=linspace(0,L); %������ �� 100 ����� �� 0 �� L �� ����� ���������� ���� �� �����
t=linspace(0,tmax);

%���������� ��������� ��
function y=phi(x)
    for i=1:length(x)
            y(i)=0;
    end
end

%���������� ��������� ���
function y=psi(x)
    for i=1:length(x)
        if x(i)>=0 && x(i)<=5
            y(i)=sin((5*x(i))/6);
        else
            y(i)=sin((5*x(i))/6) - 10*((x-5)^3)*((x-3*pi)^2);
        end
    end
end

%���������� ��������� u(x,t)
function y=u(x,t)
    y=0;
    for k=0:49 %55-�� �������� ���� �� ���� �� u(x,t)
        Xk=cos((2*k+1)*pi*x/(2*L));
        Ak=2*trapz(x,phi(x).*Xk)/L;
        Bk=(4*trapz(x,psi(x).*Xk))/(a*pi*(2*k+1));
        Tk=Ak*cos(((2*k+1)*a*pi*t)/(2*L))+Bk*sin(((2*k+1)*a*pi*t)/(2*L));
        y=y+Tk*Xk; %����������� ���������
    end
end

% ���������� ��������� �� ����������
for n=1:length(t)
        plot(x,u(x,t(n)),'r', 'LineWidth', 2) %2D plot; x � u(x,t(n)) �� ������� � ������� �������
        axis([0,L,-3,3]) % ������� �� plot - �� ������� � ��������
        grid on %������� ����� � plot
        getframe; %������� �������� �� �������� ��� �� ������
end

%������� � ���� �������� ��������� �� ����������
subplot(3,1,1) %������� �������� ������ �� 3x1 ������� � ������� ��� � ������� 1
plot(x,u(x,0),'r','LineWidth',2)
title('��� t=0')
grid on
hold off %������ �� ���������� �� ����������� �� plot

subplot(3,1,2)
plot(x,u(x,20),'r','LineWidth',2)
title('��� t=20')
grid on
hold off

subplot(3,1,3)
plot(x,u(x,tmax),'r','LineWidth',2)
title('��� t=50')
grid on
hold off

end