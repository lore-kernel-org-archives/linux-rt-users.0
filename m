From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.0.14-rt31
Date: Thu, 12 Jan 2012 08:54:44 -0500
Message-ID: <1326376484.7642.65.camel@gandalf.stny.rr.com>
References: <1324525237.5916.114.camel@gandalf.stny.rr.com>
	 <201201121118.34776.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201201121118.34776.tim.sander@hbm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2012-01-12 at 11:18 +0100, Tim Sander wrote:
> Hi Steven
> 
> I have just tested 3.0.14 with some local adaptions. Unfortunatly there we 
> have still two errors here:
> Reboot ( of upstart) fails sometimes fails with the following message:
> "reboot: Unable to execute shutdown: Bad address"

What's the bad address? Was there a kernel oops?

> This problem can probably easily worked around by catching a failed execution 
> and retry, but i am afraid that execution fails more often in other places and 
> leads to silent functionality failures.
> 
> and the running wild ksoftirqd0 most probably after the kernel message:
> "sched: RT throttling activated"

Hmm, that's not good. It means that an RT task is spinning too much.

> It also seems as if the system looks up after running ifconfig. But it seems as 
> if the error only shows up most of the times if i am not around.

s/looks/locks/ ?

If it happens after ifconfig, then obviously that looks to be something
to do with either the network driver or the network stack.

But there's really nothing I can do to look into this without more
information.

-- Steve
