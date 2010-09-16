From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: preempt rt in commercial use
Date: Thu, 16 Sep 2010 08:27:51 -0700
Message-ID: <4C923777.6080009@us.ibm.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com> <201009141830.03206@zigzag.lvk.cs.msu.su>	 <4C8F8B79.1010300@theptrgroup.com> <4C8FF52E.1030407@us.ibm.com>	 <4C907A51.1050305@steinhoff.de> <4C90D392.8040808@us.ibm.com>	 <87k4mnhv9h.fsf@lola.goethe.zz> <4C90EE26.8060003@us.ibm.com>	 <877hinhtbb.fsf@lola.goethe.zz> <1284597885.23787.13.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:52571 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409Ab0IPP1z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Sep 2010 11:27:55 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8GFD6WR014855
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Sep 2010 11:13:06 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o8GFRsCq072914
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Sep 2010 11:27:54 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o8GFRrMK017105
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Sep 2010 12:27:54 -0300
In-Reply-To: <1284597885.23787.13.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt wrote:

> Hardware that is less complex is easier to mathematically prove that it
> will do what you expect to do in all cases, than hardware that is over
> engineered, just like software.
> 
> I hold that PREEMPT_RT is not soft real time, but is hard real time
> designed. That is, we can't prove that it is hard real time, but any
> time we find a case that the software can break its deterministic
> result, it is a bug and needs to be fixed. (aka, a system failure).

Which serves to highlight my point about using these terms -- you're
the terms "hard" and "soft" in a different way than a previous poster.
(Assuming "hard real time designed" can get mistaken for "hard real time".

You're saying it's hard because we intend it to meet system deadlines
(regardless of deadline??), and it's a bug if it doesn't.

The previous poster in this list was using it to imply guarantees of
of very specific response times (< xxx us).

You really, really have to talk about the specifics of the environment,
the requirements, the application needs, etc. And I'm missing about
half a dozen "really"'s there.


thanks,
Nivedita
