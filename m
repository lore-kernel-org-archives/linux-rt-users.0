From: john stultz <johnstul@us.ibm.com>
Subject: Re: lockdep "splat" on v2.6.33.5-rt23
Date: Thu, 24 Jun 2010 10:03:41 -0700
Message-ID: <1277399021.15264.10.camel@work-vm>
References: <alpine.LFD.2.00.1006241725550.22940@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Nick Piggin <npiggin@suse.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006241725550.22940@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2010-06-24 at 17:40 +0200, John Kacur wrote:
> I believe this is related to the dcache scale discussion thread. I've 
> shown this to Peter privately, but thought it would be useful to share it 
> with everyone so we all have the same info.
> The kernel is from tip/rt/2.6.33 up to commit 
> faf35813f204901f85dd0c6b3c5092e0064c6c2f
> It has a lot of debug options enabled, but is not modified.
> The "splat" is very easy to reproduce, it simply occurs when I 
> boot the kernel on my T500.
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> 2.6.33.5-rt23-tip-debug #3
> ---------------------------------------------
> init/1 is trying to acquire lock:
>  (&dentry->d_lock/1){+.+...}, at: [<ffffffff811981be>] 
> shrink_dcache_parent+0x10f/0x2eb
> 
> but task is already holding lock:
>  (&dentry->d_lock/1){+.+...}, at: [<ffffffff811981be>] 
> shrink_dcache_parent+0x10f/0x2eb

This looks like the issue Peter brought up earlier this week. I think
you were cc'ed (although it may have been your gmail account).

It seems my fix for the earlier dput/select_parent race is causing this.
Lockdep doesn't allow us to lock sub-chains, so any time select_parent
descends two directories down, this will trigger.

Right off I'm not sure what to do about it. We can't just revert, since
that will open the race up, and trying to serialize dput/select parent
using something other then the parent/child dentry->d_locks will
probably be akin to the dcache_lock, and will hurt scalability.

I need to read through Nick's new patchset and see how its changed and
try to adapt any fixes to the -rt tree, but that's competing with some
other critical issues I'm working at the moment.

thanks
-john
