From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH] sched/rt: don't try to balance rt_runtime when it is
 futile
Date: Thu, 27 Nov 2014 08:31:17 -0700
Message-ID: <1417102277.3512.109.camel@maggy.simpson.net>
References: <1400080115-12339-1-git-send-email-paul.gortmaker@windriver.com>
	 <20140514154459.GE4570@linux.vnet.ibm.com>
	 <20140514191100.GA24155@windriver.com>
	 <1400122194.5175.18.camel@marge.simpson.net> <5476EC32.9030005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Wanpeng Li <kernellwp@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5476EC32.9030005@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2014-11-27 at 17:17 +0800, Wanpeng Li wrote:

> If the tick is still need to be handled if cpu is isolated w/o nohz full 
> enabled?

"No" would lead to some awkward questions.

	-Mike
