From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 3.14-rt1
Date: Mon, 28 Apr 2014 07:09:44 +0200
Message-ID: <1398661784.30930.33.camel@marge.simpson.net>
References: <20140411185739.GA6644@linutronix.de>
	 <1397918766.5436.16.camel@marge.simpson.net>
	 <1398411635.11930.45.camel@marge.simpson.net>
	 <1398501491.12941.5.camel@marge.simpson.net>
	 <1398520699.28726.22.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Nicholas Mc Guire <der.herr@hofr.at>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60074 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbaD1FJs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Apr 2014 01:09:48 -0400
In-Reply-To: <1398520699.28726.22.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Nicholas,

On Sat, 2014-04-26 at 15:58 +0200, Mike Galbraith wrote: 
> On Sat, 2014-04-26 at 10:38 +0200, Mike Galbraith wrote: 
> > On Fri, 2014-04-25 at 09:40 +0200, Mike Galbraith wrote:
> > 
> > > Hotplug can still deadlock in rt trees too, and will if you beat it
> > > hard.
> > 
> > Box actually deadlocks like so.
> 
> ...
> 
> 3.12-rt looks a bit busted migrate_disable/enable() wise.
> 
> /me eyeballs 3.10-rt (looks better), confirms 3.10-rt hotplug works,
> swipes working code, confirms 3.12-rt now works.  Yup, that was it.

My boxen, including 64 core DL980 that ran hotplug stress for 3 hours
yesterday with pre-pushdown rwlocks, say the migrate_disable/enable
pushdown patches are very definitely busted.

Instead of whacking selective bits, as I did to verify that the rwlock
changes were indeed causing hotplug stress deadlock woes, I'm eyeballing
the lot, twiddling primitives to look like I think they should, after
which I'll let my boxen express their opinions of the result.

-Mike


