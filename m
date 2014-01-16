From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/2] preempt: Track unmatched preempt_enable() to
 preempt_disable()
Date: Thu, 16 Jan 2014 12:42:07 -0500
Message-ID: <20140116124207.2065b153@gandalf.local.home>
References: <20140116171824.748919700@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140116171824.748919700@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 16 Jan 2014 12:18:24 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Back in the original real-time patch there was a nice debug feature
> that tracked where preemption was disabled and not matched by a preempt
> enable. This information made debugging scheduling while atomic much
> easier, especially when a function was buried in a function chain
> that happened just before the schedule. For example:
> 

> Although this bug does not happen often, this feature is extremely helpful
> when it does. I decided to take Ingo's code, which was just written for
> debugging the -rt patch, and clean it up for something that is suitable
> for mainline.
> 

Hmm, I rewrote this prologue a few times, and even though patch 2 states
this, I want to make it clear that the original feature, that this is
based on, was written by Ingo Molnar. I had it clear in my original
version of the prologue, but somehow it was deleted.

-- Steve
