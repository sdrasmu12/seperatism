use Modern::Perl;
use File::Slurp;
use Data::Dumper;
use YAML::XS qw(Load Dump);
use File::Slurp qw(read_file write_file);

my @txt = map{s/\s//g;$_} grep{m/=/} read_file('C:\Program Files (x86)\Steam\SteamApps\common\Victoria 2\mod\Separatism\ainputs\countries.txt');
chomp @txt;
#say foreach @txt;

my %code_country = ();
my %keymap;
my %keylist;
foreach (@txt) {
    my ($key, $file_path) = split('=');
    $code_country{$key} = $file_path;
    $keymap{$key}=[$key];
	$keylist{$key}=[0];
    #say $key;
}

sub char_rand {
    return chr(int rand(26)+shift);
}

my $offset = ord('A');
my @keys = keys %code_country;


foreach my $key (keys %code_country){
    my $first2 = substr($key,0,2);
    my $newkey1 = $first2 . char_rand($offset);
    while(exists($keylist{$newkey1})){
        $newkey1 = $first2 . char_rand($offset);
    }
	$keylist{$newkey1}=[0];
    my $newkey2 = $first2 . char_rand($offset);
    while(exists($keylist{$newkey2})){
        $newkey2 = $first2 . char_rand($offset);
    }
    push @{$keymap{$key}}, $newkey1 ;
    push @{$keymap{$key}}, $newkey2 ;
	$keylist{$newkey2}=[0];
}

#print Dumper \%keymap;

# Print structure to file
#open my $out, '>', 'C:\Program Files (x86)\Steam\SteamApps\common\Victoria 2\mod\Separatism\bscripts\Tag_Map' or die $!;
#print {$out} Dumper \%keymap;
#close $out;

my %hash;
{
    my $yaml = Dump \%keymap;
    write_file('KeyMap.yml', { binmode => ':raw' }, $yaml);
}
{
    my $yaml = read_file('KeyMap.yml', { binmode => ':raw' });
    %hash = %{ Load $yaml };
}
	
print Dumper \%hash;
say "If there is a hash above this it worked";

