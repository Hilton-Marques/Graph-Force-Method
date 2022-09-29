close all
clc;
clear;

n = 10;
G = [[0,1,1,0,1,0,0,0];
[1,0,0,1,0,1,0,0];
[1,0,0,1,0,0,1,0];
[0,1,1,0,0,0,0,1];
[1,0,0,0,0,1,1,0];
[0,1,0,0,1,0,0,1];
[0,0,1,0,1,0,0,1];
[0,0,0,1,0,1,1,0]];

%G = round(rand(n));
%G = triu(G) + triu(G,1)';
%G = G - diag(diag(G));
g = Graph(G);
def = Deform(g,500);
def.Run();
%g.Show()

function DrawGraph(G)
n = size(G,1);
pose = [rand(1,n);rand(1,n)];
for i = 1:n
    DrawNode(pose(:,i));
end
list = sparse(G);
[ii,jj] = find(list);
m = size(ii,1);
for i = 1:m
    DrawEdge(pose(:,ii(i)),pose(:,jj(i)))
end

end
function DrawNode(x)
r = 0.05;
theta = linspace(0,2*pi,30);
x = x + r*[cos(theta);sin(theta)];
plot(x(1,:),x(2,:),'Color','red');
end

function DrawEdge(p1,p2)
line([p1(1),p2(1)],[p1(2),p2(2)],'Color','black');
end