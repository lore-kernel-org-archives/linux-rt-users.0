From: Joel Fernandes <agnel.joel@gmail.com>
Subject: Re: RFC on fixing mutex spinning on owner
Date: Wed, 16 Mar 2016 16:38:56 -0700
Message-ID: <CAD=GYpZVGwfk8Y8WTQpdgdm5qgxjsi_gVrnOswuWitEbhaWPbw@mail.gmail.com>
References: <CAD=GYpbHjcsuQSnNPL4SCv-r=Me6oiH7dJ98a64udbakWLaUjQ@mail.gmail.com>
	<20160316233530.GA8731@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Greg Kroah-Hartman <greg@kroah.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160316233530.GA8731@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Greg,

On Wed, Mar 16, 2016 at 4:35 PM, Greg Kroah-Hartman <greg@kroah.com> wrote:
> On Wed, Mar 16, 2016 at 04:22:17PM -0700, Joel Fernandes wrote:
>> Hi,
>>
>> On a fairly recent kernel and android userspace, I am seeing that with
>> i915 driver is in a spin loop waiting for mutex owner to release it
>> (mutex_spin_on_owner).
>
> Why not provide a backtrace to the drm and i915 developers so that they
> can work on this?  The mailing lists you sent this to can't do much
> about this, sorry...

I am not sure if the problem is with the i915 driver, because the
mutex spin on owner stuff is mutex related so the mutex design may
potentially need a tweak (I mentioned a proposal of adding mutex
spinning time outs).
Also since this is latency issue related (I mentioned preemptoff
tracer and preempt disabled), I sent it to linux-rt-users. Thanks for
the tip about sending it to i915 developers, incase no one here has a
say in the matter, I can drop them a note later as well.

Thanks,

Joel
