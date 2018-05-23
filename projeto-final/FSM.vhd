library ieee;
use ieee.std_logic_1164.all; 
--para o contador
use ieee.std_logic_unsigned.all;

---------------------------------------------------------------------

entity JOGO is
port(KEY: in std_logic_vector(3 downto 0);
	  SW: in std_logic_vector(9 downto 0);
	  LEDR: out std_logic_vector(9 downto 0);
	  HEX0: out std_logic_vector(6 downto 0);
	  HEX1: out std_logic_vector(6 downto 0);
	  HEX2: out std_logic_vector(6 downto 0);
	  HEX3: out std_logic_vector(6 downto 0);
	  HEX4: out std_logic_vector(6 downto 0);
	  HEX5: out std_logic_vector(6 downto 0);
	  CLOCK_50: in std_logic
	  )
end JOGO;

---------------------------------------------------------------------

architecture FSM of JOGO is


component sincronizador is 
port
(
	KEY0, KEY1, KEY2, KEY3, CLK: in std_logic;
	BTN0, BTN1, BTN2, BTN3: out std_logic
);
end component;

component memoria is
port ( address : in std_logic_vector(3 downto 0); 
       data : out std_logic_vector(9 downto 0) );
end component;

type STATES is (start, setup, seg0, seg1, seg2, seg3, seg4, seg5);
signal EAtual, PEstado: STATES;
signal BUTTON: std_logic_vector(3 downto 0);
signal SAIDA_ROM: std_logic_vector(9 downto 0);

-- coisas do contador
signal C1Hz: std_logic;
signal cont: std_logic_vector(27 downto 0);

---------------------------------------------------------------------

begin

SINCRO: sincronizador port map(KEY(0), KEY(1), KEY(2), KEY(3), C1Hz, (0), BUTTON(1), BUTTON(2), BUTTON(3);--entra com o clock no sincronizador?

ROM: memoria port map(SW(9 downto 6), SAIDA_ROM(9 downto 0));

	process(CLOCK_50, KEY(0))--dar uma olhada no clock direito
		begin
			if(KEY(0) = '0') then
				EAtual <= start;
				cont <= cont + 1;
				if cont = x"2FAF07F" then
					cont <= x"0000000";
						C1Hz <= '1';
						AEstado <= PEstado;

					else
						C1Hz <= '0';
				end if;
			end if;
	end process;
	
---------------------------------------------------------------------


process (EAtual, BUTTON(3 downto 0), SW(9 downto 0))
begin
	case EAtual is
		when start => --ESTADO DE INICIO
			if (BUTTON(1) = '0') then
				PEstado <= setup;
			end if;
			
		when setup => 
		--como selecionar a rom?
				if(BUTTON(1) = '0') then
					PEstado <= seg1;
					
				end if
		 when seg5 =>
				HEX2 <= "0010010";
				HEX3 <= "1110000";
				PEstado <= seg4;
				
		when seg4 =>
				HEX2 <= "0011001";
				HEX3 <= "1110000";
				PEstado <= seg3;
				
		when seg3 =>
				HEX2 <= "0110000";
				HEX3 <= "1110000";
				PEstado <= seg2;
				
		when seg2 =>
				HEX2 <= "0100100";
				HEX3 <= "1110000";
				PEstado <= seg1;
				
		when seg1 =>
				HEX2 <= "1111001";
				HEX3 <= "1110000";
				PEstado <= seg0
				
		when seg0 =>
				HEX2 <= "0111111";
				HEX3 <= "1110000";
				PEstado <= 
				
			
