From: "Cal Leeming [Simplicity Media Ltd]" <cal.leeming@simplicitymedialtd.co.uk>
Subject: Re: cgroup OOM killer loop causes system to lockup (possible fix
 included)
Date: Mon, 30 May 2011 01:24:05 +0100
Message-ID: <4DE2E3A5.4060208@simplicitymedialtd.co.uk>
References: <4DE2CB80.8040101@simplicitymedialtd.co.uk>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------070507050903020403090007"
To: debian-kernel@lists.debian.org, debian-user@lists.debian.org,
 linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
In-Reply-To: <4DE2CB80.8040101@simplicitymedialtd.co.uk>
Resent-Message-ID: <kc9eNtMhmbJ.A.11B.-Ou4NB@liszt>
List-URL: <http://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------070507050903020403090007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Another quick update on this...

Something really really really strange has happened this time.. I just 
did a completely fresh re-install (exactly like last time) and the 
problem went away.

So, I'm going to build up the lxc / kernel support step by step (and 
check for the oom_adj problem after each change) and will report back 
once I've found the step it kicks in at.

Hopefully, my hours of frustration will prevent someone else from going 
through the same thing :/

Cal

On 29/05/2011 23:41, Cal Leeming [Simplicity Media Ltd] wrote:
> After submitting this problem to Kernel mailing list, I found a 
> strange (and even more curious problem).
>
> I attempted to run both kernels on two seperate installs of Debian 
> (both 6.0), but slightly different in packages.. One install did not 
> have the OOM problem, yet the other one did.. And they both ran the 
> same kernel, the same LXC container etc..
>
> I have a feeling this may be a Debian bug..? Further to back up these 
> claims:
>
> Working server:
> root@courtney.internal [/mnt/encstore/lxc/github01.rootfs] > for x in 
> `find /proc -iname 'oom_adj' | xargs grep "\-17"  | awk -F '/' '{print 
> $3}'` ; do ps -p $x u --no-headers ; done
> grep: /proc/3090/task/3090/oom_adj: No such file or directory
> grep: /proc/3090/oom_adj: No such file or directory
> root       804  0.0  0.0  16992  1112 ?        S<s  Mar17   0:00 udevd 
> --daemon
> root       804  0.0  0.0  16992  1112 ?        S<s  Mar17   0:00 udevd 
> --daemon
> root     25536  0.0  0.0  49164  1100 ?        Ss   Apr05   0:00 
> /usr/sbin/sshd
> root     25536  0.0  0.0  49164  1100 ?        Ss   Apr05   0:00 
> /usr/sbin/sshd
> root     32173  0.0  0.0  16988   960 ?        S<   21:53   0:00 udevd 
> --daemon
> root     32173  0.0  0.0  16988   960 ?        S<   21:53   0:00 udevd 
> --daemon
> root     32174  0.0  0.0  16988   916 ?        S<   21:53   0:00 udevd 
> --daemon
> root     32174  0.0  0.0  16988   916 ?        S<   21:53   0:00 udevd 
> --daemon
>
> Broken server:
>  root@vicky [/var] > for x in `find /proc -iname 'oom_adj' | xargs 
> grep "\-17"  | awk -F '/' '{print $3}'` ; do ps -p $x u --no-headers ; 
> done
> grep: /proc/4597/task/4597/oom_adj: No such file or directory
> grep: /proc/4597/oom_adj: No such file or directory
> root       889  0.0  0.0  16788   860 ?        S<s  09:10   0:00 udevd 
> --daemon
> root       889  0.0  0.0  16788   860 ?        S<s  09:10   0:00 udevd 
> --daemon
> root      1104  0.0  0.0  17228  1200 ?        S<   09:10   0:00 udevd 
> --daemon
> root      1104  0.0  0.0  17228  1200 ?        S<   09:10   0:00 udevd 
> --daemon
> root      1141  0.0  0.0  17120  1128 ?        S<   09:10   0:00 udevd 
> --daemon
> root      1141  0.0  0.0  17120  1128 ?        S<   09:10   0:00 udevd 
> --daemon
> root      2745  0.0  0.0  49168  1168 ?        Ss   09:10   0:00 
> /usr/sbin/sshd
> root      2745  0.0  0.0  49168  1168 ?        Ss   09:10   0:00 
> /usr/sbin/sshd
> root      2750  0.0  0.0  76672  3360 ?        Ss   09:11   0:00 sshd: 
> foxx [priv]
> root      2750  0.0  0.0  76672  3360 ?        Ss   09:11   0:00 sshd: 
> foxx [priv]
> foxx      2754  0.0  0.0  76672  1636 ?        S    09:11   0:00 sshd: 
> foxx@pts/0
> foxx      2754  0.0  0.0  76672  1636 ?        S    09:11   0:00 sshd: 
> foxx@pts/0
> foxx      2755  0.0  0.0 123984  1984 pts/0    Ss   09:11   0:00 -bash
> foxx      2755  0.0  0.0 123984  1984 pts/0    Ss   09:11   0:00 -bash
> root      2760  0.0  0.0 127176  1244 pts/0    S    09:11   0:00 sudo su
> root      2760  0.0  0.0 127176  1244 pts/0    S    09:11   0:00 sudo su
> root      2761  0.0  0.0 147820  1328 pts/0    S    09:11   0:00 su
> root      2761  0.0  0.0 147820  1328 pts/0    S    09:11   0:00 su
> root      2762  0.0  0.0 124084  2152 pts/0    S    09:11   0:00 bash
> root      2762  0.0  0.0 124084  2152 pts/0    S    09:11   0:00 bash
>
> Notice how the sshd user instances on the broken server are set to 
> -17, yet the sshd user instances on the working server, are not :S
>
> Any input from anyone on the below would be VERY much appreciated.
>
> Cal
>
> -------- Original Message --------
> Subject: 	Re: Fwd: cgroup OOM killer loop causes system to lockup 
> (possible fix included)
> Date: 	Sun, 29 May 2011 23:24:07 +0100
> From: 	Cal Leeming [Simplicity Media Ltd] 
> <cal.leeming@simplicitymedialtd.co.uk>
> Organization: 	Simplicity Media Ltd
> To: 	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
>
>
>
> Some further logs:
> ./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.369927] redis-server
> invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
> ./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.369939]
> [<ffffffff810b12b7>] ? oom_kill_process+0x82/0x283
> ./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.399285] redis-server
> invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
> ./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.399296]
> [<ffffffff810b12b7>] ? oom_kill_process+0x82/0x283
> ./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.428690] redis-server
> invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
> ./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.428702]
> [<ffffffff810b12b7>] ? oom_kill_process+0x82/0x283
> ./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.487696] redis-server
> invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
> ./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.487708]
> [<ffffffff810b12b7>] ? oom_kill_process+0x82/0x283
> ./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.517023] redis-server
> invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
> ./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.517035]
> [<ffffffff810b12b7>] ? oom_kill_process+0x82/0x283
> ./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.546379] redis-server
> invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
> ./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.546391]
> [<ffffffff810b12b7>] ? oom_kill_process+0x82/0x283
> ./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.310789] redis-server
> invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
> ./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.310804]
> [<ffffffff810b12b7>] ? oom_kill_process+0x82/0x283
> ./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.369918] redis-server
> invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
> ./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.369930]
> [<ffffffff810b12b7>] ? oom_kill_process+0x82/0x283
> ./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.399284] redis-server
> invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
> ./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.399296]
> [<ffffffff810b12b7>] ? oom_kill_process+0x82/0x283
> ./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.433634] redis-server
> invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
> ./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.433648]
> [<ffffffff810b12b7>] ? oom_kill_process+0x82/0x283
> ./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.463947] redis-server
> invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
> ./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.463959]
> [<ffffffff810b12b7>] ? oom_kill_process+0x82/0x283
> ./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.493439] redis-server
> invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
> ./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.493451]
> [<ffffffff810b12b7>] ? oom_kill_process+0x82/0x283
>
>
> On 29/05/2011 22:50, Cal Leeming [Simplicity Media Ltd] wrote:
> >   First of all, my apologies if I have submitted this problem to the
> >  wrong place, spent 20 minutes trying to figure out where it needs to
> >  be sent, and was still none the wiser.
> >
> >  The problem is related to applying memory limitations within a cgroup.
> >  If the OOM killer kicks in, it gets stuck in a loop where it tries to
> >  kill a process which has an oom_adj of -17. This causes an infinite
> >  loop, which in turn locks up the system.
> >
> >  May 30 03:13:08 vicky kernel: [ 1578.117055] Memory cgroup out of
> >  memory: kill process 6016 (java) score 0 or a child
> >  May 30 03:13:08 vicky kernel: [ 1578.117154] Memory cgroup out of
> >  memory: kill process 6016 (java) score 0 or a child
> >  May 30 03:13:08 vicky kernel: [ 1578.117248] Memory cgroup out of
> >  memory: kill process 6016 (java) score 0 or a child
> >  May 30 03:13:08 vicky kernel: [ 1578.117343] Memory cgroup out of
> >  memory: kill process 6016 (java) score 0 or a child
> >  May 30 03:13:08 vicky kernel: [ 1578.117441] Memory cgroup out of
> >  memory: kill process 6016 (java) score 0 or a child
> >
> >
> >   root@vicky [/home/foxx]>  uname -a
> >  Linux vicky 2.6.32.41-grsec #3 SMP Mon May 30 02:34:43 BST 2011 x86_64
> >  GNU/Linux
> >  (this happens on both the grsec patched and non patched 2.6.32.41 kernel)
> >
> >  When this is encountered, the memory usage across the whole server is
> >  still within limits (not even hitting swap).
> >
> >  The memory configuration for the cgroup/lxc is:
> >  lxc.cgroup.memory.limit_in_bytes = 3000M
> >  lxc.cgroup.memory.memsw.limit_in_bytes = 3128M
> >
> >  Now, what is even more strange, is that when running under the
> >  2.6.32.28 kernel (both patched and unpatched), this problem doesn't
> >  happen. However, there is a slight difference between the two kernels.
> >  The 2.6.32.28 kernel gives a default of 0 in the /proc/X/oom_adj,
> >  where as the 2.6.32.41 gives a default of -17. I suspect this is the
> >  root cause of why it's showing in the later kernel, but not the earlier.
> >
> >  To test this theory, I started up the lxc on both servers, and then
> >  ran a one liner which showed me all the processes with an oom_adj of -17:
> >
> >  (the below is the older/working kernel)
> >  root@courtney.internal  [/mnt/encstore/lxc]>  uname -a
> >  Linux courtney.internal 2.6.32.28-grsec #3 SMP Fri Feb 18 16:09:07 GMT
> >  2011 x86_64 GNU/Linux
> >  root@courtney.internal  [/mnt/encstore/lxc]>  for x in `find /proc
> >  -iname 'oom_adj' | xargs grep "\-17"  | awk -F '/' '{print $3}'` ; do
> >  ps -p $x --no-headers ; done
> >  grep: /proc/1411/task/1411/oom_adj: No such file or directory
> >  grep: /proc/1411/oom_adj: No such file or directory
> >    804 ?        00:00:00 udevd
> >    804 ?        00:00:00 udevd
> >  25536 ?        00:00:00 sshd
> >  25536 ?        00:00:00 sshd
> >  31861 ?        00:00:00 sshd
> >  31861 ?        00:00:00 sshd
> >  32173 ?        00:00:00 udevd
> >  32173 ?        00:00:00 udevd
> >  32174 ?        00:00:00 udevd
> >  32174 ?        00:00:00 udevd
> >
> >  (the below is the newer/broken kernel)
> >   root@vicky [/mnt/encstore/ssd/kernel/linux-2.6.32.41]>  uname -a
> >  Linux vicky 2.6.32.41-grsec #3 SMP Mon May 30 02:34:43 BST 2011 x86_64
> >  GNU/Linux
> >   root@vicky [/mnt/encstore/ssd/kernel/linux-2.6.32.41]>  for x in
> >  `find /proc -iname 'oom_adj' | xargs grep "\-17"  | awk -F '/' '{print
> >  $3}'` ; do ps -p $x --no-headers ; done
> >  grep: /proc/3118/task/3118/oom_adj: No such file or directory
> >  grep: /proc/3118/oom_adj: No such file or directory
> >    895 ?        00:00:00 udevd
> >    895 ?        00:00:00 udevd
> >   1091 ?        00:00:00 udevd
> >   1091 ?        00:00:00 udevd
> >   1092 ?        00:00:00 udevd
> >   1092 ?        00:00:00 udevd
> >   2596 ?        00:00:00 sshd
> >   2596 ?        00:00:00 sshd
> >   2608 ?        00:00:00 sshd
> >   2608 ?        00:00:00 sshd
> >   2613 ?        00:00:00 sshd
> >   2613 ?        00:00:00 sshd
> >   2614 pts/0    00:00:00 bash
> >   2614 pts/0    00:00:00 bash
> >   2620 pts/0    00:00:00 sudo
> >   2620 pts/0    00:00:00 sudo
> >   2621 pts/0    00:00:00 su
> >   2621 pts/0    00:00:00 su
> >   2622 pts/0    00:00:00 bash
> >   2622 pts/0    00:00:00 bash
> >   2685 ?        00:00:00 lxc-start
> >   2685 ?        00:00:00 lxc-start
> >   2699 ?        00:00:00 init
> >   2699 ?        00:00:00 init
> >   2939 ?        00:00:00 rc
> >   2939 ?        00:00:00 rc
> >   2942 ?        00:00:00 startpar
> >   2942 ?        00:00:00 startpar
> >   2964 ?        00:00:00 rsyslogd
> >   2964 ?        00:00:00 rsyslogd
> >   2964 ?        00:00:00 rsyslogd
> >   2964 ?        00:00:00 rsyslogd
> >   2980 ?        00:00:00 startpar
> >   2980 ?        00:00:00 startpar
> >   2981 ?        00:00:00 ctlscript.sh
> >   2981 ?        00:00:00 ctlscript.sh
> >   3016 ?        00:00:00 cron
> >   3016 ?        00:00:00 cron
> >   3025 ?        00:00:00 mysqld_safe
> >   3025 ?        00:00:00 mysqld_safe
> >   3032 ?        00:00:00 sshd
> >   3032 ?        00:00:00 sshd
> >   3097 ?        00:00:00 mysqld.bin
> >   3097 ?        00:00:00 mysqld.bin
> >   3097 ?        00:00:00 mysqld.bin
> >   3097 ?        00:00:00 mysqld.bin
> >   3097 ?        00:00:00 mysqld.bin
> >   3097 ?        00:00:00 mysqld.bin
> >   3097 ?        00:00:00 mysqld.bin
> >   3097 ?        00:00:00 mysqld.bin
> >   3097 ?        00:00:00 mysqld.bin
> >   3097 ?        00:00:00 mysqld.bin
> >   3113 ?        00:00:00 ctl.sh
> >   3113 ?        00:00:00 ctl.sh
> >   3115 ?        00:00:00 sleep
> >   3115 ?        00:00:00 sleep
> >   3116 ?        00:00:00 .memcached.bin
> >   3116 ?        00:00:00 .memcached.bin
> >
> >
> >  As you can see, it is clear that the newer kernel is setting -17 by
> >  default, which in turn is causing the OOM killer loop.
> >
> >  So I began to try and find what may have caused this problem by
> >  comparing the two sources...
> >
> >  I checked the code for all references to 'oom_adj' and 'oom_adjust' in
> >  both code sets, but found no obvious differences:
> >  grep -R -e oom_adjust -e oom_adj . | sort | grep -R -e oom_adjust -e
> >  oom_adj
> >
> >  Then I checked for references to "-17" in all .c and .h files, and
> >  found a couple of matches, but only one obvious one:
> >  grep -R "\-17" . | grep -e ".c:" -e ".h:" -e "\-17" | wc -l
> >  ./include/linux/oom.h:#define OOM_DISABLE (-17)
> >
> >  But again, a search for OOM_DISABLE came up with nothing obvious...
> >
> >  In a last ditch attempt, I did a search for all references to 'oom'
> >  (case-insensitive) in both code bases, then compared the two:
> >   root@annabelle [~/lol/linux-2.6.32.28]>  grep -i -R "oom" . | sort -n
> >  >  /tmp/annabelle.oom_adj
> >   root@vicky [/mnt/encstore/ssd/kernel/linux-2.6.32.41]>  grep -i -R
> >  "oom" . | sort -n>  /tmp/vicky.oom_adj
> >
> >  and this brought back (yet again) nothing obvious..
> >
> >
> >   root@vicky [/mnt/encstore/ssd/kernel/linux-2.6.32.41]>  md5sum
> >  ./include/linux/oom.h
> >  2a32622f6cd38299fc2801d10a9a3ea8  ./include/linux/oom.h
> >
> >   root@annabelle [~/lol/linux-2.6.32.28]>  md5sum ./include/linux/oom.h
> >  2a32622f6cd38299fc2801d10a9a3ea8  ./include/linux/oom.h
> >
> >   root@vicky [/mnt/encstore/ssd/kernel/linux-2.6.32.41]>  md5sum
> >  ./mm/oom_kill.c
> >  1ef2c2bec19868d13ec66ec22033f10a  ./mm/oom_kill.c
> >
> >   root@annabelle [~/lol/linux-2.6.32.28]>  md5sum ./mm/oom_kill.c
> >  1ef2c2bec19868d13ec66ec22033f10a  ./mm/oom_kill.c
> >
> >
> >
> >  Could anyone please shed some light as to why the default oom_adj is
> >  set to -17 now (and where it is actually set)? From what I can tell,
> >  the fix for this issue will either be:
> >
> >    1. Allow OOM killer to override the decision of ignoring oom_adj ==
> >       -17 if an unrecoverable loop is encountered.
> >    2. Change the default back to 0.
> >
> >  Again, my apologies if this bug report is slightly unorthodox, or
> >  doesn't follow usual procedure etc. I can assure you I have tried my
> >  absolute best to give all the necessary information though.
> >
> >  Cal
> >
>


