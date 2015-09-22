From: Martin Steigerwald <martin-3kZCPVa5dk2azgQtNeiOUg@public.gmane.org>
Subject: Re: chrt permission denied with kernel 4.3-rc2
Date: Tue, 22 Sep 2015 14:32:14 +0200
Message-ID: <1529840.Y79o7PkRCS@merkaba>
References: <1948574.mCKV7sP6Yb@merkaba> <CAG27Bk3=gCmdsekNc9ZXYz1h-gz0VfNpRz23zMvx7-RqM+Qqdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: util-linux <util-linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kerolasa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAG27Bk3=gCmdsekNc9ZXYz1h-gz0VfNpRz23zMvx7-RqM+Qqdg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Cc=C2=B4ing rt-users mailinglist as some questions may exceed the scope=
 of
util-linux mailinglist.

Am Dienstag, 22. September 2015, 12:07:10 CEST schrieb Sami Kerola:
> On 22 September 2015 at 11:19, Martin Steigerwald <martin@lichtvoll.d=
e> wrote:
> > with 4.3-rc2 kernel (self-compiled) I get:
> >=20
> > merkaba:~> LANG=3DC chrt -r -p 5 $$
> > chrt: failed to set pid 3464's policy: Operation not permitted
> >=20
> > called with root rights (either su shell or even a direct tty)
> >=20
> > strace reports:
> >=20
> > sched_setscheduler(3464, SCHED_RR, { 5 }) =3D -1 EPERM (Operation n=
ot
> > permitted)
> >=20
> >=20
> > With 4.1 standard Debian kernel it works.
> >=20
> >=20
> > Any idea?
> >=20
> > I know I can use setcap to check file capabilities. But I am not su=
re how
> > to see the capabilities of a running process.
> >=20
> > Is it /proc/$$/status?
> >=20
> > On 4.3-rc2 kernel it tells me:
> >=20
> > CapInh: 0000000000000000
> > CapPrm: 0000003fffffffff
> > CapEff: 0000003fffffffff
> > CapBnd: 0000003fffffffff
> > CapAmb: 0000000000000000
> >=20
> > On 4.1 Debian kernel on a different machine it tells me:
> >=20
> > CapInh: 0000000000000000
> > CapPrm: 0000003fffffffff
> > CapEff: 0000003fffffffff
> > CapBnd: 0000003fffffffff
> >=20
> > (there is no CapAmb there)
> >=20
> > as well, when logged in via SSH, yet chrt -r -p 5 $$ works there as=
 well.
> >=20
> > Is there a command displaying available capabilities of a process i=
n clear
> > text?
> >=20
> >> xzgrep SCHED config-4.3.0-rc2-tp520.xz
> >=20
> > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
> > CONFIG_CGROUP_SCHED=3Dy
> > CONFIG_FAIR_GROUP_SCHED=3Dy
> > CONFIG_RT_GROUP_SCHED=3Dy
> > CONFIG_SCHED_AUTOGROUP=3Dy
> > CONFIG_IOSCHED_NOOP=3Dy
> > CONFIG_IOSCHED_DEADLINE=3Dy
> > CONFIG_IOSCHED_CFQ=3Dy
> > CONFIG_CFQ_GROUP_IOSCHED=3Dy
> > CONFIG_DEFAULT_IOSCHED=3D"cfq"
> > CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
> > CONFIG_SCHED_SMT=3Dy
> > CONFIG_SCHED_MC=3Dy
> > CONFIG_SCHED_HRTICK=3Dy
> > CONFIG_NET_SCHED=3Dy
> > CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
> > CONFIG_SCHED_DEBUG=3Dy
> > CONFIG_SCHED_INFO=3Dy
> > CONFIG_SCHEDSTATS=3Dy
> > # CONFIG_SCHED_STACK_END_CHECK is not set
> > # CONFIG_SCHED_TRACER is not set
> >=20
> >=20
> > mango:~# grep SCHED /boot/config-4.1.0-2-amd64
> > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
> > CONFIG_CGROUP_SCHED=3Dy
> > CONFIG_FAIR_GROUP_SCHED=3Dy
> > # CONFIG_RT_GROUP_SCHED is not set
> > CONFIG_SCHED_AUTOGROUP=3Dy
> > CONFIG_IOSCHED_NOOP=3Dy
> > CONFIG_IOSCHED_DEADLINE=3Dy
> > CONFIG_IOSCHED_CFQ=3Dy
> > CONFIG_CFQ_GROUP_IOSCHED=3Dy
> > CONFIG_DEFAULT_IOSCHED=3D"cfq"
> > CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
> > CONFIG_SCHED_SMT=3Dy
> > CONFIG_SCHED_MC=3Dy
> > CONFIG_SCHED_HRTICK=3Dy
> > CONFIG_NET_SCHED=3Dy
> > CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
> > CONFIG_SCHED_DEBUG=3Dy
> > # CONFIG_SCHEDSTATS is not set
> > # CONFIG_SCHED_STACK_END_CHECK is not set
> > # CONFIG_SCHED_TRACER is not set
> >=20
> >=20
> > Both Debian Sid systems use systemd 226-3.
>=20
> Hi Martin,
>=20
> You might be hitting branch CONFIG_RT_GROUP_SCHED enabled.
>=20
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/k=
ernel/s
> ched/core.c#n3863
>=20
> See also.
>=20
> http://cateee.net/lkddb/web-lkddb/RT_GROUP_SCHED.html

