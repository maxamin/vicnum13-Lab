#!/usr/bin/perl 
use CGI ':standard' ;
use MIME::Base64 ;
$player=param('player') ;
$admin=param('admin') ;

if ($admin eq 'Y')  {
#print "Going to admin page ...... \n " ; 
$url =  $ENV{'SERVER_ADDR'};
print "Location:  http://$url/admin.html\n\n";
		}
my $guess = "" ; 
my $nc = "" ; 
while (length($guess) < 3) {
my $randnum = 0 ;
$randnum = int(rand(10)) ;
$guess .= $randnum unless ($guess =~ /$randnum/)  ; }
#  code to obfuscate  
# $guess = $guess + 9 ;  note this may change the length if < 100
$nc = encode_base64($guess); 
print header; 
print "<head><title> Let's Play Vicnum </title></head>" ;
print "<body bgcolor=white text=navy\"
 onLoad=\"document.F.userguess.focus();\">" ;
#  code to block xss  
$_ = $player ;
# code below prevents entering <> in a name
#if (/[\<\>]/) { print "<h2>invalid input - hit the back button and try again\n"; exit ;}
print "<h2>","Welcome $player - the computer has chosen a number" ; 

print <<mk
<p>
Enter your first guess and then click on the Guess button  </h2>
<form NAME="F" ACTION="vicnum2.pl" METHOD="post">
<input type="text" size=3 maxlength=3 name="userguess" >
<input type="hidden" name="player" value="$player">
<input type="hidden" name="VIEWSTATE" value="$nc">
<input type="hidden" name="oldguess">
<input TYPE="SUBMIT"  VALUE="GUESS">
<input TYPE="RESET"  VALUE="Clear">
</form>
<p><a href="/help/help1.html">HELP</a>
<p><p>
<hr size="3" color="#FF00FF">
<pre>

<h4>The Vicnum project was developed for educational purposes to demonstrate common web vulnerabilities. 

For comments please visit the <a href="http://www.owasp.org/index.php/Category:OWASP_Vicnum_Project">OWASP project page.<A>

Mordecai Kraushar

<a href="http://www.ciphertechs.com" >
<img SRC="../images/CipherTechs.jpg" align="LEFT"></a> 
<br></pre>
</body>
mk
