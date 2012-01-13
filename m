From: Antonio Barbalace <antoniob@vt.edu>
Subject: 3.0.10-rt27 arch/arm/kernel/smp.c bug
Date: Fri, 13 Jan 2012 14:17:57 -0500
Message-ID: <20120113141757.12301lfyl3g6enad@webmail.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:37845 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745Ab2AMTSC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jan 2012 14:18:02 -0500
Received: from zidane.cc.vt.edu (zidane.cc.vt.edu [198.82.163.227])
	by lennier.cc.vt.edu (8.13.8/8.13.8) with ESMTP id q0DJI0j1029033
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Jan 2012 14:18:01 -0500
Received: from imp-b08.cc.vt.edu (imp-b08.cc.vt.edu [127.0.0.1])
	by imp-b08.cc.vt.edu (8.13.8/8.13.8) with ESMTP id q0DJHvW6017394
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Jan 2012 14:17:57 -0500
Received: (from apache@localhost)
	by imp-b08.cc.vt.edu (8.13.8/8.13.8/Submit) id q0DJHvio017393
	for linux-rt-users@vger.kernel.org; Fri, 13 Jan 2012 14:17:57 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I would like to report the following bug that is not still solved in  
the current 3.0.14 ver.

[  300.459960] BUG: sleeping function called from invalid context at  
kernel/rtm5
[  300.459991] in_atomic(): 1, irqs_disabled(): 128, pid: 9, name: migration/1
[  300.459991] 1 lock held by migration/1/9:
[  300.459991]  #0:  (tasklist_lock){++++..}, at: [<c0064fe8>]  
__cpu_disable+0x0
[  300.460021] irq event stamp: 1887
[  300.460052] hardirqs last  enabled at (1886): [<c04e5878>]  
_raw_spin_unlock_8
[  300.460052] hardirqs last disabled at (1887): [<c00efd10>]  
stop_machine_cpu_4
[  300.460083] softirqs last  enabled at (0): [<c009f628>]  
copy_process+0x3b4/00
[  300.460113] softirqs last disabled at (0): [<  (null)>]   (null)
[  300.460144] [<c00670e4>] (unwind_backtrace+0x0/0xf4) from  
[<c04e4c88>] (__rt)
[  300.460174] [<c04e4c88>] (__rt_spin_lock+0x18/0x2c) from  
[<c04e51e0>] (rt_re)
[  300.460174] [<c04e51e0>] (rt_read_lock+0x54/0x68) from [<c0064fe8>]  
(__cpu_d)
[  300.460235] [<c0064fe8>] (__cpu_disable+0xdc/0x170) from  
[<c04d4b7c>] (take_)
[  300.460235] [<c04d4b7c>] (take_cpu_down+0xc/0x30) from [<c00efd28>]  
(stop_ma)
[  300.460235] [<c00efd28>] (stop_machine_cpu_stop+0xd8/0x114) from  
[<c00efad4>)
[  300.460266] [<c00efad4>] (cpu_stopper_thread+0xb8/0x1ac) from  
[<c00c29f8>] ()
[  300.460327] [<c00c29f8>] (kthread+0x88/0x90) from [<c0060914>]  
(kernel_threa)
[  300.464385] CPU1: shutdown

This is due to the following arch/arm/kernel/smp.c @ __cpu_disable code:

169         read_lock(&tasklist_lock);
170         for_each_process(p) {
171                 if (p->mm)
172                         cpumask_clear_cpu(cpu, mm_cpumask(p->mm));
173         }
174         read_unlock(&tasklist_lock);

I am not a rt expert, do you have any clue on how to solve this problem?
Thanks,
Antonio

