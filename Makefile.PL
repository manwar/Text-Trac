use inc::Module::Install;

name('Text-Trac');
all_from('lib/Text/Trac.pm');
license 'perl';

requires('Test::Base');
requires('UNIVERSAL::require');
requires('Class::Accessor::Fast');
requires('Class::Data::Inheritable');
requires('Tie::IxHash');
requires('List::MoreUtils');
requires('HTML::Entities');

no_index( package => 'TestMacro' );

auto_include;
auto_install;

repository 'https://github.com/szabgab/Text-Trac';

WriteAll;
