From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Fwd: BUG: scheduling while atomic: chcpu/6197/0x00000002
Date: Wed, 27 Jun 2012 10:21:16 -0400
Message-ID: <1340806876.16702.13.camel@gandalf.stny.rr.com>
References: <4FDF00CB.7090703@med.uni-frankfurt.de>
	 <4FDF201E.2090408@med.uni-frankfurt.de>
	 <4FE19494.6000303@med.uni-frankfurt.de>
	 <4FE86067.9010408@med.uni-frankfurt.de>
	 <4FEAF165.9090008@med.uni-frankfurt.de>
	 <CAFLxGvzYE=PctjXJkEvfYBqe2sDsiJW_PW0tYMjvXnUJGou9HQ@mail.gmail.com>
	 <1340800622.16702.1.camel@gandalf.stny.rr.com>
	 <4FEB0B56.9050509@med.uni-frankfurt.de>
	 <20120627140119.GA8681@atomicpeace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Sattler <sattler@med.uni-frankfurt.de>,
	richard -rw- weinberger <richard.weinberger@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Tim Sally <tsally@atomicpeace.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:18302 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab2F0OVS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jun 2012 10:21:18 -0400
In-Reply-To: <20120627140119.GA8681@atomicpeace.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-06-27 at 10:01 -0400, Tim Sally wrote:
> I'm interested in this as well. -Tim
> 
> On Wed, Jun 27, 2012 at 03:32:06PM +0200, Thomas Sattler wrote:
> > > I believe CPU hotplug is still an issue with -rt, and
> > > this is a known problem.
> > 
> > Is there an (un-)official list of known problems? I'd
> > like to help by reporting issues without repeating
> > already known issues over and over again. :-)

Unfortunately, I do not believe such a list exists. Perhaps one should
be created ;-)

-- Steve


