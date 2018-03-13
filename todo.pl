#! /usr/bin/perl
use Cwd;
use POSIX;
use POSIX qw(strftime);

#############################################
$numArgs = $#ARGV +1;
$ARGV[$argnum];

$UserID= POSIX::cuserid();
$UserIDCern=$UserID;
$UserDir="";


$PWD=getcwd;

if($ARGV[0] eq "--help" || $ARGV[0] eq ""){
    printf("\n\n\n ========================================================================================");
    printf("\nWelcome to Combine Harvester installer.");
    printf("\n./todo.pl --help                                             Prints this message"); 
    printf("\n./todo.pl --setup  <workdir>                                 Install CombineHarvester to <workdir>/CMSSW_8_1_0/src; settings are according to http://cms-analysis.github.io/CombineHarvester/index.html; The CMSSW version is set to 8_1_0 by default so far ");
    printf("\n  ========================================================================================\n");
    exit(0);  
}
my $dir = getcwd;
$time= strftime("%h_%d_%Y",localtime);


for($l=0;$l<$numArgs; $l++){
    
    if($ARGV[$l] eq "--setup"){
	$setdir=$ARGV[l+1];
	system(sprintf("rm Installer_*"));
	$SLDP='\$LD_LIBRARY_PATH';


	system(sprintf("rm -rf $setdir \n"));
	system(sprintf("rm Installer_*"));	
	system(sprintf("mkdir $setdir \n"));
	system(sprintf("echo \"cd $setdir\">> Installer_$time"));
	system(sprintf("echo \"export SCRAM_ARCH=slc6_amd64_gcc530\">> Installer_$time"));
	system(sprintf("echo \"scram project CMSSW CMSSW_8_1_0   \">> Installer_$time"));
	system(sprintf("echo \"cd CMSSW_8_1_0/src   \">> Installer_$time"));
	system(sprintf("echo \"cmsenv   \">> Installer_$time"));
	system(sprintf("echo \"git clone https://github.com/cms-analysis/HiggsAnalysis-CombinedLimit.git HiggsAnalysis/CombinedLimit   \">> Installer_$time"));
	system(sprintf("echo \"git clone https://github.com/cms-analysis/CombineHarvester.git CombineHarvester   \">> Installer_$time"));
	system(sprintf("echo \"scram b -j8   \">> Installer_$time"));
	system(sprintf("echo \"cp ../../Example.cpp $PWD/$setdir/CMSSW_8_1_0/src/CombineHarvester/CombineTools/bin/;\">> Installer_$time"));
	printf("\n\nInstructions:");
	printf("\nTo complete this step do:  \n\n");
	printf("\n    1) source  Installer_$time \n");
    }
}
