From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH 2/3] read_lock migrate_disable pushdown to rt_read_lock
Date: Sat, 25 Jan 2014 09:29:21 +0100
Message-ID: <20140125082921.GA3831@opentech.at>
References: <20131205234449.GF15603@opentech.at> <20131205211951.5c2eaa0f@gandalf.local.home> <20131206023334.GA26623@opentech.at> <20131206102532.712d4ae4@gandalf.local.home> <20131215151511.GI31090@linutronix.de> <20140124124216.GB10264@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org,
	Andreas Platschek <platschek@ict.tuwien.ac.at>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Carsten Emde <carsten.emde@osadl.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140124124216.GB10264@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 24 Jan 2014, Sebastian Andrzej Siewior wrote:

> * Sebastian Andrzej Siewior | 2013-12-15 16:15:11 [+0100]:
> 
> >* Steven Rostedt | 2013-12-06 10:25:32 [-0500]:
> >
> >>
> >>Let me analyze the original code first. I'll poke peterz and tglx too
> >>to make sure this modification is OK.
> >
> >I took 1/3. I postpone the remaining two until I hear something from
> >you.
> 
> Any news?
>
Carsten Emde added the two patches

   0001-write_lock-migrate_disable-pushdown-to-rt_write_lock.patch
   0002-read_lock-migrate_disable-pushdown-to-rt_read_lock.patch

to the -rt9 test on one of his ARM boards (i.MX6 Sabre automation board)
in the OSADL QA-Farm (rack #9/slot #8)

<snip Carsten Emde>
No complaints so far after adding your patches.

If you would like to follow up:
- Profile: https://www.osadl.org/?id=1822
- Patches: https://www.osadl.org/?id=1822#patches
- Latency plot: https://www.osadl.org/?id=1823
- Munin:
https://www.osadl.org/munin/osadl.org/rack9slot8.osadl.org/index.html
<snip>
 
so it atleast seems to be passing basic testing.

I have an AMD Phenom X4 and Intel i3 running -rt9 with those two patches
applied running stable now for 2 days under alternating load/idle conditions
as well. Unfortunately no further feedback up to now.

Given that its a low-level locking issue I guess that more testing is of little
help and code-reviews would be essential. Notably if any cases could exist
where the order of preempt_disable/lock critical-section unlock/preempt_enable
actually does natter.

thx!
hofrat
