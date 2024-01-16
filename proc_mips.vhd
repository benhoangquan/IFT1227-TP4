library IEEE; use IEEE.STD_LOGIC_1164.all;

entity proc_mips is -- single cycle MIPS processor
	port (clk, reset: in STD_LOGIC;
			pc: out STD_LOGIC_VECTOR (31 downto 0);
			instr: in STD_LOGIC_VECTOR (31 downto 0);
			memwrite: out STD_LOGIC;
			aluout, writedata: out STD_LOGIC_VECTOR (31 downto 0);
			readdata: in STD_LOGIC_VECTOR (31 downto 0));
end;

architecture struct of proc_mips is
	component controller
		port (op, funct: in STD_LOGIC_VECTOR (5 downto 0);
				zero: in STD_LOGIC;
				memtoreg: out STD_LOGIC_VECTOR (1 downto 0); -- modif
				memwrite: out STD_LOGIC;
				pcsrc, alusrc: out STD_LOGIC;
				alusrcauipc: out STD_LOGIC; -- modif
				regdst: out STD_LOGIC_VECTOR (1 downto 0); -- modif
				regwrite: out STD_LOGIC;
				jump: out STD_LOGIC;
				alucontrol: out STD_LOGIC_VECTOR (2 downto 0));
	end component;
	component datapath
		port (clk, reset: in STD_LOGIC;
				memtoreg: in STD_LOGIC_VECTOR (1 downto 0);
				pcsrc: in STD_LOGIC;
				alusrc: in STD_LOGIC;
				alusrcauipc: in STD_LOGIC;
				regdst: in STD_LOGIC_VECTOR (1 downto 0);
				regwrite, jump: in STD_LOGIC;
				alucontrol: in STD_LOGIC_VECTOR (2 downto 0);
				zero: out STD_LOGIC;
				pc: buffer STD_LOGIC_VECTOR (31 downto 0);
				instr: in STD_LOGIC_VECTOR(31 downto 0);
				aluout, writedata: buffer STD_LOGIC_VECTOR (31 downto 0);
				readdata: in STD_LOGIC_VECTOR(31 downto 0));
	end component;
	signal alusrc, alusrcauipc, regwrite, jump, pcsrc: STD_LOGIC;
	signal memtoreg, regdst: STD_LOGIC_VECTOR (1 downto 0);
	signal zero: STD_LOGIC;
	signal alucontrol: STD_LOGIC_VECTOR (2 downto 0);
begin
	cont: controller port map (instr (31 downto 26), instr(5 downto 0), zero, memtoreg, 
								memwrite, pcsrc, alusrc, alusrcauipc, regdst, regwrite, jump, alucontrol);

	dp: datapath port map (	clk, reset, memtoreg, pcsrc, alusrc, alusrcauipc, regdst, regwrite, jump, 
									alucontrol, zero, pc, instr, aluout, writedata, readdata);
end;