library IEEE; use IEEE.STD_LOGIC_1164.all;

entity maindec is -- main control decoder
	port (op: in STD_LOGIC_VECTOR (5 downto 0);
			memtoreg: out STD_LOGIC_VECTOR (1 downto 0); -- modif
			memwrite: out STD_LOGIC;
			branch, alusrc: out STD_LOGIC;
			alusrcauipc: out STD_LOGIC; -- modif
			regdst: out STD_LOGIC_VECTOR (1 downto 0); -- modif
			regwrite: out STD_LOGIC;
			jump: out STD_LOGIC;
			aluop: out STD_LOGIC_VECTOR (1 downto 0));
end;

architecture behave of maindec is
	signal controls: STD_LOGIC_VECTOR(11 downto 0);
begin
process(op) begin
	case op is
		when "000000" => controls <= "010000101010"; -- Rtyp
		when "100011" => controls <= "100010011000"; -- LW
		when "101011" => controls <= "001010000000"; -- SW
		when "000100" => controls <= "000100000001"; -- BEQ
		when "000010" => controls <= "000000000100"; -- J
		when "001000" => controls <= "010010011000"; -- ADDI
		when "111111" => controls <= "010011011000"; -- auipc
		when "000011" => controls <= "000000001111"; -- jal
		when others => controls <= "---------"; -- illegal op
	end case;
end process;

	memtoreg <= controls(11 downto 10);
	memwrite <= controls(9);
	branch <= controls(8);
	alusrc <= controls(7);
	alusrcauipc <= controls(6);
	regdst <= controls(5 downto 4);
	regwrite <= controls(3);
	jump <= controls(2);
	aluop <= controls(1 downto 0);
end;