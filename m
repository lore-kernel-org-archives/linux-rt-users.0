From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Tue, 21 Apr 2015 09:18:57 -0400
Message-ID: <20150421091857.03d2b587@gandalf.local.home>
References: <20150418133444.GD23685@linux.vnet.ibm.com>
	<20150418143238.GA2337@gmail.com>
	<20150419020541.GA5561@linux.vnet.ibm.com>
	<20150420113554.598e503f@sluggy>
	<20150420170902.GU5561@linux.vnet.ibm.com>
	<20150420180107.GE24936@home.goodmis.org>
	<20150420180904.GA19229@gmail.com>
	<20150420142149.3ac58a2c@gandalf.local.home>
	<20150420182831.GA19510@gmail.com>
	<20150420143440.49e1e537@gandalf.local.home>
	<20150421064222.GA22291@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	a.p.zijlstra@chello.nl, akpm@linux-foundation.org,
	linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150421064222.GA22291@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 21 Apr 2015 08:42:23 +0200
Ingo Molnar <mingo@kernel.org> wrote:


> Note that modern scheduler policies, like SCHED_DEADLINE, get all 
> their policy parameters from the sched_setparam() user-space ABI, they 
> are not driven by sysctls.

Right, and when I realized that we can do the same with chrt, I
suggested using that. Clark thought that the prio of the rcu threads
always went back to the hard coded value set at compile time. I looked
at the code and didn't see that and then asked Paul about it. Seems
chrt should work. Before my argument was based on not having any way at
run time to change the rcu priorities, which I feel is bad. But if
there is a way, then that should be what we tell users to use.

-- Steve
