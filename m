From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] [RFC] RT: Optionally allow IRQF_NODELAY on serial
 console
Date: Mon, 8 Oct 2007 10:41:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710081037420.5290@gandalf.stny.rr.com>
References: <20071005153517.24349.62653.stgit@ghaskins-t60p.haskins.net>
 <alpine.LRH.0.999.0710051831000.10191@www.tglx.de>
 <Pine.LNX.4.58.0710081005320.4846@gandalf.stny.rr.com>
 <1191853361.4281.5.camel@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@elte.hu,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:55863 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbXJHOle (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Oct 2007 10:41:34 -0400
In-Reply-To: <1191853361.4281.5.camel@ghaskins-t60p.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Mon, 8 Oct 2007, Gregory Haskins wrote:
>
> Hi Steve,
>   What you describe is exactly what I did.  The IRQF_NODELAY handler
> just minimally checks to see if the character is a sysrq related one (or
> KDB, if you have the KDB patches applied).  If it is not, it puts the
> character into a ring-buffer and wakes a (kthread-based) tasklet to do
> the normal serial/tty rx path by processing the ring.

Ah, that was in the second patch (I didn't look at that. My fault). I
didn't see this description in the comments. But you are right, it is very
close to what I did too. But before we add this to -rt, it will need to
probably need to be tested quite a bit more. Especially since this is more
to help us developers than to help end users.

I would like to see something like this eventually make it into RT.  Just
because there has been too many times that this would be useful. For now I
just use the NMI watchdog and soft lockup detect. But those are very
limiting.

>
> Hope that helps to clarify.

Yes, thanks!

-- Steve
