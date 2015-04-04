use strict;
use warnings;
use t::TestTextTrac;

run_tests;

__DATA__

### regression test 1
--- input
[http://shibuya.pm.org/blosxom/techtalks/200610.html Shibuya.pm �ƥ��˥���ȡ��� #7]
--- expected
<p>
<a class="ext-link" href="http://shibuya.pm.org/blosxom/techtalks/200610.html"><span class="icon"></span>Shibuya.pm �ƥ��˥���ȡ��� #7</a>
</p>
