From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: softlockup on 3.6.8-rt19
Date: Wed, 5 Dec 2012 16:49:28 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1212051543300.2701@ionos>
References: <12BAC08C-7C55-4BC5-B69E-DC33E023C8BF@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48638 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab2LEPta (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2012 10:49:30 -0500
In-Reply-To: <12BAC08C-7C55-4BC5-B69E-DC33E023C8BF@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 5 Dec 2012, Sven-Thorsten Dietrich wrote:
> 
> This is the softlockup I am seeing on one of our HP blades.
> 
> I haven't fully ruled out bad hardware, trying to reproduce on another machine.
> 
> Sven
> 
> 
> [  128.371195] BUG: soft lockup - CPU#9 stuck for 22s! [git:6333]
> [  132.387637] BUG: soft lockup - CPU#10 stuck for 23s! [agetty:674]
> [  144.398987] BUG: soft lockup - CPU#11 stuck for 22s! [flush-8:0:336]
> [  156.353376] BUG: soft lockup - CPU#9 stuck for 22s! [git:6333]
> [  160.369814] BUG: soft lockup - CPU#10 stuck for 22s! [agetty:674]
> [  192.330459] BUG: soft lockup - CPU#9 stuck for 23s! [git:6333]
> [  192.349444] BUG: soft lockup - CPU#10 stuck for 23s! [agetty:674]
> [  192.368428] BUG: soft lockup - CPU#11 stuck for 23s! [flush-8:0:336]
> [  195.632116] BUG: spinlock lockup suspected on CPU#9, git/6333
> [  195.632122] general protection fault: 0000 [#1] PREEMPT SMP 

So we fault in spin_dump. Which is not surprising when we decode the
faulting instruction:

	 44 8b 83 e4 02 00 00 	mov    0x2e4(%rbx),%r8d

> [  195.632138] RIP: 0010:[<ffffffff816438c1>]  [<ffffffff816438c1>] spin_dump+0x56/0x91
> [  195.632138] RSP: 0000:ffff880be0077818  EFLAGS: 00010206
> [  195.632139] RAX: 0000000000000031 RBX: 1067a77cb2247fcc RCX: 0000000000000871

RBX contains a random number. Ditto in the next dump on CPU10

> [  200.084385] BUG: spinlock lockup suspected on CPU#10, agetty/674
> [  200.084388] general protection fault: 0000 [#2] PREEMPT SMP 

> [  200.084403] RIP: 0010:[<ffffffff816438c1>]  [<ffffffff816438c1>] spin_dump+0x56/0x91
> [  200.084403] RSP: 0018:ffff8805e03877a8  EFLAGS: 00010286
> [  200.084404] RAX: 0000000000000034 RBX: cdc5c4fabb8bf87b RCX: 00000000000008d5

0000000000000000 <spin_dump>:
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	41 54                	push   %r12
   6:	49 89 fc             	mov    %rdi,%r12
   9:	53                   	push   %rbx
   a:	48 8b 5f 10          	mov    0x10(%rdi),%rbx

RBX is initialized with lock->owner (0ffset 0x10 of lock)

   e:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  15:	48 8d 43 ff          	lea    -0x1(%rbx),%rax
  19:	48 83 f8 fe          	cmp    $0xfffffffffffffffe,%rax
  1d:	b8 00 00 00 00       	mov    $0x0,%eax
  22:	48 0f 43 d8          	cmovae %rax,%rbx
  26:	65 48 8b 04 25 00 00 	mov    %gs:0x0,%rax
  2d:	00 00 
  2f:	44 8b 80 e4 02 00 00 	mov    0x2e4(%rax),%r8d
  36:	48 8d 88 90 04 00 00 	lea    0x490(%rax),%rcx
  3d:	31 c0                	xor    %eax,%eax
  3f:	65 8b 14 25 00 00 00 	mov    %gs:0x0,%edx
  46:	00 
  47:	e8 00 00 00 00       	callq  4c <spin_dump+0x4c>
  4c:	48 85 db             	test   %rbx,%rbx
  4f:	45 8b 4c 24 08       	mov    0x8(%r12),%r9d

Here we read lock->owner_cpu into R9. Random numbers as well:

     R09: 000000004642dad1

     R09: 0000000017f07438

  54:	74 10                	je     66 <spin_dump+0x66>
  56:	44 8b 83 e4 02 00 00 	mov    0x2e4(%rbx),%r8d

And of course here we crash. Let's look at the call chain

> [  200.084416]  [<ffffffff81343189>] do_raw_spin_lock+0xf9/0x140
> [  200.084417]  [<ffffffff81649f44>] _raw_spin_lock+0x44/0x50
> [  200.084418]  [<ffffffff81648d63>] ? rt_spin_lock_slowlock+0x43/0x380
> [  200.084420]  [<ffffffff81648d63>] ? rt_spin_lock_slowlock+0x43/0x380
> [  200.084421]  [<ffffffff81648d63>] rt_spin_lock_slowlock+0x43/0x380
> [  200.084422]  [<ffffffff81649817>] rt_spin_lock+0x27/0x60
> [  200.084424]  [<ffffffff8113f4bd>] __lru_cache_add+0x5d/0x1f0

That's the per cpu local lock swap_lock protecting the pagevec
operations. So something is corrupting the per cpu locks really badly.

The lock addresses look reasonably:

CPU9:	 R12: ffff880bc1867c00
CPU10:	 R12: ffff880bc1887c00
CPU11:	 R12: ffff880bc18a7c00

That's a spacing of 20000H per cpu.

I really have no idea what scribbles over those locks. Can you check
what is next to those locks in the per_cpu area ?

Thanks,

	tglx
