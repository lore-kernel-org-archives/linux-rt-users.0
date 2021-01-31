Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF97C433DB
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Jan 2021 09:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5326664DE7
	for <linux-rt-users@archiver.kernel.org>; Sun, 31 Jan 2021 09:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhAaJWj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 31 Jan 2021 04:22:39 -0500
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:53719 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhAaJUt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 31 Jan 2021 04:20:49 -0500
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Jan 2021 04:20:47 EST
Received: from cust-57f2be97 ([IPv6:fc0c:c196:c6c4:fdf1:aa47:ab6:e251:d2a8])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id 68nSlt2v8W4yN68nTlSgPs; Sun, 31 Jan 2021 10:13:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1612084411; bh=x5t61l1xRzKkmvXrUNIApqmsT9kQmwWoKvGWRR2LpvE=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=HAF5L8Aq17wD0Z3rJahxVXQTX1HEvx+Ak/Uq5KHz4N3wjktZQtS1xtax45gpfaLA2
         5O4Y3CcWvLwzPJ589fi79apcqdIcvGRwc8tCr9/RUUQqiDaXurpL86EA0XxVuvYpjF
         b1l9Go8tmUuN3nezO8RZudL0fXl+NSmx9w4BapkflpFcKhFbf5D5Gj2pCQprt+/a1c
         GMZiM1H/J6y7BQrwhSaAj/7WaNJYT2FbIFQGsmYNzPMYFBt6PODoPDG1fEy0+y7Bje
         +UXdue0DPTamiqkjC+hA6fKJEhlGPcsPzH+G3E114+bzqS98B1CVixy/QMPUuK6yEQ
         bWg99NzRSJlzw==
To:     RT <linux-rt-users@vger.kernel.org>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: rcu_preempt detected stalls [5.9.1-rt]
Organization: hierzo
Message-ID: <47623850-fb85-aac0-9d44-85d7914a321f@xs4all.nl>
Date:   Sun, 31 Jan 2021 10:13:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGW1uBnd2Z9eAihuXvNweYNgqC+RCxjlWfiKSMtihTAHLMy/31/IR7XFoWpfNyoB+PLUi2MsHdcmwUzMFnixyObUd1ed8iDLwGnNi7lFPr9fOusKcAxy
 dnOVJ1Lj1emY6lhOkk/bWtgVUjOhMg/suAs0roTJn1L/Zv6KlBD6DZyteyTyqnoiEwQN+8b6n0jnRmn1p1x8ncgGD6dqzHx/sYd5pp+cVFFTt8VfuvIaeOL9
 aJFfljgCuKiHglCSHL6EISGBrNJRwTudy0kj8TBN1Ko=
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

Found these loggings in journal, what happened here?

Kind regards,
Udo


