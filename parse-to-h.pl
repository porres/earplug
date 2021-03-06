#! /usr/bin/perl -w
#
# convert KEMAR head-related impulse response measurement data set to
# header file 3 dimensional array
#

$DATAFILE = "earplug_data_src.txt";
open(DATAFILE);
#368
for ($i = 0; $i < 368; $i++) {
  $_ = <DATAFILE>;
#  if(m|^\*\*(.*)\*\*$|) {$comment[$i] = $1;}
#  if(m|^\*\*.*H-(.*)\.wav \*\*$|) {$arrayname[$i] = "H_$1";}
  $_ = <DATAFILE>;
  for ($j = 0 ; $j < 128 ; $j++) {
	#	fscanf(fp, "%f %f ", $impulses[$i][0][$j], $impulses[$i][1][$j]);
	while (m|([0-9.-]+) ([0-9.-]+) |g) {
	  $impulses[$i][0][$j] = $1;
	  $impulses[$i][1][$j] = $2;
	}
  }
  $_ = <DATAFILE>;
}
close(DATAFILE);

print("t_float impulses\[368\]\[2\]\[128\] = {\n");
for ($i = 0; $i < 368; $i++) {
#  print("/*$comment[$i]*/\n");
#  print("float $arrayname[$i]\[2\]\[128\] = {\n{");
  print("{\n{");
  for ($j = 0 ; $j < 128 ; $j++) {
	print("$impulses[$i][0][$j], ");
  }
  print("},\n{");
  for ($j = 0 ; $j < 128 ; $j++) {
	print("$impulses[$i][1][$j], ");
  }
  print("}\n},\n");
}
print("\n};\n\n");
