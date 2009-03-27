From: Philippe Reynes <philippe.reynes@isismpp.fr>
Subject: Re: [Announce] 2.6.29-rt1
Date: Fri, 27 Mar 2009 11:10:53 +0000 (UTC)
Message-ID: <gqic7t$c27$1@ger.gmane.org>
References: <49b7c2350903260354p6eaf50ebo87985dcfb8d48ba0@mail.gmail.com>
	<gqi6oc$1s3$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:57892 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753541AbZC0LLJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Mar 2009 07:11:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ln9xq-0001uZ-7n
	for linux-rt-users@vger.kernel.org; Fri, 27 Mar 2009 11:11:06 +0000
Received: from extranet.isismpp.fr ([86.65.130.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Mar 2009 11:11:06 +0000
Received: from philippe.reynes by extranet.isismpp.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Mar 2009 11:11:06 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all

I've tried to remove the mlockall(MCL_CURRENT|MCL_FUTURE)
and now, the kernel don't crash. But a data corruption=20
appear in the data saved by the application. Such corruption
never occurs with other kernel (2.6.28 and 2.6.29). I'll
investigate if it could be an application bug.

Philippe




Le Fri, 27 Mar 2009 09:37:17 +0000, Philippe Reynes a =C3=A9crit=C2=A0:

> Hi
>=20
>=20
> I've got crashes when I run an app with thread with RT priority. This
> crash could happen on any comman, here some log of crashes :
>=20
>=20
> First one :
>=20
> server calling Oops: Exception in kernel mode, sig: 5 [#1] PREEMPT
> MPC837x RR605
> Modules linked in:
> NIP: c0075b08 LR: c0075a50 CTR: c00d7d90 REGS: dbb6dcb0 TRAP: 0700   =
Not
> tainted  (2.6.29-rt1) MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 24002488  X=
ER:
> 00000000 TASK =3D dddea1e0[1769] 'vsftpd' THREAD: dbb6c000 GPR00: 000=
00001
> dbb6dd60 dddea1e0 df803e24 df803e10 df803e08 00000000 ddc72020
> GPR08: 00000000 0000001b dddea1e0 df803e24 24000482 100bf094 00000000
> c04aa6fc
> GPR16: 00200200 00100100 c04e5958 c04e595c dbb6dd68 c04e0000 c04e0000
> c04aa6bc
> GPR24: 00000020 dbb6ddd8 00000010 df80ae00 00000000 dbb6de38 df816800
> df803e00
> NIP [c0075b08] cache_alloc_refill+0x180/0x62c LR [c0075a50]
> cache_alloc_refill+0xc8/0x62c Call Trace:
> [dbb6dd60] [c038878c] preempt_schedule_irq+0x5c/0x80 (unreliable)
> [dbb6ddd0] [c00761a0] kmem_cache_alloc+0x6c/0x140 [dbb6de00] [c002ddb=
4]
> __sigqueue_do_alloc+0xa0/0xec [dbb6de10] [c002e2f8]
> send_signal+0xa4/0x224 [dbb6de30] [c002f680]
> do_notify_parent+0x1a8/0x1d4 [dbb6ded0] [c0025608] do_exit+0x584/0x69=
c
> [dbb6df10] [c00257a0] do_group_exit+0x80/0xac [dbb6df30] [c00257e0]
> sys_exit_group+0x14/0x28 [dbb6df40] [c00117f4] ret_from_syscall+0x0/0=
x38
> --- Exception: c01 at 0xfef463c
>     LR =3D 0xffa5884
> Instruction dump:
> 7f87f800 40be0018 80ff0010 38000001 901f0048 7f872000 419e00e8 800700=
10
> 813b001c 7c090010 38000000 7c000114 <0f000000> 381a0001 38c7001c
> 7c0903a6 ---[ end trace 99200bd45c29aa91 ]---
> Fixing recursive fault but reboot is needed!
>=20
>=20
> Second one :
> I've run my app, and after just run a simple "ifconfig"
>=20
>=20
> -sh-2.05b# ifconfig
> eth0      Link eOops: Exception in kernel mode, sig: 5 [#1] PREEMPT
> MPC837x RR605
> Modules linked in:
> NIP: c0075b08 LR: c0075a50 CTR: c02cf170 REGS: dab41cb0 TRAP: 0700   =
Not
> tainted  (2.6.29-rt1) MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 24002488  X=
ER:
> 00000000 TASK =3D df8be100[1756] 'ifconfig' THREAD: dab40000 GPR00:
> 00000001 dab41d60 df8be100 df803e24 df803e10 df803e08 00000000 dddcc0=
00
> GPR08: 00000000 0000001b df8be100 df803e24 24000482 10023370 00000000
> c04aa6fc
> GPR16: 00200200 00100100 c04e5958 c04e595c dab41d68 c04e0000 c04e0000
> c04aa6bc
> GPR24: 00000020 dab41dd8 00000010 df80ae00 00000000 dab41e38 df816800
> df803e00
> NIP [c0075b08] cache_alloc_refill+0x180/0x62c LR [c0075a50]
> cache_alloc_refill+0xc8/0x62c Call Trace:
> [dab41d60] [00000001] 0x1 (unreliable) [dab41dd0] [c00761a0]
> kmem_cache_alloc+0x6c/0x140 [dab41e00] [c002ddb4]
> __sigqueue_do_alloc+0xa0/0xec [dab41e10] [c002e2f8]
> send_signal+0xa4/0x224 [dab41e30] [c002f680]
> do_notify_parent+0x1a8/0x1d4 [dab41ed0] [c0025608] do_exit+0x584/0x69=
c
> [dab41f10] [c00257a0] do_group_exit+0x80/0xac [dab41f30] [c00257e0]
> sys_exit_group+0x14/0x28 [dab41f40] [c00117f4] ret_from_syscall+0x0/0=
x38
> --- Exception: c01 at 0xff3b63c
>     LR =3D 0xffec884
> Instruction dump:
> 7f87f800 40be0018 80ff0010 38000001 901f0048 7f872000 419e00e8 800700=
10
> 813b001c 7c090010 38000000 7c000114 <0f000000> 381a0001 38c7001c
> 7c0903a6 ---[ end trace f43c24570097662c ]---
> Fixing recursive fault but reboot is needed!
>=20
>=20
>=20
> The kernel is a 2.6.29-rt1 compiled with ltib for powerpc (mpc8377E).
>=20
> Philippe

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
