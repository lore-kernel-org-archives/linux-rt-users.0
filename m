From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH] sched/rt: don't try to balance rt_runtime when it is
 futile
Date: Sun, 18 May 2014 10:36:41 +0200
Message-ID: <1400402201.5166.13.camel@marge.simpson.net>
References: <1400080115-12339-1-git-send-email-paul.gortmaker@windriver.com>
	 <20140514154459.GE4570@linux.vnet.ibm.com>
	 <1400123931.5175.38.camel@marge.simpson.net>
	 <1400386954.5140.36.camel@marge.simpson.net>
	 <20140518052039.GF4570@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140518052039.GF4570@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2014-05-17 at 22:20 -0700, Paul E. McKenney wrote:

> If you are saying that turning on nohz_full doesn't help unless you
> also ensure that there is only one runnable task per CPU, I completely
> agree.  If you are saying something else, you lost me.  ;-)

Yup, that's it more or less.  It's not only single task loads that could
benefit from better isolation, but if isolation improving measures are
tied to nohz_full, other sensitive loads will suffer if they try to use
isolation improvements.

-Mike
