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
    begin
        res <= (others => '0');
        
        if        OP(0) = '1' then
            res <= std_logic_vector(a_u + b_u);
            
        elsif    OP(1) = '1' then
            res <= std_logic_vector(a_u - b_u);
            
        elsif    OP(2) = '1' then
            res <= A and B;
            
        elsif    OP(3) = '1' then
            res <= A or B;
            
        elsif    OP(4) = '1' then
            res <= A xor B;
        
        elsif    OP(5) = '1' then
            res <= not (A and B);
            
        elsif    OP(6) = '1' then
            res <= not (A or B);
            
        elsif    OP(7) = '1' then
            res <= std_logic_vector(a_u + 1);
            
        elsif    OP(8) = '1' then
            res <= std_logic_vector(b_u + 1);
            
        end if;
    end process;
    
    Result <= res;
end architecture rtl;
