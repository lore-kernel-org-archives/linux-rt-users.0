From: "Harald Stocker" <Harald.Stocker@berghof.com>
Subject: Linux 3.2.16-rt27 - BUG: scheduling while atomic
Date: Wed, 25 Apr 2012 11:00:30 +0200
Message-ID: <OF399A3B46.F4610F11-ONC12579EB.00315EDA-C12579EB.00317C16@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail92.messagelabs.com ([194.106.220.51]:62546 "HELO
	mail92.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756691Ab2DYJAc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Apr 2012 05:00:32 -0400
Received: from zhsrv03.be-int.local (zhsrv03.be-int [10.255.255.245])
	by pegasus.berghof.com (8.13.8/8.13.8) with ESMTP id q3P90UD6020292
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Apr 2012 11:00:30 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

we use the kernel 3.2.16-rt27  on our powerpc board (MPC5200).
At our load tests we got a kernel Oops message:

[   72.958944] sched: RT throttling activated
[  216.604657] BUG: scheduling while atomic:=20
codesyscontrol/1165/0x00010001
[  216.604675] Modules linked in:
[  216.604691] NIP: 101ceb6c LR: 484026e4 CTR: 101b83a4
[  216.604711] REGS: c6a01f50 TRAP: 0901   Not tainted  (3.2.16-rt27)
[  216.604724] MSR: 0000f932 <EE,PR,FP,ME,IR,DR>  CR: 84002484  XER:=20
00000000
[  216.604764] TASK =3D c6e20130[1165] 'codesyscontrol' THREAD: c6a0000=
0
[  216.604778] GPR00: 4826ab84 4826ab5c 48272920 4826ab84 0efe95d8=20
0efe95e8 0efe95f0 0efb9858
[  216.604812] GPR08: 0efe95e0 4826ab84 000000f4 4826ab64 84002484
[  216.604847] NIP [101ceb6c] 0x101ceb6c
[  216.604862] LR [484026e4] 0x484026e4
[  216.604872] Call Trace:
[  216.604965] ------------[ cut here ]------------
[  216.604990] Kernel BUG at c004f978 [verbose debug info unavailable]
[  216.605014] Oops: Exception in kernel mode, sig: 5 [#1]
[  216.605025] PREEMPT mpc5200-simple-platform
[  216.605039] Modules linked in:
[  216.605054] NIP: c004f978 LR: c004f970 CTR: c001db40
[  216.605072] REGS: c6a01d40 TRAP: 0700   Not tainted  (3.2.16-rt27)
[  216.605085] MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 24002424  XER: 00000=
000
[  216.605120] TASK =3D c6e20130[1165] 'codesyscontrol' THREAD: c6a0000=
0
[  216.605134] GPR00: 00000001 c6a01df0 c6e20130 00000000 c74411f0=20
00000000 00000000 00000000
[  216.605166] GPR08: c6e20130 0000005a 00000000 c0495c08 24002482=20
10279110 00000000 c4653600
[  216.605199] GPR16: 7fffffff ffffffff 7fffffff c04951d8 c6a00000=20
c0494900 000000d8 23c36491
[  216.605233] GPR24: c005eda0 ffffffff 3b9ac9ff 00000001 c6a01f50=20
00000000 00000001 c6e20130
[  216.605295] NIP [c004f978] run_posix_cpu_timers+0x20/0x104
[  216.605316] LR [c004f970] run_posix_cpu_timers+0x18/0x104
[  216.605328] Call Trace:
[  216.605349] [c6a01df0] [c004f970] run_posix_cpu_timers+0x18/0x104=20
(unreliable)
[  216.605385] [c6a01e00] [c0039a28] update_process_times+0x48/0x5c
[  216.605424] [c6a01e20] [c005ee00] tick_sched_timer+0x60/0xd4
[  216.605452] [c6a01e50] [c00507ec] __run_hrtimer+0x9c/0x2a8
[  216.605480] [c6a01e80] [c0051a74] hrtimer_interrupt+0x158/0x4ac
[  216.605509] [c6a01f20] [c000c424] timer_interrupt+0x17c/0x2a8
[  216.605544] [c6a01f40] [c00117e8] ret_from_except+0x0/0x14
[  216.605560] Instruction dump:
[  216.605573] 419effec 38000000 90020000 4bffffac 9421fff0 7c0802a6=20
93e1000c 7c7f1b78
[  216.605606] 90010014 481ab93d 7c0000a6 54008ffe <0f000000> 3d60c049=20
800b4894 392b4894
[  216.826417] Kernel panic - not syncing: Fatal exception in interrupt

The same in kernel 3.2.15-rt26...

The problem occurs in overload situations only. So previously we also g=
ot=20
the message that rt throttling is getting enabled.

The problem seems to be dependent on the realtime patch because with a=20
untouched kernel 3.2.16 we cant reproduce it.=20
To locate the problem, additionally  we try to disable switching to=20
"throttling mode" by uncommenting "rt_rq->rt_throttled =3D 1;" in sched=
_rt.c
but it still occurs.

If the kernel is configured to be tickless the problem occurs less ofte=
n.


Any hints? any ideas?

Thanks
Harald








Hannover Messe 2012   =97 Berghof stellt aus :   Industrial Automation =
 Halle 9 / Stand D62   und   MobiliTec Halle 25 / Stand K03/1=20
Neugierig auf: "Web- und Target-Visualisierungen =97 Schneller als CoDe=
Sys erlaubt" oder "Test- und Konditioniersysteme"?=20
Infos und Ihr   kostenloses   pers=F6nliches Messeticket   unter:   www=
=2Eberghof.com/HMI=20

______________________________________________________________________
This email has been scanned by the Symantec Email Security.cloud servic=
e.
=46or more information please visit http://www.symanteccloud.com
______________________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
