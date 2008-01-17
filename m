From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24-rc7-rt2 [PATCH] latency tracer fix for ppc32
Date: Wed, 16 Jan 2008 22:26:08 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801162223120.21116@gandalf.stny.rr.com>
References: <1200336080.318.8.camel@localhost.localdomain>
 <20080115162729.GF5859@pengutronix.de> <Pine.LNX.4.58.0801151301550.26624@gandalf.stny.rr.com>
 <20080116120307.GI5859@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Luotao Fu <l.fu@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:45490 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbYAQD0l (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jan 2008 22:26:41 -0500
In-Reply-To: <20080116120307.GI5859@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 16 Jan 2008, Luotao Fu wrote:
>
> I found out that the tracer got stuck on ppc32 platforms because some early
> functions call _mcount before mcount_enabled is initialized at all. I made a
> patch, which marks these functions as notrace to solve this problem. With this
> patch I can successfully boot up our mpc5200b platform and make latency trace.
> (tested with -b switch in cyclictest). Please comment.
>
> I made my patch against the -rt2 tree since the dummy call early_printk() in
> -rt3 conflicts with our implementation of a functional early_printk(). It
> should also work with -rt3 though.
>

Thanks, applied.

But for future reference, if you attach your patch please name it with the
ending of .patch and not .diff. Also do it at a -p1 level and not -p0.

-- Steve
