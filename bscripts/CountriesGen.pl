use Modern::Perl;
use File::Slurp;
use Data::Dumper;
use YAML::XS qw(Load Dump);
use File::Slurp qw(read_file write_file);
use File::Copy;

my @txt = map{s/countries\///g;$_} map{s/\.txt//g;$_} map{s/"//g;$_} map{s/\s//g;$_} grep{m/=/} read_file('C:\Program Files (x86)\Steam\SteamApps\common\Victoria 2\mod\Separatism\ainputs\countries.txt');

chomp @txt;
#say foreach @txt;

my %code_country = ();
my %keymap;
foreach (@txt) {
    my ($key, $file_path) = split('=');
    $code_country{$key} = $file_path;
    $keymap{$key}=[$key];
    #say $key;
};

#print Dumper \%code_country;


{
    my $yaml = read_file('KeyMap.yml', { binmode => ':raw' });
    %keymap = %{ Load $yaml };
};

#print Dumper \%keymap;

my $indh = 'C:\Program Files (x86)\Steam\SteamApps\common\Victoria 2\mod\Separatism\ainputs\countries';
my $outdh = 'C:\Program Files (x86)\Steam\SteamApps\common\Victoria 2\mod\Separatism\common\countries';

#clone country.txt files

foreach my $key (keys %keymap) {
	say $key;
	my $countrytxt = $code_country{$key};
	say $countrytxt;
	copy( "$indh\\$countrytxt.txt", "$outdh\\$countrytxt.txt" );
	my @tags = @{$keymap{$key}};
	foreach (1..2){
		my $tag = $tags[$_];
		my $txttag = "$countrytxt$tag";
		say "$indh\\$countrytxt.txt";
		say "$outdh\\$txttag.txt";
		copy( "$indh\\$countrytxt.txt", "$outdh\\$txttag.txt" );
	}
}




