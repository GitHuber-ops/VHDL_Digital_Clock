library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clock is
port( clk : in std_logic; 
	reset: in std_logic;
	dins : in std_logic_vector(6 downto 0);
	dinm : in std_logic_vector(6 downto 0);
	dinh : in std_logic_vector(5 downto 0);
	secondl: out std_logic_vector(6 downto 0);
	secondh: out std_logic_vector(6 downto 0);
	minutel: out std_logic_vector(6 downto 0);
	minuteh: out std_logic_vector(6 downto 0);
	hourl: out std_logic_vector(6 downto 0);
	hourh: out std_logic_vector(6 downto 0));
end clock;

architecture clock1 of clock is
component counter10 is
      port(clk: in std_logic;
      reset : in std_logic;
      din : in std_logic_vector(3 downto 0);
	  dout : out std_logic_vector(3 downto 0);
	  c : out std_logic);
end component;
	
component counter6 is
      port( clk: in std_logic;
	  reset : in std_logic;
      din : in std_logic_vector(2 downto 0);
	  dout : out std_logic_vector(2 downto 0);
	  c :out std_logic);
end component;

component counter24 is
      port( clk : in std_logic;
	  reset : in std_logic;
      din : in std_logic_vector(5 downto 0); 
      dout : out std_logic_vector(5 downto 0));
end component;

component mux1 is
      port (din:in std_logic_vector(3 downto 0 );
dout:out std_logic_vector(6 downto 0));
end component;
      signal c1,c2,c3,c4:std_logic;
      signal doutsl,doutml:std_logic_vector(3 downto 0); 
      signal doutsh,doutmh:std_logic_vector(2 downto 0);
	  signal douth:std_logic_vector(5 downto 0);
      signal rdoutsh,rdoutmh:std_logic_vector(3 downto 0);
	  signal rdouth:std_logic_vector(7 downto 0);
begin
	  rdoutsh <='0'&doutsh;
      rdoutmh<='0'&doutmh;
	  rdouth <="00"&douth;
	  u1: counter10 port map(clk=>clk,reset=>reset,din=>dins(3 downto 0),dout=>doutsl,c=>c1);
	  u2: counter6 port map(clk=>c1,reset=>reset,din=>dins(6 downto 4),dout=>doutsh,c=>c2);
      u3: counter10 port map(clk=>c2,reset=>reset,din=>dinm(3 downto 0),dout=>doutml,c=>c3);
	  u4: counter6 port map(clk=>c3,reset=>reset,din=>dinm(6 downto 4),dout=>doutmh,c=>c4);
      u5: counter24 port map( clk=>c4,reset=>reset,din=> dinh,dout=> douth);
      u6: mux1 port map( din => doutsl,dout => secondl);
	  u7: mux1 port map( din => rdoutsh,dout => secondh);
	  u8: mux1 port map( din => doutml,dout => minutel);
      u9: mux1 port map( din => rdoutmh,dout => minuteh);
	  u10: mux1 port map( din => rdouth(3 downto 0),dout => hourh);
	  u11: mux1 port map( din => rdouth(7 downto 4),dout => hourl);
end clock1;




