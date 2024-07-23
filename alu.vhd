library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity ALU is
    port (
        in_a, in_b : in std_logic_vector(7 downto 0);
        opcode : in std_logic_vector(2 downto 0);
        alu_out : out std_logic_vector(7 downto 0);
        a_is_zero : out std_logic
    );
end ALU;

architecture Behavioral of ALU is
begin
    process(in_a , in_b, opcode)
    begin
        case opcode is
            when "000" => alu_out <= in_a; -- pass A
            when "001" => alu_out <= in_a; -- pass A
            when "010" => alu_out <= in_a + in_b; -- add
            when "011" => alu_out <= in_a and in_b; -- A AND B
				when "100" => alu_out <= in_a xor in_b; -- A XOR B
            when "101" => alu_out <= in_b; -- pass B
            when "110" => alu_out <= in_a; -- pass A
            when others => alu_out <= in_a;
        end case;
        
        -- Assign a_is_zero
        if in_a = "00000000" then
            a_is_zero <= '1';
        else
            a_is_zero <= '0';
        end if;
    end process;
end Behavioral;