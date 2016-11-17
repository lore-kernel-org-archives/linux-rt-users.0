From: Piotr Gregor <piotrgregor@rsyncme.org>
Subject: Re: Ubuntu 16.04 with Intel i7-6700
Date: Thu, 17 Nov 2016 09:12:04 +0000
Message-ID: <CAK+oA4UtVdogDT4p=P4vYm1niL+69_B_yqg9rkktKhgUOXuxxQ@mail.gmail.com>
References: <CAK+oA4U8=YwZb5ewpZSDRO+FPv1EgvvbSgoumdooaunTXKsjCg@mail.gmail.com>
 <CALqGcGqifgU04OBo2win-jJRzk3VAypB-XYJ9PE=e+2jWfuJVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Christoph Mathys <eraserix@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35046 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbcKQJMF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Nov 2016 04:12:05 -0500
Received: by mail-yw0-f179.google.com with SMTP id i145so150801581ywg.2
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Nov 2016 01:12:05 -0800 (PST)
In-Reply-To: <CALqGcGqifgU04OBo2win-jJRzk3VAypB-XYJ9PE=e+2jWfuJVw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Ralf, Chris,

Many thanks for your feedback. I have done some testing. The result of
this is attached.
The testing has been done to check the Ubuntu's and Debian's
performance, tested on systems with no tweaking,
with original, distribution-shipped kernels - for a starting point.
The main conclusion is Debian's performence is better
than Ubuntu on the hardware we used for tests.

Requirement

Consider Debian as PC environment for running RT software.

Operation

Performed real time tests on

-       Ubuntu (ubuntu-16.04.1-desktop-amd64: uname =E2=80=93a =3D Linux ub=
untu1
4.4.27-rt37 #1 SMP PREEMPT RT Fri Nov 4 14:49:50 GMT 2016 x86_64
x86_64 x86_64 GNU/Linux)

-       Ubuntu Mate

-       Debian Jessie (debian-8.6.0-amd64-netinst: uname =E2=80=93a =3D Lin=
ux
debian1 3.16.0-4-amd64 #1 SMP Debian 3.16.36-1+deb8u2 (2016-10-19)
x86_64 GNU/Linux)

using rt-tests package which contains a series of C written tests to
assess the system=E2=80=99s real time performance. Test used was cyclictest
with different arguments.

Test 1. Command:

cyclictest

(thread =3D default =3D 1 per CPU, policy =3D default =3D SCHED_OTHER (non
rt), priority =3D default =3D 0, interval =3D default =3D 1000 us, use sigw=
ait
for waiting for SIGALRM + POSIX timer, l =3D max_cycles =3D default =3D
endless)

Test 2. Command:

cyclictest =E2=80=93t1 =E2=80=93p 80 =E2=80=93n =E2=80=93i 10000 =E2=80=93l=
 10000

(-t1 : 1 thread per CPU, -p 80 : raise priority of thread to 80, -n :
use nanosleep clock (wait using clock_nanosleep), -i 10000 : use 10ms
interval, -l 10000 : perform test 10 000 times)

Test 3. Command:

cyclictest =E2=80=93t1 =E2=80=93p 80 =E2=80=93i 10000 =E2=80=93l 10000

Test 4. Command:

cyclictest =E2=80=93t1 =E2=80=93p 80 =E2=80=93n

Test 5. Command:

cyclictest =E2=80=93t1 =E2=80=93p 80

Test 6. Command:

cyclictest =E2=80=93t1 =E2=80=93p 80 =E2=80=93I 33333

Recorded Max values from all tests (tables below), those values
represent maximum skew/jitter observed during the test, measured in
microseconds.

Configurations tested:

1.     Debian =E2=80=93 PHY1 : Debian on physical machine 1

2.     Ubuntu =E2=80=93 PHY1 : Ubuntu on physical machine 1

3.     Debian =E2=80=93 PHY2 : Debian on physical machine 2

4.     Debian =E2=80=93 vbPHY2 : Debian emulated by VirtualBox on PHY2

