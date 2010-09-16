From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 20:44:45 -0400
Message-ID: <1284597885.23787.13.camel@gandalf.stny.rr.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
	 <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com>
	 <201009141830.03206@zigzag.lvk.cs.msu.su>
	 <4C8F8B79.1010300@theptrgroup.com> <4C8FF52E.1030407@us.ibm.com>
	 <4C907A51.1050305@steinhoff.de> <4C90D392.8040808@us.ibm.com>
	 <87k4mnhv9h.fsf@lola.goethe.zz> <4C90EE26.8060003@us.ibm.com>
	 <877hinhtbb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: David Kastrup <dak@gnu.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:53726 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab0IPAos (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 20:44:48 -0400
In-Reply-To: <877hinhtbb.fsf@lola.goethe.zz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-09-15 at 18:20 +0200, David Kastrup wrote:
> Nivedita Singhvi <niv@us.ibm.com> writes:
> 

> A hardware failure means that the system is in violation of the system
> design.  A soft realtime failure means that reality is in violation of
> the system design.

The PREEMPT_RT patch (as I explained in another email) is designed to be
hard real time. Thus, a failure to meet its deadline is a failure in the
system design, just like it would be for hardware.

If you have a extremely complex piece of equipment, it is very hard to
prove that it can meet its deadlines given all circumstances. One reason
that x86 is not very hard real time friendly. The same is true with
software. If it becomes complex, it is very hard to prove that it too
can meet its deadlines in all corner cases. The analogy still holds
true.

Hardware that is less complex is easier to mathematically prove that it
will do what you expect to do in all cases, than hardware that is over
engineered, just like software.

I hold that PREEMPT_RT is not soft real time, but is hard real time
designed. That is, we can't prove that it is hard real time, but any
time we find a case that the software can break its deterministic
result, it is a bug and needs to be fixed. (aka, a system failure).

-- Steve


