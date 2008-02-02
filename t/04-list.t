use strict;
use t::TestTextTrac;

run_tests;

__DATA__
### ul node another pattern 1
--- input
 * 1
 * 2
   * 3
   * 4
     * 5
     * 6
 * 7
 * 8
--- expected
<ul><li>1</li>
<li>2</li>
<ul><li>3</li>
<li>4</li>
<ul><li>5</li>
<li>6</li>
</ul></ul><li>7</li>
<li>8</li></ul>

### ul node another pattern 2
--- input
  * 1
  * 2
    * 3
    * 4
      * 5
      * 6
  * 7
  * 8
--- expected
<ul><li>1</li>
<li>2</li>
<ul><li>3</li>
<li>4</li>
<ul><li>5</li>
<li>6</li>
</ul></ul><li>7</li>
<li>8</li></ul>

### ol node another pattern 1
--- input
 a. 1
 a. 2
   a. 3
   a. 4
     a. 5
     a. 6
 a. 7
 a. 8
--- expected
<ol class="loweralpha"><li>1</li>
<li>2</li>
<ol class="loweralpha"><li>3</li>
<li>4</li>
<ol class="loweralpha"><li>5</li>
<li>6</li>
</ol></ol><li>7</li>
<li>8</li></ol>

### ol node another pattern 2
--- input
  a. 1
  a. 2
    a. 3
    a. 4
      a. 5
      a. 6
  a. 7
  a. 8
--- expected
<ol class="loweralpha"><li>1</li>
<li>2</li>
<ol class="loweralpha"><li>3</li>
<li>4</li>
<ol class="loweralpha"><li>5</li>
<li>6</li>
</ol></ol><li>7</li>
<li>8</li></ol>

### 2 set of ul nodes
--- input
 * list 1-1
 * list 1-2
 * list 1-3

 * list 2-1
 * list 2-2
 * list 2-3
--- expected
<ul><li>list 1-1</li>
<li>list 1-2</li>
<li>list 1-3</li></ul>
<ul><li>list 2-1</li>
<li>list 2-2</li>
<li>list 2-3</li></ul>

### 2 set of ol nodes
--- input
 a. list 1-1
 a. list 1-2
 a. list 1-3

 a. list 2-1
 a. list 2-2
 a. list 2-3
--- expected
<ol class="loweralpha"><li>list 1-1</li>
<li>list 1-2</li>
<li>list 1-3</li></ol>
<ol class="loweralpha"><li>list 2-1</li>
<li>list 2-2</li>
<li>list 2-3</li></ol>
