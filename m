From: Gregoire Gentil <gregoire@gentil.com>
Subject: cpufreq + PREEMPT_RT_FULL give bad context sleeping BUG
Date: Sat, 23 Mar 2013 10:17:51 -0700
Message-ID: <514DE3BF.5010800@gentil.com>
References: <alpine.LFD.2.02.1303222301010.22263@ionos> <20130323013003.GU11538@uudg.org>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:35592 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab3CWRYz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Mar 2013 13:24:55 -0400
Received: from [192.168.10.2] (c-50-148-150-5.hsd1.ca.comcast.net [50.148.150.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTPSA id D6714140C56C0
	for <linux-rt-users@vger.kernel.org>; Sat, 23 Mar 2013 18:17:53 +0100 (CET)
In-Reply-To: <20130323013003.GU11538@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On OMAP + 3.4 + rt patches with CONFIG_PREEMPT_RT_FULL=20
CONFIG_CPU_FREQ_GOV_ONDEMAND, I get a lot of those cpufreq-related bugs=
:

http://pastebin.com/csy9y3xk

BUG: sleeping function called from invalid context at kernel/rtmutex.c:=
646
in_atomic(): 1, irqs_disabled(): 128, pid: 1089, name: kworker/0:2
INFO: lockdep is turned off.
irq event stamp: 0
hardirqs last enabled at (0): [< (null)>] (null)
hardirqs last disabled at (0): [<c0043f3c>] copy_process+0x498/0x11c0
softirqs last enabled at (0): [<c0043f3c>] copy_process+0x498/0x11c0
softirqs last disabled at (0): [< (null)>] (null)
(unwind_backtrace+0x0/0xf0) from (dump_stack+0x20/0x24)
(dump_stack+0x20/0x24) from (__might_sleep+0x124/0x144)
(__might_sleep+0x124/0x144) from (rt_spin_lock+0x30/0x64)
(rt_spin_lock+0x30/0x64) from (clk_get_rate+0x30/0x54)
(clk_get_rate+0x30/0x54) from (twd_update_frequency+0x20/0x58)
(twd_update_frequency+0x20/0x58) from (smp_call_function_single+0xd0/0x=
1c4)
(smp_call_function_single+0xd0/0x1c4) from=20
(twd_cpufreq_transition+0x34/0x40)
(twd_cpufreq_transition+0x34/0x40) from (notifier_call_chain+0x48/0x78)
(notifier_call_chain+0x48/0x78) from (__srcu_notifier_call_chain+0x80/0=
xb8)
(__srcu_notifier_call_chain+0x80/0xb8) from=20
(srcu_notifier_call_chain+0x28/0x30)
(srcu_notifier_call_chain+0x28/0x30) from=20
(cpufreq_notify_transition+0x1c8/0x200)
(cpufreq_notify_transition+0x1c8/0x200) from (omap_cpufreq_scale+0xec/0=
x12c)
(omap_cpufreq_scale+0xec/0x12c) from (omap_target+0x8c/0xb4)
(omap_target+0x8c/0xb4) from (__cpufreq_driver_target+0x74/0x8c)
(__cpufreq_driver_target+0x74/0x8c) from (do_dbs_timer+0x39c/0x454)
(do_dbs_timer+0x39c/0x454) from (process_one_work+0x2ec/0x50c)
(process_one_work+0x2ec/0x50c) from (worker_thread+0x1c4/0x2c8)
(worker_thread+0x1c4/0x2c8) from (kthread+0x98/0xa4)
(kthread+0x98/0xa4) from (kernel_thread_exit+0x0/0x8)

Any idea what I should do to fix this problem?

Gr=E9goire

PS: Here is some related code:

http://dev.omapzoom.org/?p=3Dintegration/kernel-ubuntu.git;a=3Dblob;f=3D=
arch/arm/mach-omap2/omap2plus-cpufreq.c;h=3Dc60eb61a60fb524ac9eb3a4bcbb=
13bfa9d96e76f;hb=3D3e1c9f139425663ceee48f92e8d3f23158580334

http://dev.omapzoom.org/?p=3Dintegration/kernel-ubuntu.git;a=3Dblob;f=3D=
arch/arm/plat-omap/clock.c;h=3D8c0e8fe2c5c51673e41e4304194d922dbfaedf38=
;hb=3D3e1c9f139425663ceee48f92e8d3f23158580334

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