I see.

Thanks, that was it. Detailed analysis below.


I was aware of the system wide settings that are meant to prevent
blocking a CPU completely:

merkaba:~> cat /proc/sys/kernel/sched_rt_period_us=20
1000000
merkaba:~> cat /proc/sys/kernel/sched_rt_runtime_us=20
950000


But yeah, kernel documentation also mentions this:

119 Realtime group scheduling means you have to assign a portion of tot=
al CPU
120 bandwidth to the group before it will accept realtime tasks. Theref=
ore you will
121 not be able to run realtime tasks as any user other than root until=
 you have
122 done that, even if the user has the rights to run processes with re=
altime
123 priority!

scheduler/sched-rt-group.txt

Still with the example "chrt -r -p 5 $$" in a root shell the bash proce=
ss is
running as root.


Well lets see:

merkaba:/sys/fs/cgroup> find -name "*cpu.rt_runtime_us*"
=2E/cpu,cpuacct/cpu.rt_runtime_us
=2E/cpu,cpuacct/init.scope/cpu.rt_runtime_us
=2E/cpu,cpuacct/system.slice/cpu.rt_runtime_us
=2E/cpu,cpuacct/user.slice/user-1000.slice/cpu.rt_runtime_us
=2E/cpu,cpuacct/user.slice/user-2012.slice/cpu.rt_runtime_us
=2E/cpu,cpuacct/user.slice/cpu.rt_runtime_us
=2E/cpu,cpuacct/user.slice/user-132.slice/cpu.rt_runtime_us



merkaba:/sys/fs/cgroup> cat cpuacct/user.slice/user-1000.slice/cpu.rt_r=
untime_us
0

merkaba:/sys/fs/cgroup> echo "950000" > cpuacct/user.slice/user-1000.sl=
ice/cpu.rt_runtime_us
echo: write error: invalid argument

merkaba:/sys/fs/cgroup> echo "950000" > cpu/user.slice/cpu.rt_runtime_u=
s=20
merkaba:/sys/fs/cgroup> echo "950000" > cpu/user.slice/user-1000.slice/=
cpu.rt_runtime_us

merkaba:/sys/fs/cgroup> LANG=3DC echo "950000" > cpu/user.slice/user-20=
12.slice/cpu.rt_runtime_us
echo: write error: invalid argument

Okay, probably cannot allocate more than the 950000 combined to each us=
er then.

merkaba:/sys/fs/cgroup> echo "400000" > cpu/user.slice/user-1000.slice/=
cpu.rt_runtime_us  =20
merkaba:/sys/fs/cgroup> echo "400000" > cpu/user.slice/user-2012.slice/=
cpu.rt_runtime_us


merkaba:~> chrt -r -p 5 $$                               =20
merkaba:~>

So the RT accounting still thinks I am a user. Despite:

merkaba:~> ps u -p $$ =20
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAN=
D
root      3464  0.0  0.0  44856  5944 pts/2    S    09:23   0:00 -su

merkaba:~> whoami                        =20
root

Is this a kernel bug or I am overseeing something here? Maybe its tied =
to the
session somehow? But then it also didn=C2=B4t work as root shell starte=
d from
tty1. Well=E2=80=A6 if child processes are inheriting the same group de=
spite the user
they run at, and if systemd created a new slice for root sessions as we=
ll=E2=80=A6

but still, above documentation says the limit only applies to non root
processes.


Heck, I may just disable that feature again. A global option to prevent
complete lockup is enough for me.

It all started with me wanting to give PulseAudio real time prio in ord=
er to
get rid of the cracks in the audio on heavy GUI activity.

merkaba:~#1> ps u -C pulseaudio
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAN=
D
martin    1283  0.1  0.0 573432 11996 ?        Sl   Sep21   1:36 /usr/b=
in/pulseaudio --start --log-target=3Dsyslog
ms       16888  0.8  0.0 433712 11400 ?        Sl   09:59   2:15 /usr/b=
in/pulseaudio --start --log-target=3Dsyslog

merkaba:~> chrt -afp 5 1283 =20
merkaba:~> chrt -afp 5 16888

Thanks,
--=20
Martin
--
To unsubscribe from this list: send the line "unsubscribe util-linux" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
