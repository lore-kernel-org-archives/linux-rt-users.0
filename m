From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: preempt rt in commercial use
Date: Thu, 16 Sep 2010 15:38:32 -0400
Message-ID: <1284665912.23787.49.camel@gandalf.stny.rr.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
	 <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com>
	 <201009141830.03206@zigzag.lvk.cs.msu.su>
	 <4C8F8B79.1010300@theptrgroup.com> <4C8FF52E.1030407@us.ibm.com>
	 <4C907A51.1050305@steinhoff.de> <4C90D392.8040808@us.ibm.com>
	 <87k4mnhv9h.fsf@lola.goethe.zz> <4C90EE26.8060003@us.ibm.com>
	 <877hinhtbb.fsf@lola.goethe.zz>
	 <1284597885.23787.13.camel@gandalf.stny.rr.com>
	 <4C923777.6080009@us.ibm.com>
	 <1284658251.23787.39.camel@gandalf.stny.rr.com>
	 <4C926F95.7080009@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Nivedita Singhvi <niv@us.ibm.com>, David Kastrup <dak@gnu.org>,
	linux-rt-users@vger.kernel.org
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:39430 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755952Ab0IPTie (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Sep 2010 15:38:34 -0400
In-Reply-To: <4C926F95.7080009@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2010-09-16 at 21:27 +0200, Armin Steinhoff wrote:
> Hi Steven,
> 
> I don't know what a "long" deadline is ... is is something like this:
> http://harolds-planet.blogspot.com/2006/02/how-to-deal-with-deadlines.html

cute.

> 
> Cheers
> 
> --Armin
> 
> PS: I think you mean a time range where results are treated as delivered 
> timely ?

Yes, I think people understood what I meant. By "long deadline" I meant
the time needed for an event to happen or critical section to finish is
so large that it should be easy for the event to occur or a critical
section to finish within that time range.

In a rate monotonic scenario, I usually consider 3 time ranges. Period,
deadline and runtime. Where, period >= deadline >= runtime. Usually
runtime is deadline - (enough for some delta). Thus, when I say
deadline, that is just a shorter version of "time it takes where a
deadline must be reached".


-- Steve


