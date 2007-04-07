From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: 2.6.21-rc6-rt0 filp_close problem
Date: Sat, 07 Apr 2007 12:26:13 +0200
Message-ID: <461771C5.2040200@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:9551 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965748AbXDGK03 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Apr 2007 06:26:29 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1287747uga
        for <linux-rt-users@vger.kernel.org>; Sat, 07 Apr 2007 03:26:28 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

nf_conntrack still has problems
BUG: using smp_processor_id() in preemptible [00000000] code: kio_http/13084
caller is nf_conntrack_in+0x39c/0x468 [nf_conntrack]

Here is something new

filp_close+0x66/0x6f
 [<c01886bd>] sys_close+0x82/0xbc
 [<c0104341>] syscall_call+0x7/0xb
 [<b7f24410>] 0xb7f24410
 =======================
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c035b186>] .... __spin_lock+0x1a/0x59
.....[<c011f105>] ..   ( <= task_rq_lock+0x36/0x5c)

l *filp_close+0x66
0xc018746a is in filp_close (fs/open.c:1037).
1032
1033            dnotify_flush(filp, id);
1034            locks_remove_posix(filp, id);
1035            fput(filp);
1036            return retval;
1037    }
1038
1039    EXPORT_SYMBOL(filp_close);
1040
1041    /*

 l *0xc035b186
0xc035b186 is in __spin_lock (kernel/spinlock.c:218).
213     EXPORT_SYMBOL(__write_lock_bh);
214
215     void __lockfunc __spin_lock(raw_spinlock_t *lock)
216     {
217             preempt_disable();
218             spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
219             _raw_spin_lock(lock);
220     }
221
222     EXPORT_SYMBOL(__spin_lock);

l *0xc011f105
0xc011f105 is in task_rq_lock (kernel/sched.c:611).
606
607     repeat_lock_task:
608             local_irq_save(*flags);
609             rq = task_rq(p);
610             spin_lock(&rq->lock);
611             if (unlikely(rq != task_rq(p))) {
612                     spin_unlock_irqrestore(&rq->lock, *flags);
613                     goto repeat_lock_task;
614             }
615             return rq;

http://www.stardust.webpages.pl/files/tbf/bitis-gabonica/2.6.21-rc6-rt0/rt-config
http://www.stardust.webpages.pl/files/tbf/bitis-gabonica/2.6.21-rc6-rt0/rt-dmesg

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group (PL)
(http://www.stardust.webpages.pl/ltg/)
LTG - Linux Testers Group (EN)
(http://www.stardust.webpages.pl/linux_testers_group_en/)
