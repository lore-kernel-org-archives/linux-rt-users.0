From: Clark Williams <williams@redhat.com>
Subject: [PREEMPT_RT] - kernel panic with 3.6.11-rt25
Date: Wed, 16 Jan 2013 11:22:40 -0600
Message-ID: <20130116112240.138270ca@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/PlkI+4PIgL5yUgzl5Cc=e+7"; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48397 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753308Ab3APRWw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jan 2013 12:22:52 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/PlkI+4PIgL5yUgzl5Cc=e+7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

My laptop panic'ed this morning while I was doing my normal routine
(nothing extraordinary running, just mail, IRC, web browsers,
emacs, etc.). I've been running this kernel for quite a while now,
pretty sure it's been running for days (suspend/resume).=20

I took a picture of the backtrace and did a rough hand transcribe of it
here:

[204513.211279] kernel BUG at /home/williams/src/linux+rt/kernel/rt-linux.g=
it/kernel/sched/core.c:1728
[204513.211283] invalid opcode: 0000 [#1] PREEMPT SMP=20
[204513.211327] Modules linked in:  <huge list mail if interested>
[204513.211346] CPU 6=20
[204513.211347] Pid: 23152, comm: kworker/6:1 Not tainted 3.6.11-rt25+ #47 =
LENOVO 4391AH2/4391AH2 ...
[204513.201307] Call Trace:
[204513.211394]  [<ffffffff81634d90>] ? _raw_spin_unlock_irqrestore+0x20/0x=
60=20
[204513.211398]  [<ffffffff816332c9>] schedule+0x29/0x70=20
[204513.211402]  [<ffffffff81634245>] rt_spin_lock_slowlock+0xe5/0x2c0
[204513.211406]  [<ffffffff81634a36>] rt_spin_lock+0x26/0x30
[204513.211412]  [<ffffffff8107fcb2>] process_one_work+0x172/0x510
[204513.211418]  [<ffffffff812d6030>] ? disk_release+0xc0/0xc0
[204513.211422]  [<ffffffff81080446>] worker_thread+0x166/0x250
[204513.211426]  [<ffffffff810802e0>] ? rescuer_thread+0x250/0x250
[204513.211430]  [<ffffffff81085113>] kthread+0x93/0xa0=20
[204513.211435]  [<ffffffff81092339>] ? finish_task_switch+0x49/0xf0
[204513.211439]  [<ffffffff8163d504>] kernel_thread_helper+0x4/0x10
[204513.211443]  [<ffffffff81005080>] ? __init_kthread_worker+0x60/0x60
[204513.211445]  [<ffffffff8163d588>] ? gs_change+0x13/0x13
[204513.211470]  Code: ff 55 30 48 85 c0 74 e7 48 89 45 c0 e9 1c f9 ff
ff 44 8b 9f a0 02 00 00 45 85 db 0f 85 1d f0 ff ff e8 fd 7b ff ff e9 13
f8 ff ff <0f> 0b 0f 0b c9 9b 00 00 00 e9 cd fe ff ff a9 00 00 00 40 90
0f=20
[204513.211474] RIP [<ffffffff8163310c>] __schedule+0x07c/0x910=20
[204513.211475] RSP <ffff880117b0dc30>


And here's the output of addr2line on the non-questionable addresses
from the above backtrace:=20


$ addr2line -e rt-3.6/vmlinux ffffffff816332c9
/home/williams/src/linux-rt/kernel/rt-linux.git/kernel/sched/core.c:3698
$ addr2line -e rt-3.6/vmlinux ffffffff81634245
/home/williams/src/linux-rt/kernel/rt-linux.git/kernel/rtmutex.c:768
$ addr2line -e rt-3.6/vmlinux ffffffff81634a36
/home/williams/src/linux-rt/kernel/rt-linux.git/kernel/rtmutex.c:830
$ addr2line -e rt-3.6/vmlinux ffffffff8107fcb2
/home/williams/src/linux-rt/kernel/rt-linux.git/kernel/workqueue.c:2111
$ addr2line -e rt-3.6/vmlinux ffffffff81080446
/home/williams/src/linux-rt/kernel/rt-linux.git/kernel/workqueue.c:2211
$ addr2line -e rt-3.6/vmlinux ffffffff81085113
/home/williams/src/linux-rt/kernel/rt-linux.git/kernel/kthread.c:121
$ addr2line -e rt-3.6/vmlinux ffffffff8163d504
/home/williams/src/linux-rt/kernel/rt-linux.git/arch/x86/kernel/entry_64.S:=
1224


Unfortunately, the eights and zeros tend to bleed together in the
picture I took (stupid cell phone camera) so I'm not completely
positive about the traceback addresses like the workqueue.c:2211
report. I am fairly confident of the addresses above that in the call
trace stack. I'm not making a lot of sense out of this trace though.

Next time I'll run downstairs and get the 8Mpixel camera.=20

Clark

--Sig_/PlkI+4PIgL5yUgzl5Cc=e+7
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlD24eAACgkQHyuj/+TTEp0VswCfUrlGugUr0f82P/uufY23usHz
lSgAnR01p2rxdmVIOabJgaK3nviv/qD7
=ODEW
-----END PGP SIGNATURE-----

--Sig_/PlkI+4PIgL5yUgzl5Cc=e+7--
