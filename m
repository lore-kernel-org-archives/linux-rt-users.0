From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: 2.6.27.5 RT patch status (26rt11)
Date: Thu, 20 Nov 2008 11:43:33 -0200
Message-ID: <20081120134333.GI30491@ghostprotocols.net>
References: <20081110234740.GB18819@windriver.com> <20081120132544.GG30491@ghostprotocols.net> <20081120132910.GH30491@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:45799 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754075AbYKTNni (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Nov 2008 08:43:38 -0500
Content-Disposition: inline
In-Reply-To: <20081120132910.GH30491@ghostprotocols.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Em Thu, Nov 20, 2008 at 11:29:10AM -0200, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Nov 20, 2008 at 11:25:44AM -0200, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Nov 10, 2008 at 06:47:40PM -0500, Paul Gortmaker escreveu:
> > > I've updated from the 2.6.27-rc8 patch series based on 26rt9 to be
> > > based on 2.6.27.5 kernel.org and 26rt11 preempt_rt.
> > > 
> > > I've done a successful boot to X11 on basic old P4 and it survived a
> > > make -j20 of kernel.org git.  There is still work to be done in order to
> > > stabilize more complex hardware (e.g. SMP etc) -- but I see this still
> > 
> > I hit one, DELL PE1900, dual dual core xeon, megasas disk controler,
> > bnx2 NIC:
> > No AGP bridge found
> > PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> > Placing software IO TLB between 0x20000000 - 0x24000000
> > Memory: 4009156k/4980736k available (2784k kernel code, 184412k
> > reserved, 1650k data, 496k init)
> > Calibrating delay loop (skipped), value calculated using timer
> > frequency.. 3989.96 BogoMIPS (lpj=1994981)
> > BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> > IP: [<ffffffff8151d8b8>] fork_init+0xba/0xd2 PGD 0 
> > Oops: 0000 [1] PREEMPT SMP 
> > CPU 0 
> > Modules linked in:
> > Pid: 0, comm: swapper Not tainted 2.6.27.5-26rt11 #1
> > RIP: 0010:[<ffffffff8151d8b8>]  [<ffffffff8151d8b8>] fork_init+0xba/0xd2
> > RSP: 0018:ffffffff814fff08  EFLAGS: 00010206
> > RAX: ffffffff8157caf0 RBX: 0000000000130000 RCX: 0000000000000048
> > RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffffffff815cfc48
> > RBP: ffffffff814fff18 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000010 R11: 0000000000000002 R12: 4ec4ec4ec4ec4ec5
> > R13: ffffffff81535d80 R14: ffffffff815381c0 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffffffff814eb100(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> > CR2: 0000000000000008 CR3: 0000000000201000 CR4: 00000000000006a0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> > Process swapper (pid: 0, threadinfo ffffffff814fe000, task ffffffff814064a0)
> > Stack:  ffffffff814fff18 0000000000000000 ffffffff814fff58
> > ffffffff81506cf6
> >  ffffffff814fff58 ffffffff815381c0 0000000000854520 ffffffff81506140
> >  0000000000093390 0000000000000000 ffffffff814fff78 ffffffff815062a3
> > Call Trace:
> >  [<ffffffff81506cf6>] start_kernel+0x34c/0x3d1
> >  [<ffffffff81506140>] ? early_idt_handler+0x0/0x72
> >  [<ffffffff815062a3>] x86_64_start_reservations+0xa9/0xad
> >  [<ffffffff815063c5>] x86_64_start_kernel+0xfb/0x106
> > 
> > 
> > Code: 48 89 90 e0 02 00 00 48 8b 90 98 02 00 00 48 89 90 e8 02 00 00 48
> > 8b 15 9f da fc ff 48 c7 c0 f0 ca 57 81 48 8b 14 0a 48 83 c1 08 <48> 03
> > 42 08 48 81 f9 00 02 00 00 48 89 00 48 89 40 08 75 d6 5b 
> > RIP  [<ffffffff8151d8b8>] fork_init+0xba/0xd2
> >  RSP <ffffffff814fff08>
> > CR2: 0000000000000008
> > ---[ end trace 4eaa2a86a8e2da22 ]---
> > Kernel panic - not syncing: Attempted to kill the idle task!
> > Pid: 0, comm: swapper Tainted: G      D   2.6.27.5-26rt11 #1
> > 
> > Call Trace:
> >  [<ffffffff8103c1fb>] panic+0xaf/0x167
> >  [<ffffffff811a25c4>] ? account+0xd8/0xe7
> >  [<ffffffff8100c95a>] ? retint_restore_args+0x13/0x20
> >  [<ffffffff81054606>] ? blocking_notifier_call_chain+0xf/0x11
> >  [<ffffffff8103f28d>] do_exit+0x78/0x88e
> >  [<ffffffff811a2775>] ? get_random_bytes+0x1b/0x1d
> >  [<ffffffff812b1a8d>] oops_begin+0x0/0x7c
> >  [<ffffffff812b3f98>] do_page_fault+0x9e5/0xaa8


(gdb) l *0xffffffff8151d8b8
0xffffffff8151d8b8 is in fork_init
(/home/acme/git/paulg-rt-linux-2.6/kernel/fork.c:233).
228		init_task.signal->rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
229		init_task.signal->rlim[RLIMIT_SIGPENDING] =
230			init_task.signal->rlim[RLIMIT_NPROC];
231	
232		for (i = 0; i < NR_CPUS; i++)
233			INIT_LIST_HEAD(&per_cpu(delayed_drop_list, i));
234	}
235	
236	int __attribute__((weak)) arch_dup_task_struct(struct task_struct *dst,
237						       struct task_struct *src)
(gdb)

Here:

232		for (i = 0; i < NR_CPUS; i++)
233                     INIT_LIST_HEAD(&per_cpu(delayed_drop_list, i));

static DEFINE_PER_CPU(struct list_head, delayed_drop_list);

This comes from patch preempt-realtime-mmdrop-delayed.patch, that is
dbcb144fbb8adca0a98c4812e08da4e27e2bfadb in your tree.

- Arnaldo
