library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main_system is
    Port (
        clk, rst, load, enab, data_en : in std_logic;
        cnt_in : in std_logic_vector(4 downto 0);
        data_in : in std_logic_vector(7 downto 0);
        sel : in std_logic;
        opcode : in std_logic_vector(2 downto 0);
        phase : in std_logic_vector(2 downto 0);
        zero : in std_logic;
        a_is_zero : out std_logic;
        cnt_out : out std_logic_vector(4 downto 0);
        data_out, alu_out : out std_logic_vector(7 downto 0);
        ld_ir, halt, inc_pc, ld_ac, ld_pc, rd , wr, data_e : out std_logic
    );
	 end main_system;

architecture Behavioral of main_system is
    
	 component   regester is
        Port (
            load, rst, clk : in std_logic;
            data_in : in std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(7 downto 0)
        );
    end component;	
	 
	 
	 component counter is
        Port (
            load, rst, clk, enab : in std_logic;
            cnt_in : in std_logic_vector(4 downto 0);
            cnt_out : out std_logic_vector(4 downto 0)
        );
    end component;	 
	 
	 component Controller is
        Port (
            clk, rst, zero : in std_logic;
            opcode : in std_logic_vector(2 downto 0);
            phase : in std_logic_vector(2 downto 0);
            sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e : out std_logic
        );
    end component;
component Multiplexor is
        Port (
            sel : in std_logic;
            in0, in1 : in std_logic_vector(4 downto 0);
            mux_out : out std_logic_vector(4 downto 0)
        );
    end component;

    component ALU is
        Port (
            in_a, in_b : in std_logic_vector(7 downto 0);
            opcode : in std_logic_vector(2 downto 0);
            alu_out : out std_logic_vector(7 downto 0);
            a_is_zero : out std_logic
        );
			end component ;
	 component memory is
        generic (
            AWIDTH : integer := 5;
            DWIDTH : integer := 8
        );
        port (
            clk : in std_logic;
            wr, rd : in std_logic;
            addr : in std_logic_vector(AWIDTH-1 downto 0);
            data : inout std_logic_vector(DWIDTH-1 downto 0)
        );
    end component;
	 component DATA_DRIVER is
        Port (
            data_in : in std_logic_vector (7 downto 0) ;
				data_en : in std_logic ;
				data_out : out std_logic_vector (7 downto 0 )
        );
			end component ;
	 
	 
	    
   
signal internal_sel : std_logic;
signal internal_wr : std_logic;
signal internal_rd : std_logic;
signal internal_cnt_out : std_logic_vector(4 downto 0) ;
signal internal_data_out : std_logic_vector(7 downto 0) ;
signal internal_data : std_logic_vector(7 downto 0) ;
signal internal_ac_out : std_logic_vector(7 downto 0) ;
signal internal_ld_pc : std_logic ;
signal internal_inc_pc : std_logic ;
signal internal_ir_addr : std_logic_vector(4 downto 0) ;
signal internal_pc_addr : std_logic_vector(4 downto 0) ;
signal internal_addr : std_logic_vector(4 downto 0) ;
signal internal_ld_ac : std_logic ;
signal internal_ld_ir : std_logic ;
signal internal_alu_out : std_logic_vector ( 7 downto 0) ; 
signal internal_opcode : std_logic_vector ( 2 downto 0 ) ; 

begin
internal_opcode <= internal_data_out(7 downto 5) ;
internal_ir_addr <= internal_data_out(4 downto 0) ;
    -- Instantiate Controller
    controller_inst : Controller
        Port map (
            clk => clk,
            rst => rst,
            zero => zero,
            opcode => internal_opcode,
            phase => phase,
            sel => internal_sel,
            rd => internal_rd,
            ld_ir => ld_ir,
            halt => halt,
            inc_pc => inc_pc,
            ld_ac => ld_ac,
            ld_pc => ld_pc,
            wr => internal_wr,
            data_e => data_e
        );

    -- Instantiate Memory
    memory_inst : memory
        generic map (
            AWIDTH => 5,
            DWIDTH => 8
        )
        port map (
            clk => clk,
            wr => internal_wr,
            rd => internal_rd,
            addr =>internal_cnt_out,
            data => internal_data_out
        );
		  counter_inst : counter 
		  port map (  
							clk => clk , 
							rst => rst ,
							load => internal_ld_pc  ,
							enab => internal_inc_pc ,
							cnt_in => internal_ir_addr ,
							Cnt_out => internal_pc_addr  
							);
			ALU_inst : ALU
			port map ( 
							in_a => internal_data ,
							in_b => internal_ac_out ,
							opcode => internal_opcode ,
							alu_out => alu_out , 
							a_is_zero => a_is_zero
							);
							
							
			Multiplexor_inst : Multiplexor
			port map ( 
			sel => internal_sel , 
			in0 => internal_ir_addr , in1 => internal_pc_addr , mux_out => internal_addr );
			
			regester_ac_inst : regester
			port map (
						clk => clk , rst => rst ,  load =>internal_ld_ac , data_in => internal_alu_out , data_out => internal_ac_out
			);
			regester_ir_inst : regester
			port map (
						clk => clk , rst => rst ,  load => internal_ld_ir , data_in => internal_data_out  ,  data_out => internal_data_out  
			);
			DATA_DRIVER_inst : DATA_DRIVER
			port map ( 
							data_in => internal_alu_out , data_en =>data_en , data_out=> internal_data  );
			
			
			

end Behavioral;