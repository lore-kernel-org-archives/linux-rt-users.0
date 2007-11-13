From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: How to use latency trace
Date: Tue, 13 Nov 2007 09:09:28 -0500
Message-ID: <473969C8.BA47.005A.0@novell.com>
References: <30746519.1640811193957606209.JavaMail.www@wwinf6101>
 <1985e0f60711020453o1e8d11e9m4de693d466d5ea57@mail.gmail.com>
 <1194383628.19313.22.camel@sx.thebigcorporation.com>
 <1985e0f60711130522k4ac274d1o42d63abc2c92b83d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <linux-rt-users@vger.kernel.org>, <gerritbinnenmars@wanadoo.nl>
To: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>,
	"Sven-Thorsten Dietrich" <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:8576 "EHLO
	mcclure.wal.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753047AbXKMONw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2007 09:13:52 -0500
In-Reply-To: <1985e0f60711130522k4ac274d1o42d63abc2c92b83d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

>>> On Tue, Nov 13, 2007 at  8:22 AM, in message
<1985e0f60711130522k4ac274d1o42d63abc2c92b83d@mail.gmail.com>, "Jaswinder
Singh" <jaswinderlinuxrt@gmail.com> wrote: 
> hello Sven,
> 
> 
> On Nov 7, 2007 2:43 AM, Sven-Thorsten Dietrich
> <sven@thebigcorporation.com> wrote:
>> >
>> > you can request for interval for 1000 so it should come 1000 all the
>> > time, but it is not.
>>
>> Its should come CLOSE to 1000. What errors have you seen?
>>
> 
> My errors are min and avg are not equal to ZERO.
> And I will be more happy If max is also ZERO :)

Jaswinder,
  As we recently discussed on IRC, this is not an error per se, but a status report of your OS/HW combo.  You will never see zero in cyclictest because the resolution off cyclictest/hrt is higher than the jitter specification of your chosen platform.

There is not an RT system in the world that has zero jitter to my knowledge.  Rather, each OS/HW combo will have some arbitrary jitter specification.   It is then up to the application designer to pick the platform where the specified jitter is lower than the apps tolerances.  Some dedicated hardware and/or RTOS's might spec out in picoseconds or nanoseconds.  Others might in microseconds, milliseconds, etc.

In the case of linux-rt on a modern x86 PC, this spec is generally in the range of 10us-100us.  For instance, an application that needs hard-realtime latencies with no more than 500us jitter, it would probably work great on linux-rt/x86.  Conversely, if you require no more than 500ns jitter, you need to look elsewhere.

So if you are seeing latency spikes> 100us, they should probably be investigated (using latency-trace) as potential bugs in -rt.  However, numbers below that range are probably normal for your system.  We are, of course, always looking to improve these numbers...but as of right now 10us-100us is state of the art.

I hope this helps.
-Greg
