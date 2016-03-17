From: Joel Fernandes <agnel.joel@gmail.com>
Subject: Re: RFC on fixing mutex spinning on owner
Date: Wed, 16 Mar 2016 22:35:21 -0700
Message-ID: <CAD=GYpbFRP5W2aNLpUoDtuK8Ebn+ki9JDGkBMS45nKVkc2wdSQ@mail.gmail.com>
References: <CAD=GYpbHjcsuQSnNPL4SCv-r=Me6oiH7dJ98a64udbakWLaUjQ@mail.gmail.com>
	<20160316233530.GA8731@kroah.com>
	<CAD=GYpZVGwfk8Y8WTQpdgdm5qgxjsi_gVrnOswuWitEbhaWPbw@mail.gmail.com>
	<20160316221751.71816309@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <greg@kroah.com>,
	linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160316221751.71816309@grimm.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Mar 16, 2016 at 7:17 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 16 Mar 2016 16:38:56 -0700
> Joel Fernandes <agnel.joel@gmail.com> wrote:
>
> > I am not sure if the problem is with the i915 driver, because the
> > mutex spin on owner stuff is mutex related so the mutex design may
> > potentially need a tweak (I mentioned a proposal of adding mutex
> > spinning time outs).
> > Also since this is latency issue related (I mentioned preemptoff
> > tracer and preempt disabled), I sent it to linux-rt-users. Thanks for
> > the tip about sending it to i915 developers, incase no one here has a
> > say in the matter, I can drop them a note later as well.
>
> Actually, the preempt off section here is not really an issue:
>
>         rcu_read_lock();
>         while (owner_running(lock, owner)) {
>                 if (need_resched())
>                         break;
>
>                 cpu_relax_lowlatency();
>         }
>         rcu_read_unlock();
>
> Although preemption may be disabled, that "need_resched()" check will
> break out of the loop if a higher priority task were to want to run on
> this CPU.
>
> I probably should add a hook there to let the preemptoff tracer know
> that this is not an issue.

Thanks Steve! That makes sense. If you do end up adding this hook to
the tracer, I would appreciate it if you could Cc me on the patch so I
could back port it to my kernel as well.

Also, since we are on the topic of preemptoff tracer, I posted a patch
[1] few days ago fixing another issue, if it looks Ok to you could you
pick it up? I had CC'd you on it.

[1] http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1099561.html

Thanks,
Joel
