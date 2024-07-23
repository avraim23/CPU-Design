library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity regester is
Port (
      opcode : out std_logic_vector ( 2 downto 0) ; 
		data_in  : in  std_logic_vector(7 downto 0);
		data_out : out std_logic_vector(7 downto 0);
      load     : in  std_logic;
      clk      : in  std_logic;
      rst      : in  std_logic 		
     );

end regester;

architecture Behavioral of regester is
 signal reg : std_logic_vector(7 downto 0); 
begin
     process(clk,rst)
begin
     if(rst='1')             then
reg<="00000000";--reset to default value which is zero

     elsif(rising_edge(clk)) then
	 
     if load='1'             then 
	  
reg<=data_in;
       end if;
    end if;
end process;

data_out<=reg;	 
end Behavioral;

