library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
entity Multiplexor is
port ( sel : in std_logic ;
		 in0 ,in1 : in std_logic_vector (4 downto 0);
		 mux_out : out std_logic_vector (4 downto 0) );
end Multiplexor;
architecture Behavioral of Multiplexor is
begin
process(sel)
begin
if (sel = '0') then 
		mux_out <= in0 ;
else 
		mux_out <= in1;
end if ;
end process ;
end Behavioral;


