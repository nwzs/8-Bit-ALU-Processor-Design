library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_core is
    port (
    A                    :    in        std_logic_vector(7 downto 0);
    B                    :    in        std_logic_vector(7 downto 0);
    OP                   :    in        std_logic_vector(15 downto 0);
    Result               :    out        std_logic_vector(7 downto 0)
    );
end entity alu_core;
    
architecture rtl of alu_core is
    signal a_u, b_u    : unsigned(7 downto 0);
    signal res            : std_logic_vector(7 downto 0);
begin
    a_u <= unsigned(A);
    b_u <= unsigned(B);
    
    process(A, B, OP, a_u, b_u)
        variable temp    :    std_logic_vector(7 downto 0);
    begin
        res <= (others => '0');
        temp := (others => '0');
        
        if        OP(0) = '1' then
            res <= A(3 downto 0) & A(7 downto 4);
            
        elsif    OP(1) = '1' then
            res <= A xor B;
            
        elsif    OP(2) = '1' then
            res <= B(0) & B(1) & B(2) & B(3) & B(4) & B(5) & B(6) & B(7);
            
        elsif    OP(3) = '1' then
            res <= std_logic_vector(a_u + b_u - 2);
            
        elsif    OP(4) = '1' then
            res <= B(5 downto 0) & B(7 downto 6);
        
        elsif    OP(5) = '1' then
            temp := B;
            temp(0) := not temp(0);
            temp(2) := not temp(2);
            temp(4) := not temp(4);
            temp(6) := not temp(6);
            res <= temp;
            
        elsif    OP(6) = '1' then
            temp := B;
            temp(3 downto 0) := A(3 downto 0);
            res <= temp;
            
        elsif    OP(7) = '1' then
            res <= "00" & B(7 downto 2);
            
        elsif    OP(8) = '1' then
            temp := A;
            temp(3 downto 0) := not A(3 downto 0);
            res <= temp;
            
        end if;
    end process;
    
    Result <= res;
end architecture rtl;
