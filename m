From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
 0000000000000038 !//RE: kernel BUG at kernel/locking/rtmutex.c:1027
Date: Mon, 26 Jun 2017 16:54:36 +0200
Message-ID: <20170626145436.npgsaz4eyvnh2j2k@linutronix.de>
References: <2B18E8E1DDAE074A82D1060396451DAE263CBBD6@CNMAILEX04.lenovo.com>
 <20170626102418.310bb1ce@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Feng Feng24 Liu <liufeng24@lenovo.com>,
        Mike Galbraith <efault@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tmac@hp.com" <tmac@hp.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170626102418.310bb1ce@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-06-26 10:24:18 [-0400], Steven Rostedt wrote:
> >  CPU: 17 PID: 1738811 Comm: ip Not tainted 4.4.70-thinkcloud-nfv #1
> >  Hardware name: LENOVO System x3650 M5: -[8871AC1]-/01GR174, BIOS -[TCE124M-2.10]- 06/23/2016
> >  task: ffff881cda2c27c0 ti: ffff881ea0538000 task.ti: ffff881ea0538000
> >  RIP: 0010:[<ffffffff810a2cb4>]  [<ffffffff810a2cb4>] __try_to_take_rt_mutex+0x34/0x160
> >  RSP: 0018:ffff881ea053bb50  EFLAGS: 00010082
> >  RAX: 0000000000000000 RBX: ffff881f805416a8 RCX: 0000000000000000
> >  RDX: ffff881ea053bb98 RSI: ffff881cda2c27c0 RDI: ffff881f805416a8
> >  RBP: ffff881ea053bb60 R08: 0000000000000001 R09: 0000000000000002
> >  R10: 0000000000000a01 R11: 0000000000000001 R12: ffff881cda2c27c0
> >  R13: ffff881cda2c27c0 R14: 0000000000000202 R15: ffff881f6b0c27c0
> >  FS:  00007f28be315740(0000) GS:ffff88205f8c0000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 0000000000000038 CR3: 0000001e9e479000 CR4: 00000000003406e0
> >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >  Stack:
> >   ffff881f805416a8 ffff881ea053bb98 ffff881ea053bc28 ffffffff81a8f03d
> >   ffff881ea053c000 01ff881ea053bb90 ffff881cda2c27c0 ffff881f6b0c27c1
> >   ffff881cda2c2eb0 0000000000000001 0000000000000000 0000000000000000
> >  Call Trace:
> >   [<ffffffff81a8f03d>] rt_spin_lock_slowlock+0x13d/0x390
> >   [<ffffffff81a903bf>] rt_spin_lock+0x1f/0x30
> >   [<ffffffff8141757f>] lockref_get_not_dead+0xf/0x50
> >   [<ffffffff811e0a01>] ns_get_path+0x61/0x1d0
> 
> Hmm, this is in the filesystem code. What were you doing when this
> happened?

and do you have any patches except the RT patch?

> 
> > <4>Jun 24 10:01:19 node-1 kernel: [44959.446268]  [<ffffffff8121eea9>] proc_ns_follow_link+0x89/0xa0
> 
> Do you know what proc file it was reading?
> 
> -- Steve

Sebastian
