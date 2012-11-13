From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Does anyone use CONFIG_TINY_PREEMPT_RCU?
Date: Mon, 12 Nov 2012 16:49:06 -0800
Message-ID: <20121113004906.GA10557@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@elte.hu, laijs@cn.fujitsu.com, dipankar@in.ibm.com,
	akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
	josh@joshtriplett.org, niv@us.ibm.com, tglx@linutronix.de,
	peterz@infradead.org, rostedt@goodmis.org, Valdis.Kletnieks@vt.edu,
	dhowells@redhat.com, edumazet@google.com, darren@dvhart.com,
	fweisbec@gmail.com, sbw@mit.edu, patches@linaro.org
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello!

I know of people using TINY_RCU, TREE_RCU, and TREE_PREEMPT_RCU, but I
have not heard of anyone using TINY_PREEMPT_RCU for whom TREE_PREEMPT_RCU
was not a viable option (in contrast, the people running Linux on
tiny-memmory systems typically use TINY_RCU).  Of course, if no one
really needs it, the proper thing to do is to remove it.

So, if you need TINY_PREEMPT_RCU, please let me know.  Otherwise, I will
remove it, probably in the 3.9 timeframe.

							Thanx, Paul
