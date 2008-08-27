From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Availability rt patch for older linux kernel 2.6.11.3
Date: Wed, 27 Aug 2008 12:41:42 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0808271233350.16059@gandalf.stny.rr.com>
References: <loom.20080825T083613-13@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: robert <robje99@hotmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:56458 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538AbYH0Qlo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Aug 2008 12:41:44 -0400
In-Reply-To: <loom.20080825T083613-13@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 25 Aug 2008, robert wrote:

> Hi,
> 
> I'm currently working with a older linux kernel, 2.6.11.3, running on a 
> powerpc.
> Currently I'm running against realtime performance problems, the reaction time 
> to interrupts is not good enough (sometimes 30 msec, while less then 8 msec is 
> needed).

Wow, 30ms is huge. Have you run this with HZ=1000 and CONFIG_PREEMPT on?

> For this of course, are the realtime patches, but I can find them only for the 
> newer kernels.
> As our kernel is highly adopted to the hardware, I can't just move over to a 
> newer kernel.
> 
> My question is:
> - does anyone know a link for me were I can still find a patch for a 2.6.11.3 
> kernel?

Here's something that is the closest that I can find:

http://rostedt.homelinux.com/private/realtime-preempt-2.6.12-final-V0.7.51-28


> - if they can be found, are these patches mature enough to be used, 
> particularly for a powerpc architecture?

At a quick glance, it has support for ppc. But I need to warn you: This 
patch is very old and may have issues. But perhaps it will work for you.

There is no guarantee that comes with this.

Backporting the latest patch would be very difficult, especially since 
a lot of the -rt work is already in mainline. To do such a thing would 
take at least 6 months of effort.

-- Steve

