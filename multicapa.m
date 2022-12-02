classdef multicapa < handle
    properties
        n
        esp
        n_x
        n_ef
        lambda
        theta
        TE
        TM
        P
        MTE
        MTM
        TTE
        RTE
        TTM
        RTM
    end
    properties (Dependent)
        numero_capas
        k
    end
    methods
        function obj = multicapa(indices,espesores)
            obj.n = indices;
            obj.esp = espesores;
        end

        function set.n(obj,valor)
            obj.n = valor;
        end

        function set.lambda(obj,valor)
            obj.lambda = valor;
        end

        function set.theta(obj,valor)
            obj.theta = valor;
        end

        function val = get.numero_capas(obj)
            val = numel(obj.esp);
        end

        function val = get.k(obj)
            val = 2*pi/obj.lambda;
        end

        function val = calculo_nef(obj)
            val = obj.n(1)*sin(deg2rad(obj.theta));
        end

        function val = calculo_nx(obj)
            val = zeros(1,length(obj.n));
            for i=1:length(obj.n)
                val(i) = sqrt(obj.n(i)^2-obj.n_ef^2);
            end
        end

        function val = calculo_TE(obj,num_capa)
            A = [1 1; -obj.n_x(num_capa) obj.n_x(num_capa)];
            B = [1 1; -obj.n_x(num_capa+1) obj.n_x(num_capa+1)];
            val = pinv(A)*B;
        end

        function val = calculo_TM(obj,num_capa)
            A = [1 1; -obj.n_x(num_capa)/obj.n(num_capa)^2 obj.n_x(num_capa)/obj.n(num_capa)^2];
            B = [1 1; -obj.n_x(num_capa+1)/obj.n(num_capa+1)^2 obj.n_x(num_capa+1)/obj.n(num_capa+1)^2];
            val = pinv(A)*B;
        end

        function val = calculo_P(obj,num_capa)
            val = [exp(1i*obj.k*obj.n_x(num_capa+1)*obj.esp(num_capa)) 0; 0 exp(-1i*obj.k*obj.n_x(num_capa+1)*obj.esp(num_capa))];
        end

        function val = calculo_MTE(obj)
            val = [1 0;0 1];
            if obj.numero_capas == 0
                val = calculo_TE(obj,1);
            else
                for i=1:obj.numero_capas
                    val = val*calculo_TE(obj,obj.numero_capas+2-i);
                    val = val*calculo_P(obj,obj.numero_capas+1-i);
                end
                val = val*calculo_TE(obj,1);
            end
        end

        function val = calculo_MTM(obj)
            val = [1 0;0 1];
            if obj.numero_capas == 0
                val = calculo_TM(obj,1);
            else
                for i=1:obj.numero_capas
                    val = val*calculo_TM(obj,obj.numero_capas+2-i);
                    val = val*calculo_P(obj,obj.numero_capas+1-i);
                end
                val = val*calculo_TM(obj,1);
            end
        end
        
        function obj = calculo_M(obj)
            obj.n_ef = obj.calculo_nef;
            obj.n_x = obj.calculo_nx;
            obj.MTE = obj.calculo_MTE;
            obj.MTM = obj.calculo_MTM;
        end

        function obj = calculo_coeficientes(obj)
            obj.calculo_M;
            obj.RTE = abs(-obj.MTE(2,1)/obj.MTE(2,2))^2;
            obj.RTM = abs(-obj.MTM(2,1)/obj.MTM(2,2))^2;
            obj.TTE = real(obj.n_x(1)/obj.n_x(end)*abs(obj.MTE(1,1)-obj.MTE(1,2)*obj.MTE(2,1)/obj.MTE(2,2))^2);
            obj.TTM = real(obj.n_x(1)/obj.n_x(end)*(obj.n(end)/obj.n(1))^2*abs(obj.MTM(1,1)-obj.MTM(1,2)*obj.MTM(2,1)/obj.MTM(2,2))^2);
        end
    end
end