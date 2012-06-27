From: Tim Sally <tsally@atomicpeace.com>
Subject: Re: Fwd: BUG: scheduling while atomic: chcpu/6197/0x00000002
Date: Wed, 27 Jun 2012 10:01:19 -0400
Message-ID: <20120627140119.GA8681@atomicpeace.com>
References: <4FDF00CB.7090703@med.uni-frankfurt.de>
 <4FDF201E.2090408@med.uni-frankfurt.de>
 <4FE19494.6000303@med.uni-frankfurt.de>
 <4FE86067.9010408@med.uni-frankfurt.de>
 <4FEAF165.9090008@med.uni-frankfurt.de>
 <CAFLxGvzYE=PctjXJkEvfYBqe2sDsiJW_PW0tYMjvXnUJGou9HQ@mail.gmail.com>
 <1340800622.16702.1.camel@gandalf.stny.rr.com>
 <4FEB0B56.9050509@med.uni-frankfurt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	richard -rw- weinberger <richard.weinberger@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Sattler <sattler@med.uni-frankfurt.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from atomicpeace.com ([50.116.19.59]:51090 "EHLO atomicpeace.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755850Ab2F0OJ0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jun 2012 10:09:26 -0400
Content-Disposition: inline
In-Reply-To: <4FEB0B56.9050509@med.uni-frankfurt.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm interested in this as well. -Tim

On Wed, Jun 27, 2012 at 03:32:06PM +0200, Thomas Sattler wrote:
> > I believe CPU hotplug is still an issue with -rt, and
> > this is a known problem.
> 
> Is there an (un-)official list of known problems? I'd
> like to help by reporting issues without repeating
> already known issues over and over again. :-)
> 
> Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
