From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 3.14.23-rt20
Date: Sun, 02 Nov 2014 08:30:27 +0100
Message-ID: <1414913427.5380.110.camel@marge.simpson.net>
References: <20141031170326.1491a63f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141031170326.1491a63f@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2014-10-31 at 17:03 -0400, Steven Rostedt wrote:
> Dear RT Folks,
> 
> I'm pleased to announce the 3.14.23-rt20 stable release.
> 
> This is the first 3.14-rt release in the stable-rt series. Normally I
> wait till the next development release is out before I pull in a new
> one. That is, I would pull in 3.14-rt when 3.16-rt or later was
> released. But because development is now moving at a "hobbyist rate" 
> (read http://lwn.net/Articles/617140/ for details)
> and 3.14-rt is no longer being developed against, I figured it was
time
> to put it under the "stable-rt" umbrella.

I piddled about with it yesterday, found that you can't change cpufreq
governor IFF the tree is configured as rt, but works fine as voluntary
preempt.  I'll poke about for the entertainment value.  Having no
personal need/use for rt detracts from its hobby value somewhat, but rt
problems do have a tendency to be 'entertaining'.

I'll follow up with a few patches that folks can apply to their trees if
they so desire.  There being no devel tree to submit against, I can't do
a proper submission (rules), and some of them you surely don't want :) 

	-Mike
