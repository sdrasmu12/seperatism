use Modern::Perl;
use File::Slurp;
use Data::Dumper;
use YAML::XS qw(Load Dump);
use File::Slurp qw(read_file write_file);
use File::Copy;


my %keymap;
{
    my $yaml = read_file('KeyMap.yml', { binmode => ':raw' });
    %keymap = %{ Load $yaml };
};

#print Dumper \%keymap;

my $indh = 'C:\Program Files (x86)\Steam\SteamApps\common\Victoria 2\mod\Separatism\ainputs\flags';
my $outdh = 'C:\Program Files (x86)\Steam\SteamApps\common\Victoria 2\mod\Separatism\gfx\flags';

opendir(DIR, $indh) or die $!;
my @flags;
@flags = map{s/\.tga//g;$_} readdir(DIR);

my %flaglist;
foreach my $flag (@flags) {
    $flaglist{$flag}=[0];
};

foreach my $key (keys %keymap) {
	#say $key;
	my @tags = @{$keymap{$key}};
	foreach my $tag (@tags){
		say $key . $tag;
		copy( "$indh\\$key.tga", "$outdh\\$tag.tga" );
		copy( "$indh\\$key\_communist.tga", "$outdh\\$tag\_communist.tga");
		copy( "$indh\\$key\_fascist.tga", "$outdh\\$tag\_fascist.tga" );
		copy( "$indh\\$key\_monarchy.tga", "$outdh\\$tag\_monarchy.tga" );
		copy( "$indh\\$key\_republic.tga", "$outdh\\$tag\_republic.tga" );
	}
}