--------------070507050903020403090007
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    Another quick update on this...<br>
    <br>
    Something really really really strange has happened this time.. I
    just did a completely fresh re-install (exactly like last time) and
    the problem went away.<br>
    <br>
    So, I'm going to build up the lxc / kernel support step by step (and
    check for the oom_adj problem after each change) and will report
    back once I've found the step it kicks in at.<br>
    <br>
    Hopefully, my hours of frustration will prevent someone else from
    going through the same thing :/<br>
    <br>
    Cal<br>
    <br>
    On 29/05/2011 23:41, Cal Leeming [Simplicity Media Ltd] wrote:
    <blockquote cite="mid:4DE2CB80.8040101@simplicitymedialtd.co.uk"
      type="cite">
      <meta http-equiv="content-type" content="text/html;
        charset=ISO-8859-1">
      After submitting this problem to Kernel mailing list, I found a
      strange (and even more curious problem).<br>
      <br>
      I attempted to run both kernels on two seperate installs of Debian
      (both 6.0), but slightly different in packages.. One install did
      not have the OOM problem, yet the other one did.. And they both
      ran the same kernel, the same LXC container etc..<br>
      <br>
      I have a feeling this may be a Debian bug..? Further to back up
      these claims:<br>
      <br>
      Working server:<br>
      &nbsp;<a moz-do-not-send="true" class="moz-txt-link-abbreviated"
        href="mailto:root@courtney.internal">root@courtney.internal</a>
      [/mnt/encstore/lxc/github01.rootfs] &gt; for x in `find /proc
      -iname 'oom_adj' | xargs grep "\-17"&nbsp; | awk -F '/' '{print $3}'` ;
      do ps -p $x u --no-headers ; done<br>
      grep: /proc/3090/task/3090/oom_adj: No such file or directory<br>
      grep: /proc/3090/oom_adj: No such file or directory<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 804&nbsp; 0.0&nbsp; 0.0&nbsp; 16992&nbsp; 1112 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&lt;s&nbsp; Mar17&nbsp;&nbsp;
      0:00 udevd --daemon<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 804&nbsp; 0.0&nbsp; 0.0&nbsp; 16992&nbsp; 1112 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&lt;s&nbsp; Mar17&nbsp;&nbsp;
      0:00 udevd --daemon<br>
      root&nbsp;&nbsp;&nbsp;&nbsp; 25536&nbsp; 0.0&nbsp; 0.0&nbsp; 49164&nbsp; 1100 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ss&nbsp;&nbsp; Apr05&nbsp;&nbsp; 0:00
      /usr/sbin/sshd<br>
      root&nbsp;&nbsp;&nbsp;&nbsp; 25536&nbsp; 0.0&nbsp; 0.0&nbsp; 49164&nbsp; 1100 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ss&nbsp;&nbsp; Apr05&nbsp;&nbsp; 0:00
      /usr/sbin/sshd<br>
      root&nbsp;&nbsp;&nbsp;&nbsp; 32173&nbsp; 0.0&nbsp; 0.0&nbsp; 16988&nbsp;&nbsp; 960 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&lt;&nbsp;&nbsp; 21:53&nbsp;&nbsp;
      0:00 udevd --daemon<br>
      root&nbsp;&nbsp;&nbsp;&nbsp; 32173&nbsp; 0.0&nbsp; 0.0&nbsp; 16988&nbsp;&nbsp; 960 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&lt;&nbsp;&nbsp; 21:53&nbsp;&nbsp;
      0:00 udevd --daemon<br>
      root&nbsp;&nbsp;&nbsp;&nbsp; 32174&nbsp; 0.0&nbsp; 0.0&nbsp; 16988&nbsp;&nbsp; 916 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&lt;&nbsp;&nbsp; 21:53&nbsp;&nbsp;
      0:00 udevd --daemon<br>
      root&nbsp;&nbsp;&nbsp;&nbsp; 32174&nbsp; 0.0&nbsp; 0.0&nbsp; 16988&nbsp;&nbsp; 916 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&lt;&nbsp;&nbsp; 21:53&nbsp;&nbsp;
      0:00 udevd --daemon<br>
      <br>
      Broken server:<br>
      &nbsp;root@vicky [/var] &gt; for x in `find /proc -iname 'oom_adj' |
      xargs grep "\-17"&nbsp; | awk -F '/' '{print $3}'` ; do ps -p $x u
      --no-headers ; done<br>
      grep: /proc/4597/task/4597/oom_adj: No such file or directory<br>
      grep: /proc/4597/oom_adj: No such file or directory<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 889&nbsp; 0.0&nbsp; 0.0&nbsp; 16788&nbsp;&nbsp; 860 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&lt;s&nbsp; 09:10&nbsp;&nbsp;
      0:00 udevd --daemon<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 889&nbsp; 0.0&nbsp; 0.0&nbsp; 16788&nbsp;&nbsp; 860 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&lt;s&nbsp; 09:10&nbsp;&nbsp;
      0:00 udevd --daemon<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1104&nbsp; 0.0&nbsp; 0.0&nbsp; 17228&nbsp; 1200 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&lt;&nbsp;&nbsp; 09:10&nbsp;&nbsp;
      0:00 udevd --daemon<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1104&nbsp; 0.0&nbsp; 0.0&nbsp; 17228&nbsp; 1200 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&lt;&nbsp;&nbsp; 09:10&nbsp;&nbsp;
      0:00 udevd --daemon<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1141&nbsp; 0.0&nbsp; 0.0&nbsp; 17120&nbsp; 1128 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&lt;&nbsp;&nbsp; 09:10&nbsp;&nbsp;
      0:00 udevd --daemon<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1141&nbsp; 0.0&nbsp; 0.0&nbsp; 17120&nbsp; 1128 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&lt;&nbsp;&nbsp; 09:10&nbsp;&nbsp;
      0:00 udevd --daemon<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2745&nbsp; 0.0&nbsp; 0.0&nbsp; 49168&nbsp; 1168 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ss&nbsp;&nbsp; 09:10&nbsp;&nbsp; 0:00
      /usr/sbin/sshd<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2745&nbsp; 0.0&nbsp; 0.0&nbsp; 49168&nbsp; 1168 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ss&nbsp;&nbsp; 09:10&nbsp;&nbsp; 0:00
      /usr/sbin/sshd<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2750&nbsp; 0.0&nbsp; 0.0&nbsp; 76672&nbsp; 3360 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ss&nbsp;&nbsp; 09:11&nbsp;&nbsp; 0:00
      sshd: foxx [priv]<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2750&nbsp; 0.0&nbsp; 0.0&nbsp; 76672&nbsp; 3360 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ss&nbsp;&nbsp; 09:11&nbsp;&nbsp; 0:00
      sshd: foxx [priv]<br>
      foxx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2754&nbsp; 0.0&nbsp; 0.0&nbsp; 76672&nbsp; 1636 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; 09:11&nbsp;&nbsp; 0:00
      sshd: foxx@pts/0<br>
      foxx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2754&nbsp; 0.0&nbsp; 0.0&nbsp; 76672&nbsp; 1636 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; 09:11&nbsp;&nbsp; 0:00
      sshd: foxx@pts/0<br>
      foxx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2755&nbsp; 0.0&nbsp; 0.0 123984&nbsp; 1984 pts/0&nbsp;&nbsp;&nbsp; Ss&nbsp;&nbsp; 09:11&nbsp;&nbsp; 0:00
      -bash<br>
      foxx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2755&nbsp; 0.0&nbsp; 0.0 123984&nbsp; 1984 pts/0&nbsp;&nbsp;&nbsp; Ss&nbsp;&nbsp; 09:11&nbsp;&nbsp; 0:00
      -bash<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2760&nbsp; 0.0&nbsp; 0.0 127176&nbsp; 1244 pts/0&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; 09:11&nbsp;&nbsp; 0:00
      sudo su<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2760&nbsp; 0.0&nbsp; 0.0 127176&nbsp; 1244 pts/0&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; 09:11&nbsp;&nbsp; 0:00
      sudo su<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2761&nbsp; 0.0&nbsp; 0.0 147820&nbsp; 1328 pts/0&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; 09:11&nbsp;&nbsp; 0:00
      su<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2761&nbsp; 0.0&nbsp; 0.0 147820&nbsp; 1328 pts/0&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; 09:11&nbsp;&nbsp; 0:00
      su<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2762&nbsp; 0.0&nbsp; 0.0 124084&nbsp; 2152 pts/0&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; 09:11&nbsp;&nbsp; 0:00
      bash<br>
      root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2762&nbsp; 0.0&nbsp; 0.0 124084&nbsp; 2152 pts/0&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; 09:11&nbsp;&nbsp; 0:00
      bash<br>
      <br>
      Notice how the sshd user instances on the broken server are set to
      -17, yet the sshd user instances on the working server, are not :S<br>
      <br>
      Any input from anyone on the below would be VERY much appreciated.<br>
      <br>
      Cal<br>
      <br>
      -------- Original Message --------
      <table class="moz-email-headers-table" border="0" cellpadding="0"
        cellspacing="0">
        <tbody>
          <tr>
            <th align="RIGHT" nowrap="nowrap" valign="BASELINE">Subject:
            </th>
            <td>Re: Fwd: cgroup OOM killer loop causes system to lockup
              (possible fix included)</td>
          </tr>
          <tr>
            <th align="RIGHT" nowrap="nowrap" valign="BASELINE">Date: </th>
            <td>Sun, 29 May 2011 23:24:07 +0100</td>
          </tr>
          <tr>
            <th align="RIGHT" nowrap="nowrap" valign="BASELINE">From: </th>
            <td>Cal Leeming [Simplicity Media Ltd] <a
                moz-do-not-send="true" class="moz-txt-link-rfc2396E"
                href="mailto:cal.leeming@simplicitymedialtd.co.uk">&lt;cal.leeming@simplicitymedialtd.co.uk&gt;</a></td>
          </tr>
          <tr>
            <th align="RIGHT" nowrap="nowrap" valign="BASELINE">Organization:

            </th>
            <td>Simplicity Media Ltd</td>
          </tr>
          <tr>
            <th align="RIGHT" nowrap="nowrap" valign="BASELINE">To: </th>
            <td><a moz-do-not-send="true"
                class="moz-txt-link-abbreviated"
                href="mailto:linux-kernel@vger.kernel.org">linux-kernel@vger.kernel.org</a>,
              <a moz-do-not-send="true" class="moz-txt-link-abbreviated"
                href="mailto:linux-rt-users@vger.kernel.org">linux-rt-users@vger.kernel.org</a></td>
          </tr>
        </tbody>
      </table>
      <br>
      <br>
      <pre>Some further logs:
