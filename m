From: Victor henri <nadaeck@hotmail.com>
Subject: RE: disk thread problem when using RT kernel
Date: Fri, 4 Feb 2011 02:13:04 +0100
Message-ID: <SNT110-W32CADD9437BD95FF8AAB5CA8E60@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from snt0-omc1-s27.snt0.hotmail.com ([65.55.90.38]:4649 "EHLO
	snt0-omc1-s27.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753519Ab1BDBNJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Feb 2011 20:13:09 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello Carsten

> Date: Thu, 3 Feb 2011 23:26:51 +0100
> From: C.Emde@osadl.org
> To: nadaeck@hotmail.com
> Subject: Re: disk thread problem when using RT kernel
>
> Victor,
>
>> So if i understand well 'soft lock' is what i have described in my
>> post, and what you were experiencing.
>>
>> The only solution is to wait then?
> No, there is much more you can do. If you are willing to help in a
> constructive way and provide traces and other debug material, we will=
 be
> glad to assist you to locate and fix your problem. Up to now, we are =
not
> aware of any problem in the 2.6.33.7.2-rt30 "Latest Stable" real-time
> kernel version (osadl.org/Latest-Stable), since it underwent more tha=
n
> three months of heavy testing in our QA farm (osadl.org/QA). In gener=
al,
> it is a good idea to follow Alan Cox's recommendations on how to post=
 to
> a mailing list ->
> https://www.osadl.org/Eric-Raymond-How-to-ask-questions-the-s.questio=
ns-the-smart-way.0.html

Sure I'm willing to help; thank you for your help;

>
> 1. Do not top-post; if you do, you will get much less help than you
> would otherwise -> http://www.catb.org/~esr/jargon/html/T/top-post.ht=
ml.

Understood; i won't

>
> 2. Enable System Request (SysRq)
> Edit /etc/sysctl.conf and change
> kernel.sysrq =3D 0
> to
> kernel.sysrq =3D 1

kernel.sysrq =3D 0 was not in /etcsysctl.conf, so I added manually kern=
el.sysrq =3D 1 in the file

> This will enable SysRq at next reboot. To enable it while the compute=
r
> is running, type
> echo 1>/proc/sys/kernel/sysrq
> When SysRq is activated, the key combination Right-Alt/SysRq/ becomes
> available. The SysRq key is the leftmost key of the group of three ke=
ys
> to the right of F12. It is normally labeled "PrntScr" above and "SysR=
q"
> below. You need to type the three keys altogether. The command
> Right-Alt/SysRq/H, for example, displays help information, i.e. a lis=
t
> of the various available commands. To try it out, type Right-Alt, the=
n
> type SysRq while you hold Right-Alt, then type H while you continue t=
o
> hold Right-Alt and SysRq. Hint: this may not work under a window
> manager, since the key combination is filtered out. Use a virtual
> console (Control/Left-Alt/F1). After you typed Right-Alt/SysRq/H, the
> help info will be appended to the system log file such as:
>
> # tail -1 /var/log/messages
> kernel: SysRq : HELP : loglevel(0-9) reBoot Crash terminate-all-tasks=
(E)
> memory-full-oom-kill(F) kill-all-tasks(I) thaw-filesystems(J) saK
> show-backtrace-all-active-cpus(L) show-memory-usage(M)
> nice-all-RT-tasks(N) powerOff show-registers(P) show-all-timers(Q) un=
Raw
> Sync show-task-states(T) Unmount show-blocked-tasks(W)
> dump-ftrace-buffer(Z)

It worked

>
> The Key combination S-U-B (Right-Alt/SysRq/S - Right-Alt/SysRq/U -
> Right-Alt/SysRq/B) is worth to remember - in many cases, it will rebo=
ot
> a crashed system gracefully, since it flushes the disk cache, unmount=
s
> the disk and then reboots the system. You will no longer hate to do a
> forced shutdown of the system.
>
> When the system "hangs", the commands Right-Alt/SysRq/L,
> Right-Alt/SysRq/M, Right-Alt/SysRq/T etc. may be helpful to check out
> what the system is doing when the system has crashed and there is hop=
e
> it still has some life in it.
>
> 3. Enable a serial console
> To print system and kernel messages, add
> ignore_log_level earlyprintk=3DttyS0,115200
> and
> console=3DttyS0,115200 console=3Dtty0
> to the kernel boot parameters. Connect the system under test to anoth=
er
> computer (use a null-modem cable) and minicom to it. If the system do=
es
> not have a serial interface, but has an empty PCI slot, consider to
> purchase a PCI serial adapter. They are available for less than $25
> (US). When the system hangs, the serial console may contain useful
> information such as kernel crash dumps.
>
> 4. Next time you post a bug report, please provide the debug and trac=
e
> information that you were able to generate from the output of the ser=
ial
> console or from SysRq.
>
>
> Hope this helps,
>
> Carsten.

Thanks i'll try do=A0 all that;=20

PS Please one more thing : before i understand that Right-Alt had to be=
=20
replaced (in my case) by AltGr, I've been trying different combination=20
of keys (right, arrow, Left-Alt, and others); right away i was off=20
connection and i have bit networking problems on the whole pc : wireles=
s
 is disabled, and eth0 is gone; fortunately, i can connect on eth1; thi=
s
 happens **on the whole laptop** (even my other ubuntu on another disk=20
partition, or the ubuntu from the live usb stick=A0 have the same probl=
em;=20
it's like the previous network interface has been "burned"...);=A0 this=
=20
happened just after the combination key test... I'll post it somewhere=20
else where it is more appropriate, but i just wanted to ask if it=20
sounded familiar...

Thanks again

Victor=20


 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
