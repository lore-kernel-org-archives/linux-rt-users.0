From: john stultz <johnstul@us.ibm.com>
Subject: Re: Creating the RT git tree
Date: Thu, 29 Jan 2009 14:07:01 -0800
Message-ID: <1f1b08da0901291407q7aeaa13es730bad17abda9b66@mail.gmail.com>
References: <alpine.DEB.1.10.0812161556460.25356@gandalf.stny.rr.com>
	 <1233263200.3937.44.camel@perihelion.bos.jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Clark Williams <clark.williams@gmail.com>,
	Gregory Haskins <ghaskins@novell.com>
To: Jon Masters <jonathan@jonmasters.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:57080 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759589AbZA2WHD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Jan 2009 17:07:03 -0500
In-Reply-To: <1233263200.3937.44.camel@perihelion.bos.jonmasters.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 29, 2009 at 1:06 PM, Jon Masters <jonathan@jonmasters.org> wrote:
> *). I might not be the best git user on the planet (trying to fix that)
> but I would really like to just see the patches that are specific to a
> given topic branch, without the merge noise. For example, a git log on
> the threadirqs branch shows me all the other patches in linus' tree as
> merges are done. I could do a git log --grep="threadirqs" but is there a
> better way? How do I instruct git to show me just the patches added
> specifically in threadirqs?

This seems to work for me:
  git log -r origin/linus..origin/rt/threadirqs

Although git show doesn't seem to like that.

thanks
-john
