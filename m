From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: preempt rt in commercial use
Date: Thu, 16 Sep 2010 21:27:17 +0200
Message-ID: <4C926F95.7080009@steinhoff.de>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>	 <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com>	 <201009141830.03206@zigzag.lvk.cs.msu.su>	 <4C8F8B79.1010300@theptrgroup.com> <4C8FF52E.1030407@us.ibm.com>	 <4C907A51.1050305@steinhoff.de> <4C90D392.8040808@us.ibm.com>	 <87k4mnhv9h.fsf@lola.goethe.zz> <4C90EE26.8060003@us.ibm.com>	 <877hinhtbb.fsf@lola.goethe.zz>	 <1284597885.23787.13.camel@gandalf.stny.rr.com>	 <4C923777.6080009@us.ibm.com> <1284658251.23787.39.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nivedita Singhvi <niv@us.ibm.com>, David Kastrup <dak@gnu.org>,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55590 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754350Ab0IPTZS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Sep 2010 15:25:18 -0400
In-Reply-To: <1284658251.23787.39.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi Steven,

I don't know what a "long" deadline is ... is is something like this:
http://harolds-planet.blogspot.com/2006/02/how-to-deal-with-deadlines.html

Cheers

--Armin

PS: I think you mean a time range where results are treated as delivered 
timely ?



Steven Rostedt wrote:
> On Thu, 2010-09-16 at 08:27 -0700, Nivedita Singhvi wrote:
>> Steven Rostedt wrote:
>>
>>> Hardware that is less complex is easier to mathematically prove that it
>>> will do what you expect to do in all cases, than hardware that is over
>>> engineered, just like software.
>>>
>>> I hold that PREEMPT_RT is not soft real time, but is hard real time
>>> designed. That is, we can't prove that it is hard real time, but any
>>> time we find a case that the software can break its deterministic
>>> result, it is a bug and needs to be fixed. (aka, a system failure).
>> Which serves to highlight my point about using these terms -- you're
>> the terms "hard" and "soft" in a different way than a previous poster.
>> (Assuming "hard real time designed" can get mistaken for "hard real time".
> Hard and soft are relative terms.
>
>> You're saying it's hard because we intend it to meet system deadlines
>> (regardless of deadline??), and it's a bug if it doesn't.
> heh, no. The "regardless of deadlines" was not what I meant. I meant "we
> have determined that the worse case runtime is X+delta, and if we run
> within that time the system works". The deadlines are determined at
> system design based on the hardware and software used. If you can not
> make a deadline at design time, you go back to the drawing board.
>
> It's all about determinism.
>
>> The previous poster in this list was using it to imply guarantees of
>> of very specific response times (<  xxx us).
>>
>> You really, really have to talk about the specifics of the environment,
>> the requirements, the application needs, etc. And I'm missing about
>> half a dozen "really"'s there.
> Note, I'm not sure you implied that vanilla Linux being fast enough can
> be considered "real-time" for long deadlines. If that's the case, it is
> wrong. A simple classic case of priority inversion will cause the system
> to fail no matter how long the deadlines are.
>
> -- Steve
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

