From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/4] munmap: Flexible mem unmap operation interface for
 scheduling latency
Date: Tue, 26 Apr 2011 08:30:49 -0400
Message-ID: <1303821049.18763.20.camel@gandalf.stny.rr.com>
References: <1303728272-11408-1-git-send-email-leemgs1@gmail.com>
	 <1303760837.4865.22.camel@laptop>
	 <1303763393.18763.16.camel@gandalf.stny.rr.com>
	 <1303802720.20212.7.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Geunsik Lim <leemgs1@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
	Darren Hart <dvhart@linux.intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303802720.20212.7.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2011-04-26 at 09:25 +0200, Peter Zijlstra wrote:
> On Mon, 2011-04-25 at 16:29 -0400, Steven Rostedt wrote:
> > On Mon, 2011-04-25 at 21:47 +0200, Peter Zijlstra wrote:
> > 
> > > Also, -rt doesn't care since it already has preemptible mmu_gather.
> > 
> > To be fair, he did state:
> > 
> > >     In general, This is not a critical latency-path on preemption mode
> > >     (PREEMPT_VOLUNTARY / PREEMPT_DESKTOP / PREEMPT_RT)
> 
> That doesn't parse for me... what does it say? The only one not listed
> is the non-preempt option, that wouldn't reschedule no matter what
> ZAP_BLOCK_SIZE.

Heh, it didn't parse for me, as I took PREEMPT_DESKTOP and thought it
said PREEMPT_NONE.

Oh well.

-- Steve
