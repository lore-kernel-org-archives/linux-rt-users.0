From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Using patch-2.6.33.7.2-rt30 increases latency and CPU usage?
Date: Tue, 15 May 2012 19:06:41 -0400
Message-ID: <1337123201.6816.2.camel@gandalf.stny.rr.com>
References: <joemui$6v0$1@dough.gmane.org> <joepd0$e4f$1@dough.gmane.org>
	 <4FAAEBF3.10907@netacquire.com> <joetve$hm5$1@dough.gmane.org>
	 <1337103192.14207.340.camel@gandalf.stny.rr.com>
	 <20120515225841.GA25360@grante>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:32627 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966054Ab2EOXGn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 19:06:43 -0400
In-Reply-To: <20120515225841.GA25360@grante>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-05-15 at 17:58 -0500, Grant Edwards wrote:

> Thanks for the tip.  I'll keep that in mind for some other projects
> that would need latency times in the 100-200us range, which should be
> doable.

If it isn't doable, definitely report it. For modern intel hardware, we
are expecting all response times under 100us. Otherwise we consider it a
bug. Except for the cases where the hardware itself is the cause (SMIs
and other nasties).

-- Steve


