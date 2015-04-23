From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 0/4] tracing: Add new hwlat_detector tracer
Date: Thu, 23 Apr 2015 15:50:29 -0700
Message-ID: <CA+55aFzUBvhu1TmFgjfHDF+SGirEbfs0-5KgpxQGG1ZE2UvK3Q@mail.gmail.com>
References: <20150423190825.714359844@goodmis.org>
	<alpine.DEB.2.11.1504232148520.13914@nanos>
	<20150423160925.7d108eaa@gandalf.local.home>
	<alpine.DEB.2.11.1504232211540.13914@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Daniel Wagner <wagi@monom.org>, Jon Masters <jcm@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1504232211540.13914@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Apr 23, 2015 at 1:21 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> But at least on the machines which have the event counter it would be
> usefull to include that information as well.

In fact, I'd argue that we should *not* do this odd magic latency
measurement thing at all, exactly because Intel gave is the SMI
counter, and it's much more likely to be useful in real life. The odd
"stop machine and busy loop adn do magic" thing is a incredibly
invasive hack that sane people will never enable at all, while the
"add support for the hadrware we asked for and got" is a small thing
that we can do on all modern Intel chips, and can be enabled by
default because there is no downside.

                       Linus
