#!/usr/bin/perl -W

use strict;
use Cwd;


my $dir = getcwd;

my $usage = "repack-bootimg.pl <kernel> <ramdisk-directory> <outfile>\n";

die $usage unless $ARGV[0] && $ARGV[1] && $ARGV[2];

chdir $ARGV[1] or die "$ARGV[1] $!";

system ("find . | cpio -o -H newc | gzip > $dir/ramdisk-repack.cpio.gz");

chdir $dir or die "$ARGV[1] $!";;

#Just modified for HTC One CTC version, m7cdwg
#system ("mkbootimg --cmdline 'no_console_suspend=1 console=null' --kernel $ARGV[0] --ramdisk ramdisk-repack.cpio.gz -o $ARGV[2]");
system ("mkbootimg --cmdline 'console=ttyHSL0,115200,n8 androidboot.hardware=m7cdwg user_debug=31' --kernel $ARGV[0] --ramdisk ramdisk-repack.cpio.gz --base 0x80600000 --ramdiskaddr 0x81a00000 -o $ARGV[2]");

unlink("ramdisk-repack.cpio.gz") or die $!;

print "\nrepacked boot image written at $ARGV[1]-repack.img\n";
