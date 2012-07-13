From: Chris Mason <chris.mason@fusionio.com>
Subject: Re: 3.4.4-rt13: btrfs + xfstests 006 = BOOM..  and a bonus rt_mutex
 deadlock report for absolutely free!
Date: Fri, 13 Jul 2012 08:50:43 -0400
Message-ID: <20120713125043.GH30128@shiny>
References: <1342072060.7338.102.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1342072060.7338.102.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Jul 11, 2012 at 11:47:40PM -0600, Mike Galbraith wrote:
> Greetings,

[ deadlocks with btrfs and the recent RT kernels ]

I talked with Thomas about this and I think the problem is the
single-reader nature of the RW rwlocks.  The lockdep report below
mentions that btrfs is calling:

> [  692.963099]  [<ffffffff811fabd2>] btrfs_clear_path_blocking+0x32/0x70

In this case, the task has a number of blocking read locks on the btrfs buffers,
and we're trying to turn them back into spinning read locks.  Even
though btrfs is taking the read rwlock, it doesn't think of this as a new
lock operation because we were blocking out new writers.

If the second task has taken the spinning read lock, it is going to
prevent that clear_path_blocking operation from progressing, even though
it would have worked on a non-RT kernel.

The solution should be to make the blocking read locks in btrfs honor the
single-reader semantics.  This means not allowing more than one blocking
reader and not allowing a spinning reader when there is a blocking
reader.  Strictly speaking btrfs shouldn't need recursive readers on a
single lock, so I wouldn't worry about that part.

There is also a chunk of code in btrfs_clear_path_blocking that makes
sure to strictly honor top down locking order during the conversion.  It
only does this when lockdep is enabled because in non-RT kernels we
don't need to worry about it.  For RT we'll want to enable that as well.

I'll give this a shot later today.

-chris
