From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RFC on fixing mutex spinning on owner
Date: Wed, 16 Mar 2016 22:17:51 -0400
Message-ID: <20160316221751.71816309@grimm.local.home>
References: <CAD=GYpbHjcsuQSnNPL4SCv-r=Me6oiH7dJ98a64udbakWLaUjQ@mail.gmail.com>
 <20160316233530.GA8731@kroah.com>
 <CAD=GYpZVGwfk8Y8WTQpdgdm5qgxjsi_gVrnOswuWitEbhaWPbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Greg Kroah-Hartman <greg@kroah.com>,
	linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Joel Fernandes <agnel.joel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=GYpZVGwfk8Y8WTQpdgdm5qgxjsi_gVrnOswuWitEbhaWPbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 16 Mar 2016 16:38:56 -0700
Joel Fernandes <agnel.joel@gmail.com> wrote:

> I am not sure if the problem is with the i915 driver, because the
> mutex spin on owner stuff is mutex related so the mutex design may
> potentially need a tweak (I mentioned a proposal of adding mutex
> spinning time outs).
> Also since this is latency issue related (I mentioned preemptoff
> tracer and preempt disabled), I sent it to linux-rt-users. Thanks for
> the tip about sending it to i915 developers, incase no one here has a
> say in the matter, I can drop them a note later as well.

Actually, the preempt off section here is not really an issue:

	rcu_read_lock();
	while (owner_running(lock, owner)) {
		if (need_resched())
			break;

		cpu_relax_lowlatency();
	}
	rcu_read_unlock();

Although preemption may be disabled, that "need_resched()" check will
break out of the loop if a higher priority task were to want to run on
this CPU.

I probably should add a hook there to let the preemptoff tracer know
that this is not an issue.

Thanks for the report.

-- Steve
