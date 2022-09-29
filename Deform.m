classdef Deform < handle
    properties
        m_graph
        m_iters
        m_crep = 2.0;
        m_c_spring = 1.0;
        m_l = 0.1;
        m_cooling = 0.1;
        m_epslon = 0.0001;
    end
    methods
        function this = Deform(G,iters)
            this.m_graph = G;
            n = G.m_n;
            this.m_l = 1.0;
            this.m_iters = iters;
            this.Run()
        end
        function f = FRep(this,u,v)
            d = u - v;
            dir = d/norm(d);
            f = this.m_crep*dir /dot(d,d);
        end
        function f = FAttr(this,u,v)
            d = v - u;
            dir = d/norm(d);
            f = this.m_c_spring * log(norm(d)/this.m_l) * dir;
        end
        function F = CalculateForces(this)
            n = this.m_graph.m_n;            
            m = this.m_graph.m_m;
            F = zeros(2,n);
            for i = 1:n
                u = this.m_graph.m_poses(:,i);
                for j = 1:n
                    if i == j
                        continue;
                    end
                    v = this.m_graph.m_poses(:,j);
                    F(:,i) = F(:,i) + this.FRep(u,v);
                end
            end
            for i = 1:m
                edge = this.m_graph.m_edges(i,:);
                u = this.m_graph.m_poses(:,edge(1));
                v = this.m_graph.m_poses(:,edge(2));
                d = norm(u-v);
                Fi = this.FAttr(u,v);
                F(:,edge(1)) = F(:,edge(1)) + this.FAttr(u,v) - this.FRep(u,v);
                F(:,edge(2)) = F(:,edge(2)) + this.FAttr(v,u) - this.FRep(v,u);
                %quiver(u(1),u(2),Fi(1),Fi(2));
                %quiver(v(1),v(2),-Fi(1),-Fi(2));
            end            
        end
        function Run(this)
            t = 1;
            f = realmax;
            this.m_graph.Show();
            
            while t < this.m_iters && f > this.m_epslon
                F = this.CalculateForces();
                displ = this.m_cooling*F;
                %quiver(this.m_graph.m_poses(1,:),this.m_graph.m_poses(2,:),displ(1,:),displ(2,:));
                this.m_graph.m_poses = this.m_graph.m_poses + displ;
                this.m_graph.Show();
                pause(0.01);
                t = t +  1;
                f = max(vecnorm(F))
            end
        end
    end
end