Jan 31 06:28:40 mds91 kernel: hardpps: PPSJITTER: jitter=1506165, 
limit=426096
Jan 31 09:20:24 mds91 kernel: rcu: INFO: rcu_preempt detected stalls on 
CPUs/tasks:
Jan 31 09:20:24 mds91 kernel:         (detected by 1, t=5252 jiffies, 
g=262090497, q=580)
Jan 31 09:20:24 mds91 kernel: rcu: All QSes seen, last rcu_preempt 
kthread activity 5252 (5610890440-5610885188), jiffies_till_next_fqs=1, 
root ->qsmask 0x0
Jan 31 09:20:24 mds91 kernel: rcu: rcu_preempt kthread starved for 5252 
jiffies! g262090497 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x2 ->cpu=0
Jan 31 09:20:24 mds91 kernel: rcu:         Unless rcu_preempt kthread 
gets sufficient CPU time, OOM is now expected behavior.
Jan 31 09:20:24 mds91 kernel: rcu: RCU grace-period kthread stack dump:
Jan 31 09:20:49 mds91 systemd[1]: tor.service: Watchdog timeout (limit 
1min)!
Jan 31 09:21:08 mds91 kernel: ------------[ cut here ]------------
Jan 31 09:21:08 mds91 kernel: WARNING: CPU: 0 PID: 11 at 
net/sched/sch_generic.c:442 dev_watchdog+0x1ff/0x210
Jan 31 09:21:09 mds91 kernel: Modules linked in: nct6775 act_police 
sch_ingress cls_u32 sch_sfq sch_cbq pppoe pppox ip6table_raw nf_log_ipv6 
ip6table_mangle xt_u32 xt_CT xt_nat nf_log_ipv4 nf_log_common 
xt_statistic nf_nat_sip nf_conntrack_sip xt_recent xt_string xt_lscan(O) 
xt_TARPIT(O) ipta>
Jan 31 09:21:09 mds91 kernel: CPU: 0 PID: 11 Comm: rcu_preempt Tainted: 
G           O      5.9.1-rt16 #1
Jan 31 09:21:09 mds91 kernel: Hardware name: To Be Filled By O.E.M. To 
Be Filled By O.E.M./QC5000M-ITX/PH, BIOS P1.10 05/06/2015
Jan 31 09:21:09 mds91 kernel: RIP: 0010:dev_watchdog+0x1ff/0x210
Jan 31 09:21:09 mds91 kernel: Code: 63 74 24 50 eb 8a 4c 89 f7 c6 05 57 
c7 b7 00 01 e8 16 0c fd ff 44 89 e9 48 89 c2 4c 89 f6 48 c7 c7 50 91 0f 
82 e8 6f d4 8d ff <0f> 0b eb ba 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 
48 8d 87 80 06
Jan 31 09:21:09 mds91 kernel: RSP: 0018:ffffc90000083c48 EFLAGS: 00010286
Jan 31 09:21:09 mds91 kernel: RAX: 0000000000000000 RBX: 
ffff88813616be00 RCX: ffffffff8226df98
Jan 31 09:21:09 mds91 kernel: RDX: ffffffff8226e0b8 RSI: 
0000000000000000 RDI: ffffffff8226e2f0
Jan 31 09:21:09 mds91 kernel: RBP: ffff888138afc460 R08: 
ffffffff8226df80 R09: 0000000000000001
Jan 31 09:21:09 mds91 kernel: R10: ffffffff8226dfc0 R11: 
ffffc90000083b88 R12: ffff888138afc5b8
Jan 31 09:21:09 mds91 kernel: R13: 0000000000000000 R14: 
ffff888138afc000 R15: ffff88813616be80
Jan 31 09:21:09 mds91 kernel: FS:  0000000000000000(0000) 
GS:ffff88813b400000(0000) knlGS:0000000000000000
Jan 31 09:21:09 mds91 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Jan 31 09:21:09 mds91 kernel: CR2: 00007f74b260208a CR3: 
000000011a67e000 CR4: 00000000000406b0
Jan 31 09:21:09 mds91 kernel: Call Trace:
Jan 31 09:21:09 mds91 kernel:  ? dev_trans_start+0x70/0x70
Jan 31 09:21:09 mds91 kernel:  call_timer_fn.constprop.0+0x81/0x110
Jan 31 09:21:09 mds91 kernel:  ? del_timer+0x70/0x70
Jan 31 09:21:09 mds91 kernel:  run_timer_softirq+0x2f0/0x330
Jan 31 09:21:09 mds91 kernel:  ? dev_trans_start+0x70/0x70
Jan 31 09:21:09 mds91 kernel:  ? try_to_wake_up+0x114/0x390
Jan 31 09:21:09 mds91 kernel:  ? find_held_lock+0x2b/0x80
Jan 31 09:21:09 mds91 kernel:  __do_softirq+0xa8/0x1a4
Jan 31 09:21:09 mds91 kernel:  __local_bh_enable_ip+0xb1/0xf0
Jan 31 09:21:09 mds91 kernel:  del_timer_sync+0x1ac/0x1d0
Jan 31 09:21:09 mds91 kernel:  ? internal_add_timer+0xa0/0xa0
Jan 31 09:21:09 mds91 kernel:  schedule_timeout+0xaa/0x120
Jan 31 09:21:09 mds91 kernel:  ? lock_timer_base+0x60/0x60
Jan 31 09:21:09 mds91 kernel:  rcu_gp_kthread+0x5c1/0xc10
Jan 31 09:21:09 mds91 kernel:  ? __rcu_read_unlock+0x30/0x30
Jan 31 09:21:09 mds91 kernel:  kthread+0x158/0x170
Jan 31 09:21:09 mds91 kernel:  ? kthread_create_worker_on_cpu+0x70/0x70
Jan 31 09:21:09 mds91 kernel:  ret_from_fork+0x22/0x30
Jan 31 09:21:09 mds91 kernel: ---[ end trace 0000000000000002 ]---
Jan 31 09:21:19 mds91 systemd[1]: tor.service: State 'stop-watchdog' 
timed out. Killing.
Jan 31 09:21:20 mds91 systemd[1]: tor.service: Main process exited, 
code=killed, status=9/KILL
░░ Subject: Unit process exited
░░ Defined-By: systemd
░░ Support: https://lists.freedesktop.org/mailman/listinfo/systemd-devel
░░
░░ An ExecStart= process belonging to unit tor.service has exited.
░░
░░ The process' exit code is 'killed' and its exit status is 9.
Jan 31 09:21:20 mds91 systemd[1]: tor.service: Failed with result 
'watchdog'.
░░ Subject: Unit failed
░░ Defined-By: systemd
░░ Support: https://lists.freedesktop.org/mailman/listinfo/systemd-devel
░░
░░ The unit tor.service has entered the 'failed' state with result 
'watchdog'.
Jan 31 09:21:31 mds91 systemd-coredump[3014850]: Process 2679915 (tor) 
of user 498 dumped core.

                                                     Stack trace of 