./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.369927] redis-server 
invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.369939]  
[&lt;ffffffff810b12b7&gt;] ? oom_kill_process+0x82/0x283
./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.399285] redis-server 
invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.399296]  
[&lt;ffffffff810b12b7&gt;] ? oom_kill_process+0x82/0x283
./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.428690] redis-server 
invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.428702]  
[&lt;ffffffff810b12b7&gt;] ? oom_kill_process+0x82/0x283
./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.487696] redis-server 
invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.487708]  
[&lt;ffffffff810b12b7&gt;] ? oom_kill_process+0x82/0x283
./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.517023] redis-server 
invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.517035]  
[&lt;ffffffff810b12b7&gt;] ? oom_kill_process+0x82/0x283
./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.546379] redis-server 
invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
./log/syslog:May 30 07:44:38 vicky kernel: [ 2283.546391]  
[&lt;ffffffff810b12b7&gt;] ? oom_kill_process+0x82/0x283
./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.310789] redis-server 
invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.310804]  
[&lt;ffffffff810b12b7&gt;] ? oom_kill_process+0x82/0x283
./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.369918] redis-server 
invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.369930]  
[&lt;ffffffff810b12b7&gt;] ? oom_kill_process+0x82/0x283
./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.399284] redis-server 
invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.399296]  
[&lt;ffffffff810b12b7&gt;] ? oom_kill_process+0x82/0x283
./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.433634] redis-server 
invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.433648]  
[&lt;ffffffff810b12b7&gt;] ? oom_kill_process+0x82/0x283
./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.463947] redis-server 
invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.463959]  
[&lt;ffffffff810b12b7&gt;] ? oom_kill_process+0x82/0x283
./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.493439] redis-server 
invoked oom-killer: gfp_mask=0xd0, order=0, oom_adj=-17
./log/syslog:May 30 07:44:43 vicky kernel: [ 2288.493451]  
[&lt;ffffffff810b12b7&gt;] ? oom_kill_process+0x82/0x283


