#! /usr/bin/perl
use strict;
use warnings;

main (@ARGV);

sub main{
  my $dir_name = shift @ARGV;
  opendir (DIR, $dir_name) or die "Cannot find dirctory '$dir_name' : $!";
  my @files = readdir (DIR) or die "Cannot find valid files : $!";
  my $filename = 0;		
  foreach my $file_name (@files) {
    $filename = "Null";
    if($file_name =~ m/^(\S*).asm$/i) {
	if (index($1, "core0") != -1) {$filename = "inst0";}
	if (index($1, "core1") != -1) {$filename = "inst1";}
	if (index($1, "core2") != -1) {$filename = "inst2";}
	if (index($1, "core3") != -1) {$filename = "inst3";}
      system("perl parser.pl -s < ./$dir_name/$1.asm > ./$dir_name/$filename.txt");
	  # system("perl parser.pl -p < ./$dir_name/$1.asm > ./$dir_name/instr_pkg_$1.txt");
	  # system("python generate_instruction_vhdl.py ./$dir_name/instr_pkg_$1.txt");
	  # unlink("./$dir_name/instr_pkg_$1.txt")	    
    }
  }

  closedir DIR;
}
