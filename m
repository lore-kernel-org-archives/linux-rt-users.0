From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/3] tracing: Add Hardware Latency detector tracer
Date: Tue, 9 Aug 2016 14:30:36 -0400
Message-ID: <20160809143036.72f9f67b@gandalf.local.home>
References: <20160804145708.158968389@goodmis.org>
	<20160804113033.78132a93@gandalf.local.home>
	<20160809131516.6a83e93e@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Carsten Emde <C.Emde@osadl.org>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jcm@redhat.com>, Daniel Wagner <wagi@monom.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160809131516.6a83e93e@sluggy.hsv.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 9 Aug 2016 13:15:16 -0500
Clark Williams <williams@redhat.com> wrote:

> On Thu, 4 Aug 2016 11:30:33 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Note, I'm currently working on adding code to detect NMIs to this as
> > well. And perhaps even tracing SMI counters. Just to show what caused
> > the latency, as latency isn't measured by the counters (that I know of).
> >   
> 
> I like the trace report, but for one small thing; I think it's worth
> either adding units to the reported latency values (us suffix) or
> putting in a header line that hwlatdetect values are reported in
> microseconds.

Yeah, adding "us" to the time stamps would be useful. I'll update.

-- Steve
