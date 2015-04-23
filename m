From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/4] tracing: Add new hwlat_detector tracer
Date: Thu, 23 Apr 2015 19:23:37 -0400
Message-ID: <20150423192337.28bd4d33@gandalf.local.home>
References: <20150423190825.714359844@goodmis.org>
	<alpine.DEB.2.11.1504232148520.13914@nanos>
	<20150423160925.7d108eaa@gandalf.local.home>
	<alpine.DEB.2.11.1504232211540.13914@nanos>
	<CA+55aFzUBvhu1TmFgjfHDF+SGirEbfs0-5KgpxQGG1ZE2UvK3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Daniel Wagner <wagi@monom.org>, Jon Masters <jcm@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzUBvhu1TmFgjfHDF+SGirEbfs0-5KgpxQGG1ZE2UvK3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 23 Apr 2015 15:50:29 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Apr 23, 2015 at 1:21 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > But at least on the machines which have the event counter it would be
> > usefull to include that information as well.
> 
> In fact, I'd argue that we should *not* do this odd magic latency
> measurement thing at all, exactly because Intel gave is the SMI
> counter, and it's much more likely to be useful in real life. The odd
> "stop machine and busy loop adn do magic" thing is a incredibly
> invasive hack that sane people will never enable at all, while the

No sane person should enable this on any production machine, and nor
should they use the other latency tracer (irqsoff and friends). But we
have used this odd magic latency measurement in dealings with vendors
and such in certifying their machines. Thus, this has not been
something that we just wanted to throw into the kernel for fun. This
tool has actually been very helpful to us.

> "add support for the hadrware we asked for and got" is a small thing
> that we can do on all modern Intel chips, and can be enabled by
> default because there is no downside.
> 

What about a mix and match tracer? If the hardware supports SMI
counters (and more importantly, SMI cycle counters), it will just use
that, otherwise if the hardware does not support the SMI counting, it
falls back to the odd magic latency measurement thing.

I could even make the odd magic latency measurement thing only be
enabled via a tracer flag, such that it would be safe to use the SMI
counter if supported, but if it isn't supported, a tracing message will
display info about the more invasive (not to be used in production
environment) measurement. But the more invasive version will only be
activated if the user explicitly set it (even if SMI counters were not
available).

And when this was first proposed, it was called smi_detector, and I
believe it was Andrew that suggested to rename it to hwlat_detector,
because it could theoretically, detect other types of hardware issues
that could stop the CPU, in case something like that ever arise.

-- Steve
