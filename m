From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH RT] rwsem: The return of multi-reader PI rwsems
Date: Thu, 10 Apr 2014 23:25:42 -0400
Message-ID: <20140410232542.23ee9920@gandalf.local.home>
References: <20140409151922.5fa5d999@gandalf.local.home>
	<1397139510.5137.92.camel@marge.simpson.net>
	<1397140123.5137.99.camel@marge.simpson.net>
	<1397184626.5139.24.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397184626.5139.24.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 11 Apr 2014 04:50:26 +0200
Mike Galbraith <umgwanakikbuti@gmail.com> wrote:

> Oh, there was another useful bit. 
> 
> 3.12.17-rt25       403991     384216     377786
>                    405466     394011     392850
> 
> 3.12.17-nopreempt  109049     186133     118766  !?!.. ew, TTWU_QUEUE
>                    350385     318786     367336  !TTWU_QUEUE
>                    326009     356939     378215  !TTWU_QUEUE
> 
> IPI == low-pass filter.

I'm sorry, but I don't have the foggiest clue to what the above means.

-- Steve
