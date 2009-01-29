From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: Creating the RT git tree
Date: Thu, 29 Jan 2009 17:54:12 -0500
Message-ID: <1233269652.3937.74.camel@perihelion.bos.jonmasters.org>
References: <alpine.DEB.1.10.0812161556460.25356@gandalf.stny.rr.com>
	 <1233263200.3937.44.camel@perihelion.bos.jonmasters.org>
	 <1f1b08da0901291407q7aeaa13es730bad17abda9b66@mail.gmail.com>
	 <1233267328.3937.66.camel@perihelion.bos.jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Clark Williams <clark.williams@gmail.com>,
	Gregory Haskins <ghaskins@novell.com>
To: john stultz <johnstul@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dallas.jonmasters.org ([72.29.103.172]:60299 "EHLO
	dallas.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756524AbZA2WyZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Jan 2009 17:54:25 -0500
In-Reply-To: <1233267328.3937.66.camel@perihelion.bos.jonmasters.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2009-01-29 at 17:15 -0500, Jon Masters wrote:
> On Thu, 2009-01-29 at 14:07 -0800, john stultz wrote:
> 
> > git log -r origin/linus..origin/rt/threadirqs
> 
> Ok. So perhaps it's the branch creation during:
> 
> git checkout -b threadirqs origin/rt/threadirqs
> 
> Because yeah, that does show what I want. This is weird. Is there some
> git expert who can tell me why I'm seeing linus merges in my local
> branch? My local branch should be simply the same as the remote one...

Bah. I think I was just fat-fingering something. Ok, so it does actually
work if I do this:

git log master...threadirqs

or replace master with $whatever. Ok, that's really what I wanted. It
would be nice if a branch could be setup without all the merge history
builtin - that's supposed to be in the rt-master and so forth
branches...but whatever.

Jon.


