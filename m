From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [btrfs/rt] lockdep false positive
Date: Wed, 25 Jan 2017 18:02:09 +0100
Message-ID: <20170125170209.h6tqr6zgaq6ojmco@linutronix.de>
References: <1485074793.4467.49.camel@gmail.com>
 <1485107114.4467.73.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485107114.4467.73.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-01-22 18:45:14 [+0100], Mike Galbraith wrote:
> RT does not have a way to describe its rwlock semantics to lockdep,
> leading to the btrfs false positive below.  Btrfs maintains an array
> of keys which it assigns on the fly in order to avoid false positives
> in stock code, however, that scheme depends upon lockdep knowing that
> read_lock()+read_lock() is allowed within a class, as multiple locks
> are assigned to the same class, and end up acquired by the same task.

read_lock(A)+read_lock(A) of the same lock is okay because the lock is
already held and a writer is blocked. Lockdep won't see the second lock.
That means the second read_lock() is also successful if we have a writer
waiting after the first read_lock().

> [  341.960754] =============================================
> [  341.960754] [ INFO: possible recursive locking detected ]
> [  341.960756] 4.10.0-rt1-rt #124 Tainted: G            E  
> [  341.960756] ---------------------------------------------
> [  341.960757] kworker/u8:9/2039 is trying to acquire lock:
> [  341.960757]  (btrfs-tree-00){+.+...}, at: [<ffffffffa036fd15>] btrfs_clear_lock_blocking_rw+0x55/0x100 [btrfs]
> 
> This kworker assigned this lock to class 'tree' level 0 shortly
> before acquisition, however..
> 
> [  341.960783] 
> [  341.960783]  but task is already holding lock:
> [  341.960783]  (btrfs-tree-00){+.+...}, at: [<ffffffffa036fd15>] btrfs_clear_lock_blocking_rw+0x55/0x100 [btrfs]
> 
> ..another kworker previously assigned another lock we now hold to the
> 'tree' level 0 key as well.  Since RT tells lockdep that read_lock() is an
> exclusive acquisition, in class read_lock()+read_lock() is forbidden.

Hmm. So if you have kworker1 doing
	read_lock(A), read_lock(B)
and kworker2 doing
	read_lock(B), read_lock(A)

then this is something that will work fine on mainline (assuming that
neither B nor A is write-locked by something that depends one something
that is done / held by kworker1 or kworker2). However on -RT it might
deadlock because a read lock can only be taken recursively on -RT. That
means you can't have two kworkers holding the same lock at the time. One
of them will be blocked until reader lock is release. For the
non-recursively case a reader-lock on -RT behaves like a "normal" lock.
So yes, it is an exclusive acquisition.

> [  341.960794]        CPU0
> [  341.960795]        ----
> [  341.960795]   lock(btrfs-tree-00);
> [  341.960795]   lock(btrfs-tree-00);
> [  341.960796] 
> [  341.960796]  *** DEADLOCK ***
> [  341.960796]
> [  341.960796]  May be due to missing lock nesting notation
> [  341.960796]
> [  341.960796] 6 locks held by kworker/u8:9/2039:
> [  341.960797]  #0:  ("%s-%s""btrfs", name){.+.+..}, at: [<ffffffff8109f711>] process_one_work+0x171/0x700
> [  341.960812]  #1:  ((&work->normal_work)){+.+...}, at: [<ffffffff8109f711>] process_one_work+0x171/0x700
> [  341.960815]  #2:  (sb_internal){.+.+..}, at: [<ffffffffa032d4f7>] start_transaction+0x2a7/0x5a0 [btrfs]
> [  341.960825]  #3:  (btrfs-tree-02){+.+...}, at: [<ffffffffa036fd15>] btrfs_clear_lock_blocking_rw+0x55/0x100 [btrfs]
> [  341.960835]  #4:  (btrfs-tree-01){+.+...}, at: [<ffffffffa036fd15>] btrfs_clear_lock_blocking_rw+0x55/0x100 [btrfs]
> [  341.960854]  #5:  (btrfs-tree-00){+.+...}, at: [<ffffffffa036fd15>] btrfs_clear_lock_blocking_rw+0x55/0x100 [btrfs]
> 
> Attempting to describe RT rwlock semantics to lockdep prevents this.

and this is what I don't get. I stumbled upon this myself [0] but didn't
fully understand the problem (assuming this is the same problem colored
differently).
With your explanation I am not sure if I get what is happening. If btrfs
is taking here read-locks on random locks then it may deadlock if
another btrfs-thread is doing the same and need each other's locks.
If btrfs takes locks recursively which it already holds (in the same
context / process) then it shouldn't be visible here because lockdep
does not account this on -RT.
If btrfs takes the locks in a special order for instance only ascending
according to inode's number then it shouldn't deadlock.

[0] https://www.spinics.net/lists/linux-btrfs/msg61423.html

> 
> Not-signed-off-by: /me

Sebastian
