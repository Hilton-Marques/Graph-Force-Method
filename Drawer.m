classdef Drawer < handle
    properties
        m_h = [];
        m_e = [];
    end
    methods
        function this = Drawer()
            figure
            hold on
            axis equal
            %axis off
        end
        function DrawNode(this, x)
            r = 0.05;
            theta = linspace(0,2*pi,30);
            x = x + r*[cos(theta);sin(theta)];
            this.m_h(end+1) = plot(x(1,:),x(2,:),'Color','red');
        end
        function DrawEdge(this,p1,p2)
            this.m_e(end+1) = line([p1(1),p2(1)],[p1(2),p2(2)],'Color','black');
        end
        function Reset(this)
            delete(this.m_h);
            delete(this.m_e);
            this.m_h = [];
            this.m_e = [];
        end
    end
end