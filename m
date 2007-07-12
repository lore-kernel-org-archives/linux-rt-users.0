From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: Forward port of latest RT patch (2.6.21.5-rt20) to 2.6.22
	available
Date: Thu, 12 Jul 2007 08:26:35 -0400
Message-ID: <4695E5BB0200005A0002763E@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <pwil3058@bigpond.net.au>, <jim.houston@ccur.com>,
	<joe.korty@ccur.com>, <rostedt@goodmis.org>, <tglx@linutronix.de>,
	<dwalker@mvista.com>, "David Bahi" <DBahi@novell.com>,
	"Moiz Kohari" <MKohari@novell.com>,
	"Sven Dietrich" <SDietrich@novell.com>, <dsaxena@plexity.net>,
	<williams@redhat.com>, <abogani@texware.it>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:35552 "EHLO
	mcclure.wal.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757399AbXGLM0q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 08:26:46 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-07-12 at 14:07 +0200, Ingo Molnar wrote:
> * Gregory Haskins <ghaskins@novell.com> wrote:
> 
> > Hi Ingo, Thomas, and the greater linux-rt community,
> >   
> > 	I just wanted to let you guys know that our team has a port of 
> > the 21.5-rt20 patch for the 2.6.22 kernel available. [...]
> 
> great! We had the upstream -rt port to .22 in the works too, it was just 
> held up by the hpet breakage - which Thomas managed to fix earlier 
> today. I've released the 2.6.22.1-rt1 patch to the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/

Thats awesome, Ingo!  Thanks!  Could you publish a broken out version as
well?  We found it extremely valuable to be able to bisect this beast
while working on the 21-22 port.

> 
> I took a quick look at the delta between .22.1-rt1 and your rt1 merge, 
> and the delta patch is quite large and i saw no obvious fixes to pick 
> up. Could you please filter out any fixes that you might have in your 
> tree that you think should be applied, and send it to us as a delta 
> against .22.1-rt1? 

Will do


> (And, as Daniel suggested, in the future, could you _please_ use a 
> different naming scheme instead of using up the upstream -rt namespace.)

Yeah, sorry about that.

-Greg
