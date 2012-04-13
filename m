From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: SUSE question wrt RT locking primitives
Date: Fri, 13 Apr 2012 08:58:15 -0400
Message-ID: <1334321895.23924.356.camel@gandalf.stny.rr.com>
References: <1321235083-21756-1-git-send-email-jkacur@redhat.com>
	 <1321235083-21756-2-git-send-email-jkacur@redhat.com>
	 <20111114165148.GB2372@linux.vnet.ibm.com>
	 <alpine.LFD.2.00.1111141837100.6707@localhost6.localdomain6>
	 <1321303871.5011.6.camel@frodo>
	 <1334295256.9525.60.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <mgalbraith@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:9925 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab2DMM6S (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Apr 2012 08:58:18 -0400
In-Reply-To: <1334295256.9525.60.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-04-13 at 07:34 +0200, Mike Galbraith wrote:
> Greetings,
> 
> SUSE is looking for a straight up answer, I've been tasked with asking
> the question: can RT maintainers be convinced to fix the RT tree such
> that locking primitives do not switch from 'OK' to TABOO' at the flick
> of a config switch?  It is understood that "yes" may have undesirable
> side-effects :)
> 
> Background:
> 
> The migrate_enable/disable() EXPORT_SYMBOL_GPL thing came up yesterday
> again with yet another customer stuck using yet another proprietary
> driver for proprietary hardware.  The choice for the customer/user is
> use what exists, knock on proprietary doors, or go look at platforms
> where the proprietary gizmo they need or want to use just works.
> 
> So that's where the question comes from.  Life would be easier if RT
> didn't trigger the Dr. Jeckle -> Mr. Hyde thing.  You know all about
> where what happens to which locks, so I'll just snip what I had quoted
> and needlessly commented on to keep this as short as possible ;-)

I have no problem with making those non-GPL, as the original stance of
-rt back in 2005 was to not have -rt be any different than the vanilla
kernel in that regards. But I don't know if that policy changed since
then, nor am I the one that has the authority to remove the GPL tags
from those functions.

-- Steve