5.     Ubuntu =E2=80=93 vbPHY2 : Ubuntu emulated by VirtualBox on PHY2

6.     Debian =E2=80=93 qePHY2 : Debian emulated by Qemu on PHY2

7.     Ubuntu =E2=80=93 qePHY2: Ubuntu emulated by Qemu on PHY2

where:

PHY1 =E2=80=93 physical machine 1, poor, low-end, old server motherboard wi=
th
Intel core 2x2.13GHz, 2GB DDR2 RAM

PHY2 =E2=80=93 new laptop with Intel Core i7-6700HQ 8x2.6GHz, 8GB DDR4 RAM

Results

Virtual machines have been used and two physical machines: PHY1 and
PHY2. Virtual machines were running on VirtualBox and Qemu on PHY2 and
on VMware ESXI server. The Ubuntu virtualized on ESXI performed worst
resulting with 2516 jitter for test 1 and 237 us for test 6, so it has
been excluded from the rest of the tests under assumption ESXI
virtualization environment (in at least the form we today have
configured) is not suitable for running real time tasks. It is in line
with other experience we share with others =E2=80=93 virtualized machine is
characterized by nondeterministic real-time features, so e.g. it is
never used for media processing and if it is - then there are always
issues. There are significant differences in performance of same
system running as a host on physical machine and being virtualized =E2=80=
=93
this has been confirmed by virtualizing Debian on Debian using
VirtualBox and Qemu. For instance the result of running test 3 on same
Debian Jessie 8.6.0 gives the worst case performance of 27440us on
low-end, poor physical machine PHY1 and only 39 us on good machine
PHY2, but it exceeds 100 000 us when virtual machine is virtualized on
PHY2.

Results 1 (Ubuntu vs Debian =E2=80=93 physical on machine PHY1)

test number | Ubuntu - PHY1 : GUI + interaction | Ubuntu - PHY1 : GUI
| Debian - PHY1 : No GUI + interaction | Debian - PHY1 : No GUI
1       100000  2277    4608    1155    28956   4194    7249    235
2       51116   100     4476    18      25391   2937    63      70
3       23769   461     7779    72      27440   205     84      73
4       59210   136     339     60      11109   2282    86      84
5       57877   1641    8799    421     27739   4396    428     141
6       44050   89      3063    72      16815   83      61      82
average 56003.66667     784     4844    299.67  22908.33333     2350
 1328.5  114.17

Results 2 (Ubuntu vs Debian =E2=80=93 virtual emulated by VirtualBox on PHY=
2)
test number | Ubuntu - vbPHY2 : GUI + interaction | Ubuntu - vbPHY2 :
GUI | Debian - vbPHY2 : No GUI + interaction | vbDebian - PHY2 : No
GUI
1       >100000 >100000 >100000 >100000 >100000 >100000 >100000 >100000
2       >100000 8716    >100000 11853   77630   6970    79090   6029
3       >100000 >100000 11629   3886    >100000 >100000 64387   5778
4       >100000 >100000 >100000 5142    >100000 77558   >100000 >100000
5       >100000 >100000 >100000 >100000 >100000 6106    >100000 >100000
6       >100000 >100000 >100000 >100000 >100000 >100000 14023   14837

Results 3. (Ubuntu vs Debian =E2=80=93 virtual emulated by Qemu on PHY2)
test number | Ubuntu - qePHY2 : GUI + interaction | Ubuntu - qePHY2 :
GUI | Debian - qePHY2 : No GUI + interaction | qeDebian - PHY2 : No
GUI
1       >100000 >100000 >100000 1259    10297   4467    3184    432
2       10766   2435    3388    362     5785    481     4555    231
3       9453    4822    1541    155     3767    1233    3419    372
4       10347   4069    3527    1032    4061    6031    3099    3010
5       >100000 >100000 4586    2349    10574   1263    4864    1153
6       2601    2459    404     228     1439    225     1649    144