thread 2679915:
                                                     #0 
0x00007fc147686b0e getsockopt (libc.so.6 + 0x102b0e)
                                                     #1 
0x0000561d81436d7b update_socket_info_impl (tor + 0xd4d7b)
                                                     #2 
0x0000561d81437289 kist_scheduler_run (tor + 0xd5289)
                                                     #3 
0x0000561d81432833 scheduler_evt_callback (tor + 0xd0833)
                                                     #4 
0x00007fc147d08b54 event_process_active_single_queue (libevent-2.1.so.6 
+ 0x22b54)
                                                     #5 
0x00007fc147d0a5d7 event_base_loop (libevent-2.1.so.6 + 0x245d7)
                                                     #6 
0x0000561d813e05a0 do_main_loop (tor + 0x7e5a0)
                                                     #7 
0x0000561d813c9a8d tor_run_main (tor + 0x67a8d)
                                                     #8 
0x0000561d813cb77d tor_main (tor + 0x6977d)
                                                     #9 
0x0000561d813c4d2d main (tor + 0x62d2d)
                                                     #10 
0x00007fc1475ac1e2 __libc_start_main (libc.so.6 + 0x281e2)
                                                     #11 
0x0000561d813c4d8e _start (tor + 0x62d8e)

                                                     Stack trace of 
thread 2679924:
                                                     #0 
0x00007fc14775e6c2 pthread_cond_wait@@GLIBC_2.3.2 (libpthread.so.0 + 0xf6c2)
                                                     #1 
0x0000561d8154f0e3 worker_thread_main (tor + 0x1ed0e3)
                                                     #2 
0x0000561d815af876 tor_pthread_helper_fn (tor + 0x24d876)
                                                     #3 
0x00007fc1477583f9 start_thread (libpthread.so.0 + 0x93f9)
                                                     #4 
0x00007fc147685903 __clone (libc.so.6 + 0x101903)

                                                     Stack trace of 
thread 2679925:
                                                     #0 
0x00007fc14775e6c2 pthread_cond_wait@@GLIBC_2.3.2 (libpthread.so.0 + 0xf6c2)
                                                     #1 
0x0000561d8154f0e3 worker_thread_main (tor + 0x1ed0e3)
                                                     #2 
0x0000561d815af876 tor_pthread_helper_fn (tor + 0x24d876)
                                                     #3 
0x00007fc1477583f9 start_thread (libpthread.so.0 + 0x93f9)
                                                     #4 
0x00007fc147685903 __clone (libc.so.6 + 0x101903)

                                                     Stack trace of 
thread 2679928:
                                                     #0 
0x00007fc14775e6c2 pthread_cond_wait@@GLIBC_2.3.2 (libpthread.so.0 + 0xf6c2)
                                                     #1 
0x0000561d8154f0e3 worker_thread_main (tor + 0x1ed0e3)
                                                     #2 
0x0000561d815af876 tor_pthread_helper_fn (tor + 0x24d876)
                                                     #3 
0x00007fc1477583f9 start_thread (libpthread.so.0 + 0x93f9)
                                                     #4 
0x00007fc147685903 __clone (libc.so.6 + 0x101903)

                                                     Stack trace of 
thread 2679926:
                                                     #0 
0x00007fc14775e6c2 pthread_cond_wait@@GLIBC_2.3.2 (libpthread.so.0 + 0xf6c2)
                                                     #1 
0x0000561d8154f0e3 worker_thread_main (tor + 0x1ed0e3)
                                                     #2 
0x0000561d815af876 tor_pthread_helper_fn (tor + 0x24d876)
                                                     #3 
0x00007fc1477583f9 start_thread (libpthread.so.0 + 0x93f9)
                                                     #4 
0x00007fc147685903 __clone (libc.so.6 + 0x101903)

                                                     Stack trace of 
thread 2679927:
                                                     #0 
0x00007fc14775e6c2 pthread_cond_wait@@GLIBC_2.3.2 (libpthread.so.0 + 0xf6c2)
                                                     #1 
0x0000561d8154f0e3 worker_thread_main (tor + 0x1ed0e3)
                                                     #2 
0x0000561d815af876 tor_pthread_helper_fn (tor + 0x24d876)
                                                     #3 
0x00007fc1477583f9 start_thread (libpthread.so.0 + 0x93f9)
                                                     #4 
0x00007fc147685903 __clone (libc.so.6 + 0x101903)
░░ Subject: Process 2679915 (tor) dumped core
░░ Defined-By: systemd
░░ Support: https://lists.freedesktop.org/mailman/listinfo/systemd-devel
░░ Documentation: man:core(5)
░░
░░ Process 2679915 (tor) crashed and dumped core.
░░
░░ This usually indicates a programming error in the crashing program and
░░ should be reported to its vendor as a bug.
-- Reboot --
