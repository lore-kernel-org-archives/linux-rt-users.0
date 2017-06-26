From: Julia Cartwright <julia@ni.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
 0000000000000038 !//RE: kernel BUG at kernel/locking/rtmutex.c:1027
Date: Mon, 26 Jun 2017 10:55:55 -0500
Message-ID: <20170626155555.GB8190@jcartwri.amer.corp.natinst.com>
References: <2B18E8E1DDAE074A82D1060396451DAE263CBBD6@CNMAILEX04.lenovo.com>
 <20170626102418.310bb1ce@gandalf.local.home>
 <20170626145436.npgsaz4eyvnh2j2k@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Feng Feng24 Liu <liufeng24@lenovo.com>,
        Mike Galbraith <efault@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tmac@hp.com" <tmac@hp.com>
To: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170626145436.npgsaz4eyvnh2j2k@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jun 26, 2017 at 04:54:36PM +0200, Sebastian Andrzej Siewior wrote:
> On 2017-06-26 10:24:18 [-0400], Steven Rostedt wrote:
> > >  CPU: 17 PID: 1738811 Comm: ip Not tainted 4.4.70-thinkcloud-nfv #1
> > >  Hardware name: LENOVO System x3650 M5: -[8871AC1]-/01GR174, BIOS -[TCE124M-2.10]- 06/23/2016
> > >  task: ffff881cda2c27c0 ti: ffff881ea0538000 task.ti: ffff881ea0538000
> > >  RIP: 0010:[<ffffffff810a2cb4>]  [<ffffffff810a2cb4>] __try_to_take_rt_mutex+0x34/0x160
> > >  RSP: 0018:ffff881ea053bb50  EFLAGS: 00010082
> > >  RAX: 0000000000000000 RBX: ffff881f805416a8 RCX: 0000000000000000
> > >  RDX: ffff881ea053bb98 RSI: ffff881cda2c27c0 RDI: ffff881f805416a8
> > >  RBP: ffff881ea053bb60 R08: 0000000000000001 R09: 0000000000000002
> > >  R10: 0000000000000a01 R11: 0000000000000001 R12: ffff881cda2c27c0
> > >  R13: ffff881cda2c27c0 R14: 0000000000000202 R15: ffff881f6b0c27c0
> > >  FS:  00007f28be315740(0000) GS:ffff88205f8c0000(0000) knlGS:0000000000000000
> > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >  CR2: 0000000000000038 CR3: 0000001e9e479000 CR4: 00000000003406e0
> > >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > >  Stack:
> > >   ffff881f805416a8 ffff881ea053bb98 ffff881ea053bc28 ffffffff81a8f03d
> > >   ffff881ea053c000 01ff881ea053bb90 ffff881cda2c27c0 ffff881f6b0c27c1
> > >   ffff881cda2c2eb0 0000000000000001 0000000000000000 0000000000000000
> > >  Call Trace:
> > >   [<ffffffff81a8f03d>] rt_spin_lock_slowlock+0x13d/0x390
> > >   [<ffffffff81a903bf>] rt_spin_lock+0x1f/0x30
> > >   [<ffffffff8141757f>] lockref_get_not_dead+0xf/0x50
> > >   [<ffffffff811e0a01>] ns_get_path+0x61/0x1d0
> > 
> > Hmm, this is in the filesystem code. What were you doing when this
> > happened?
> 
> and do you have any patches except the RT patch?

This stack trace looks very familiar to an upstream use-after-free bug
fixed in v4.11 (commit 073c516ff735, "nsfs: mark dentry with
DCACHE_RCUACCESS", attached below), it's tagged for stable, but doesn't
look like it's trickled it's way back to 4.4.y yet.

Can you reproduce this problem reliably?  Can you confirm that the below
fixes it (it'll require some minor cajoling to apply cleanly)?

   Julia

-- 8< --
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 19 Apr 2017 15:11:00 -0700
Subject: [PATCH] nsfs: mark dentry with DCACHE_RCUACCESS

Andrey reported a use-after-free in __ns_get_path():

  spin_lock include/linux/spinlock.h:299 [inline]
  lockref_get_not_dead+0x19/0x80 lib/lockref.c:179
  __ns_get_path+0x197/0x860 fs/nsfs.c:66
  open_related_ns+0xda/0x200 fs/nsfs.c:143
  sock_ioctl+0x39d/0x440 net/socket.c:1001
  vfs_ioctl fs/ioctl.c:45 [inline]
  do_vfs_ioctl+0x1bf/0x1780 fs/ioctl.c:685
  SYSC_ioctl fs/ioctl.c:700 [inline]
  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691

We are under rcu read lock protection at that point:

        rcu_read_lock();
        d = atomic_long_read(&ns->stashed);
        if (!d)
                goto slow;
        dentry = (struct dentry *)d;
        if (!lockref_get_not_dead(&dentry->d_lockref))
                goto slow;
        rcu_read_unlock();

but don't use a proper RCU API on the free path, therefore a parallel
__d_free() could free it at the same time.  We need to mark the stashed
dentry with DCACHE_RCUACCESS so that __d_free() will be called after all
readers leave RCU.

Fixes: e149ed2b805f ("take the targets of /proc/*/ns/* symlinks to separate fs")
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/nsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 1656843e87d2..323f492e0822 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -91,6 +91,7 @@ slow:
 		return ERR_PTR(-ENOMEM);
 	}
 	d_instantiate(dentry, inode);
+	dentry->d_flags |= DCACHE_RCUACCESS;
 	dentry->d_fsdata = (void *)ns->ops;
 	d = atomic_long_cmpxchg(&ns->stashed, 0, (unsigned long)dentry);
 	if (d) {
-- 
2.13.1