Results 4. Debian on physical machine PHY2
test number | Debian - PHY2 : GUI + interaction | Debian - PHY2 : GUI
| Debian - PHY2 : No GUI + interaction | Debian - PHY2 : No GUI
1       9245    2568    42      6
2       37      31      9       4
3       39      37      9       5
4       5162    26      10      8
5       7404    36      10      6
6       45      36      9       4

Conclusions

1.     Physical machine is preferred

This is visible from running Debian on PHY2 and virtualizing it on
same machine PHY2 with VirtualBox and Qemu. Measured latencies are
less than 100 for physical PHY2 but exceed 100 000 when system is
virtualized. This result is clear and it was expected.

2.     Debian is more stable in terms of performance =E2=80=93 Debian=E2=80=
=99s jitter
deviation is lower on average

Debian system seems to be more stable than Ubuntu =E2=80=93 more
deterministic, the argument backing up this thesis is observed smaller
impact of the interactiveness on the performance. This is confirmed by
linear regression coefficient for Debian and Ubuntu GUI+I(GUI) and
NoGUI+i(NoGUI) sets for physical machines: Debian =E2=80=93 PHY1, Ubuntu =
=E2=80=93
PHY1.

Deb (GUI)               Ub (GUI)
6.89662835      0       43.1571039      0
1.97991757      #N/A    12.9723939      #N/A
0.70817087      14111.2517      0.68882013      36980.534
12.1333138      5       11.0678772      5
2416075521      995637123.1     1.5136E+10      6837799486

Deb (No GUI + I, test 1 skipped)        Ub (No GUI + I, test 1 skipped)
1.89373434      0       23.9431899      0
0.52248583      #N/A    8.67572425      #N/A
0.76658398      109.4604688     0.65566069      3796.88589
13.1367846      4       7.61644907      4
157399.623      47926.37694     109801338       57665369.8

When system runs with GUI the interactiveness slows the responsiveness
by a factor of about 6.89 for Debian and 43 for Ubuntu. It is about
1.89 and 24 respectively if no GUI is running.

This is also confirmed by virtualizing systems on PHY2 in Qemu: Debian
=E2=80=93 qePHY2 performs better than Ubuntu =E2=80=93 qePHY2 in terms of j=
itter=E2=80=99s
deviation.

3.     Ubuntu gets less responsive (lower performance) when same load
is applied =E2=80=93 Debian=E2=80=99s jitter level is lower on average

This can be seen based on PHY1 tests, i.e. for Debian and Ubuntu
running on PHY1. GUI+interactions jumps at levels of about 56000 for
Ubuntu and 22900 for Debian. The same applies for NO-GUI+interactions
columns: it is 4800 and 1328 for Ubuntu and Debian. The interactive
load applied was clicking in browser to start video streaming from
youtube if running with GUI or by switching terminals and logging
in/out (ctrl+alt+F1/2/3/4/5/6/7) if no GUI.

This is also confirmed by virtualizing systems on PHY2 in Qemu: Debian
=E2=80=93 qePHY2 performs better than Ubuntu =E2=80=93 qePHY2 in terms of j=
itter=E2=80=99s
level.

4.     The hardware matters

All measured latencies are much smaller for PHY2 than PHY 1 running
Debian. If there is no GUI then PHY2 is about 10 times better on
average, if there is GUI then it is faster by more than this on
average.

5.     Spikes happen, GUI kills RT performance

Even when system is running on good physical machine, PHY2, then
extremely huge values of jitter happen and they happen more often than
one would prefer. They are much more likely to happen if GUI is
running. Non GUI system should be considered as RT system.

6.     Qemu virtualizes better than VirtualBox

On hardware tested, Ubuntu - qePHY2 performs better than Ubuntu -
vbPHY2 and Debian - qePHY2 wins over Debian - vbPHY2. In case of
Ubuntu we observed many extreme values (spikes) >100000 when running
on VirtualBox: Ubuntu - vbPHY2. There was less of them for Ubuntu -
qePHY2. There was much less such spikes for Debian =E2=80=93 vbPHY2 and we
observed no such spikes for Debian running on Qemu: Debian =E2=80=93 qePHY2=
.

cheers,
Piotr
