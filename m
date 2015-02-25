From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 1/2] rwsem-rt: Do not allow readers to nest
Date: Wed, 25 Feb 2015 13:15:57 +0100
Message-ID: <54EDBCFD.5030307@linutronix.de>
References: <20140409024700.702797305@goodmis.org>	<20140409025231.998774075@goodmis.org>	<20150218195710.GH28763@linutronix.de> <20150218151352.2968cf06@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150218151352.2968cf06@grimm.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 02/18/2015 09:13 PM, Steven Rostedt wrote:

>> Here the same thing but without cmpxchg(). _If_ after an increment the
>> value is negative then we take slowpath. Otherwise we have the lock.
> 
> OK, so I need to make it so it can nest with trylock. I have to look at
> the patch again because it has been a while.

I have reverted the patch and can confirm that cpufreq works again.

I did some testing on vanilla and -RT:
- down_read(l) + down_read(l)
  this triggers a lockdep warning about a possible deadlock the lock is
  obtained.

- down_read(l) + down_read_trylock()
  this passes without a warning.

So I think we good now.

> An RW sem must not do two down_read()s on the same lock (it's fine for
> a trylock if it has a fail safe for it). The reason is, the second
> down_read() will block if there's a writer waiting. Thus you are
> guaranteed a deadlock if you have the lock for read, a write comes in
> and waits, and you grab the RW sem again, because it will block, and
> the writer is waiting for the reader to release. Thus you have a
> deadlock.

I fully understand. However nesting is allowed according to the code in
vanilla and now again in -RT. Lockdep complains properly so we should
catch people doing it wrong in both trees.

> I'll have to revisit this. I also need to revisit the multi readers
> (although Thomas hates it, but he even admitted there's a better way to
> do it. Now only if I could remember what that was ;-)

Okay. For now I keep the revert since it looks sane and simple.

> 
> Thanks,
> 
> -- Steve

Sebastian