On 29/05/2011 22:50, Cal Leeming [Simplicity Media Ltd] wrote:
&gt;  First of all, my apologies if I have submitted this problem to the 
&gt; wrong place, spent 20 minutes trying to figure out where it needs to 
&gt; be sent, and was still none the wiser.
&gt;
&gt; The problem is related to applying memory limitations within a cgroup. 
&gt; If the OOM killer kicks in, it gets stuck in a loop where it tries to 
&gt; kill a process which has an oom_adj of -17. This causes an infinite 
&gt; loop, which in turn locks up the system.
&gt;
&gt; May 30 03:13:08 vicky kernel: [ 1578.117055] Memory cgroup out of 
&gt; memory: kill process 6016 (java) score 0 or a child
&gt; May 30 03:13:08 vicky kernel: [ 1578.117154] Memory cgroup out of 
&gt; memory: kill process 6016 (java) score 0 or a child
&gt; May 30 03:13:08 vicky kernel: [ 1578.117248] Memory cgroup out of 
&gt; memory: kill process 6016 (java) score 0 or a child
&gt; May 30 03:13:08 vicky kernel: [ 1578.117343] Memory cgroup out of 
&gt; memory: kill process 6016 (java) score 0 or a child
&gt; May 30 03:13:08 vicky kernel: [ 1578.117441] Memory cgroup out of 
&gt; memory: kill process 6016 (java) score 0 or a child
&gt;
&gt;
&gt;  root@vicky [/home/foxx] &gt; uname -a
&gt; Linux vicky 2.6.32.41-grsec #3 SMP Mon May 30 02:34:43 BST 2011 x86_64 
&gt; GNU/Linux
&gt; (this happens on both the grsec patched and non patched 2.6.32.41 kernel)
&gt;
&gt; When this is encountered, the memory usage across the whole server is 
&gt; still within limits (not even hitting swap).
&gt;
&gt; The memory configuration for the cgroup/lxc is:
&gt; lxc.cgroup.memory.limit_in_bytes = 3000M
&gt; lxc.cgroup.memory.memsw.limit_in_bytes = 3128M
&gt;
&gt; Now, what is even more strange, is that when running under the 
&gt; 2.6.32.28 kernel (both patched and unpatched), this problem doesn't 
&gt; happen. However, there is a slight difference between the two kernels. 
&gt; The 2.6.32.28 kernel gives a default of 0 in the /proc/X/oom_adj, 
&gt; where as the 2.6.32.41 gives a default of -17. I suspect this is the 
&gt; root cause of why it's showing in the later kernel, but not the earlier.
&gt;
&gt; To test this theory, I started up the lxc on both servers, and then 
&gt; ran a one liner which showed me all the processes with an oom_adj of -17:
&gt;
&gt; (the below is the older/working kernel)
&gt; <a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:root@courtney.internal">root@courtney.internal</a> [/mnt/encstore/lxc] &gt; uname -a
&gt; Linux courtney.internal 2.6.32.28-grsec #3 SMP Fri Feb 18 16:09:07 GMT 
&gt; 2011 x86_64 GNU/Linux
&gt; <a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:root@courtney.internal">root@courtney.internal</a> [/mnt/encstore/lxc] &gt; for x in `find /proc 
&gt; -iname 'oom_adj' | xargs grep "\-17"  | awk -F '/' '{print $3}'` ; do 
&gt; ps -p $x --no-headers ; done
&gt; grep: /proc/1411/task/1411/oom_adj: No such file or directory
&gt; grep: /proc/1411/oom_adj: No such file or directory
&gt;   804 ?        00:00:00 udevd
&gt;   804 ?        00:00:00 udevd
&gt; 25536 ?        00:00:00 sshd
&gt; 25536 ?        00:00:00 sshd
&gt; 31861 ?        00:00:00 sshd
&gt; 31861 ?        00:00:00 sshd
&gt; 32173 ?        00:00:00 udevd
&gt; 32173 ?        00:00:00 udevd
&gt; 32174 ?        00:00:00 udevd
&gt; 32174 ?        00:00:00 udevd
&gt;
&gt; (the below is the newer/broken kernel)
&gt;  root@vicky [/mnt/encstore/ssd/kernel/linux-2.6.32.41] &gt; uname -a
&gt; Linux vicky 2.6.32.41-grsec #3 SMP Mon May 30 02:34:43 BST 2011 x86_64 
&gt; GNU/Linux
&gt;  root@vicky [/mnt/encstore/ssd/kernel/linux-2.6.32.41] &gt; for x in 
&gt; `find /proc -iname 'oom_adj' | xargs grep "\-17"  | awk -F '/' '{print 
&gt; $3}'` ; do ps -p $x --no-headers ; done
&gt; grep: /proc/3118/task/3118/oom_adj: No such file or directory
&gt; grep: /proc/3118/oom_adj: No such file or directory
&gt;   895 ?        00:00:00 udevd
&gt;   895 ?        00:00:00 udevd
&gt;  1091 ?        00:00:00 udevd
&gt;  1091 ?        00:00:00 udevd
&gt;  1092 ?        00:00:00 udevd
&gt;  1092 ?        00:00:00 udevd
&gt;  2596 ?        00:00:00 sshd
&gt;  2596 ?        00:00:00 sshd
&gt;  2608 ?        00:00:00 sshd
&gt;  2608 ?        00:00:00 sshd
&gt;  2613 ?        00:00:00 sshd
&gt;  2613 ?        00:00:00 sshd
&gt;  2614 pts/0    00:00:00 bash
&gt;  2614 pts/0    00:00:00 bash
&gt;  2620 pts/0    00:00:00 sudo
&gt;  2620 pts/0    00:00:00 sudo
&gt;  2621 pts/0    00:00:00 su
&gt;  2621 pts/0    00:00:00 su
&gt;  2622 pts/0    00:00:00 bash
&gt;  2622 pts/0    00:00:00 bash
&gt;  2685 ?        00:00:00 lxc-start
&gt;  2685 ?        00:00:00 lxc-start
&gt;  2699 ?        00:00:00 init
&gt;  2699 ?        00:00:00 init
&gt;  2939 ?        00:00:00 rc
&gt;  2939 ?        00:00:00 rc
&gt;  2942 ?        00:00:00 startpar
&gt;  2942 ?        00:00:00 startpar
&gt;  2964 ?        00:00:00 rsyslogd
&gt;  2964 ?        00:00:00 rsyslogd
&gt;  2964 ?        00:00:00 rsyslogd
&gt;  2964 ?        00:00:00 rsyslogd
&gt;  2980 ?        00:00:00 startpar
&gt;  2980 ?        00:00:00 startpar
&gt;  2981 ?        00:00:00 ctlscript.sh
&gt;  2981 ?        00:00:00 ctlscript.sh
&gt;  3016 ?        00:00:00 cron
&gt;  3016 ?        00:00:00 cron
&gt;  3025 ?        00:00:00 mysqld_safe
&gt;  3025 ?        00:00:00 mysqld_safe
&gt;  3032 ?        00:00:00 sshd
&gt;  3032 ?        00:00:00 sshd
&gt;  3097 ?        00:00:00 mysqld.bin
&gt;  3097 ?        00:00:00 mysqld.bin
&gt;  3097 ?        00:00:00 mysqld.bin
&gt;  3097 ?        00:00:00 mysqld.bin
&gt;  3097 ?        00:00:00 mysqld.bin
&gt;  3097 ?        00:00:00 mysqld.bin
&gt;  3097 ?        00:00:00 mysqld.bin
&gt;  3097 ?        00:00:00 mysqld.bin
&gt;  3097 ?        00:00:00 mysqld.bin
&gt;  3097 ?        00:00:00 mysqld.bin
&gt;  3113 ?        00:00:00 ctl.sh
&gt;  3113 ?        00:00:00 ctl.sh
&gt;  3115 ?        00:00:00 sleep
&gt;  3115 ?        00:00:00 sleep
&gt;  3116 ?        00:00:00 .memcached.bin
&gt;  3116 ?        00:00:00 .memcached.bin
&gt;
&gt;
&gt; As you can see, it is clear that the newer kernel is setting -17 by 
&gt; default, which in turn is causing the OOM killer loop.
&gt;
&gt; So I began to try and find what may have caused this problem by 
&gt; comparing the two sources...
&gt;
&gt; I checked the code for all references to 'oom_adj' and 'oom_adjust' in 
&gt; both code sets, but found no obvious differences:
&gt; grep -R -e oom_adjust -e oom_adj . | sort | grep -R -e oom_adjust -e 
&gt; oom_adj
&gt;
&gt; Then I checked for references to "-17" in all .c and .h files, and 
&gt; found a couple of matches, but only one obvious one:
&gt; grep -R "\-17" . | grep -e ".c:" -e ".h:" -e "\-17" | wc -l
&gt; ./include/linux/oom.h:#define OOM_DISABLE (-17)
&gt;
&gt; But again, a search for OOM_DISABLE came up with nothing obvious...
&gt;
&gt; In a last ditch attempt, I did a search for all references to 'oom' 
&gt; (case-insensitive) in both code bases, then compared the two:
&gt;  root@annabelle [~/lol/linux-2.6.32.28] &gt; grep -i -R "oom" . | sort -n 
&gt; &gt; /tmp/annabelle.oom_adj
&gt;  root@vicky [/mnt/encstore/ssd/kernel/linux-2.6.32.41] &gt; grep -i -R 
&gt; "oom" . | sort -n &gt; /tmp/vicky.oom_adj
&gt;
&gt; and this brought back (yet again) nothing obvious..
&gt;
&gt;
&gt;  root@vicky [/mnt/encstore/ssd/kernel/linux-2.6.32.41] &gt; md5sum 
&gt; ./include/linux/oom.h
&gt; 2a32622f6cd38299fc2801d10a9a3ea8  ./include/linux/oom.h
&gt;
&gt;  root@annabelle [~/lol/linux-2.6.32.28] &gt; md5sum ./include/linux/oom.h
&gt; 2a32622f6cd38299fc2801d10a9a3ea8  ./include/linux/oom.h
&gt;
&gt;  root@vicky [/mnt/encstore/ssd/kernel/linux-2.6.32.41] &gt; md5sum 
&gt; ./mm/oom_kill.c
&gt; 1ef2c2bec19868d13ec66ec22033f10a  ./mm/oom_kill.c
&gt;
&gt;  root@annabelle [~/lol/linux-2.6.32.28] &gt; md5sum ./mm/oom_kill.c
&gt; 1ef2c2bec19868d13ec66ec22033f10a  ./mm/oom_kill.c
&gt;
&gt;
&gt;
&gt; Could anyone please shed some light as to why the default oom_adj is 
&gt; set to -17 now (and where it is actually set)? From what I can tell, 
&gt; the fix for this issue will either be:
&gt;
&gt;   1. Allow OOM killer to override the decision of ignoring oom_adj ==
&gt;      -17 if an unrecoverable loop is encountered.
&gt;   2. Change the default back to 0.
&gt;
&gt; Again, my apologies if this bug report is slightly unorthodox, or 
&gt; doesn't follow usual procedure etc. I can assure you I have tried my 
&gt; absolute best to give all the necessary information though.
&gt;
&gt; Cal
&gt;

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------070507050903020403090007--
