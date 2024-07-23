library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity controller is 
Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        zero    : in  STD_LOGIC;
        opcode  : in  STD_LOGIC_VECTOR(2 downto 0);
        phase   : in  STD_LOGIC_VECTOR(2 downto 0);
        sel     : out STD_LOGIC;
        rd      : out STD_LOGIC;
		   ld_ir   : out STD_LOGIC;
        halt    : out STD_LOGIC;
        inc_pc  : out STD_LOGIC;
        ld_ac   : out STD_LOGIC;
        ld_pc   : out STD_LOGIC;
        wr      : out STD_LOGIC;
        data_e  : out STD_LOGIC
    );

		  
end controller;

architecture Behavioral of controller is
signal HLT : std_logic;
		signal ALU_OP :std_logic;
		SIGNAL JMP : std_logic ;
		SIGNAL skz : std_logic ;
		SIGNAL sto : std_logic ;
begin
		ALU_OP <='1' when opcode = "010" or opcode = "011" or opcode = "100" or opcode = "101" else '0';
		HLT <= '1' when opcode = "000" else '0';
		skz <= '1' when opcode = "001" else '0' ;
		sto <= '1' when opcode = "110" else '0' ;
		JMP <= '1' when opcode = "110" else '0' ;
process(clk, rst,phase)
    begin
        if rst = '1' then
            -- Reset all outputs
            sel <= '0';
            rd <= '0';
            ld_ir <= '0';
            halt <= '0';
            inc_pc <= '0';
            ld_ac <= '0';
            ld_pc <= '0';
            wr <= '0';
            data_e <= '0';
        elsif rising_edge(clk) then
            case phase is
when "000" => -- INST_ADDR
                    sel <= '1';
                    rd <= '0';
                    ld_ir <= '0';
                    halt <= '0';
                    inc_pc <= '0';
                    ld_ac <= '0';
                    ld_pc <= '0';
                    wr <= '0';
                    data_e <= '0';
when "001" => -- INST_FETCH
                    sel <= '1';
                    rd <= '1';
                    ld_ir <= '0';
                    halt <= '0';
                    inc_pc <= '0';
                    ld_ac <= '0';
                    ld_pc <= '0';
                    wr <= '0';
                    data_e <= '0';
 when "010" => -- INST_LOAD
                    sel <= '1';
                    rd <= '1';
                    ld_ir <= '1';
                    halt <= '0';
                    inc_pc <= '0';
                    ld_ac <= '0';
                    ld_pc <= '0';
                    wr <= '0';
                    data_e <= '0';
when "011" => -- IDLE
                    sel <= '1';
                    rd <= '1';
                    ld_ir <= '1';
                    halt <= '0';
                    inc_pc <= '0';
                    ld_ac <= '0';
                    ld_pc <= '0';
                    wr <= '0';
                    data_e <= '0';
 when "100" => -- OP_ADDR
                    sel <= '0';
                    rd <= '0';
                    ld_ir <= '0';
						  halt <= HLT ;
                    inc_pc <= '1';
                    ld_ac <= '0';
                    ld_pc <= '0';
                    wr <= '0';
                    data_e <= '0';
 when "101" => -- OP_FETCH
                    sel <= '0';
                    rd <= ALU_OP ;
                    ld_ir <= '0';
                    halt <= '0';
                    inc_pc <= '0';
                    ld_ac <= '0';
                    ld_pc <= '0';
                    wr <= '0';
                    data_e <= '0';
  when "110" => -- ALU_OP
                    sel <= '0';
                    rd <= ALU_OP ;
                    ld_ir <= '0';
                    halt <= '0';
                    inc_pc <= zero and skz ;
                    ld_ac <= '0' ;
                    ld_pc <= JMP ;
                    wr <= '0';
                    data_e <= sto;
  when "111" => -- STORE
                    sel <= '0';
                    rd <= ALU_OP;
                    ld_ir <= '0';
                    halt <= '0';
                    inc_pc <= '0';
                    ld_ac <= ALU_OP;
                    ld_pc <= JMP ;
                    wr <=  sto ;
                    data_e <= sto; when others =>
                    -- Default case
                    sel <= '0';
                    rd <= '0';
                    ld_ir <= '0';
                    halt <= '0';
                    inc_pc <= '0';
                    ld_ac <= '0';
                    ld_pc <= '0';
                    wr <= '0';
                    data_e <= '0';end case;
        end if;
    end process;
end Behavioral;

