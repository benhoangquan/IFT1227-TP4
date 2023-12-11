library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4 is
 port(
    d0,d1,d2,d3 : in STD_LOGIC;
    s: in STD_LOGIC_VECTOR (1 downto 0);
    z: out STD_LOGIC
  );
end mux4;

architecture synth of mux4 is
begin
    process (s) 
	 begin
	 case s is
            when "00" => z <= d0;
            when "01" => z <= d1;
            when "10" => z <= d2;
            when others => z <= d3;
    end case;
    end process;
end synth;