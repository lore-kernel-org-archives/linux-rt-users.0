From: Junior <ejr@inbox.com>
Subject: Re: RT example
Date: Fri, 2 Feb 2007 07:37:50 -0800
Message-ID: <4B42CE81E46.0000049Dejr@inbox.com>
References: <dbdbe3a7ef0.0000058dejr@inbox.com>
  <20070125070133.gy28808@pengutronix.de>
  <e672c199fc4.000002a6ejr@inbox.com> <e617bee4136.0000021fejr@inbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wm28.inbox.com ([208.50.6.28]:4701 "HELO WM28.inbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1945942AbXBBPhz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Feb 2007 10:37:55 -0500
Received: from inbox.com (127.0.0.1:25)
	by inbox.com with [InBox.Com SMTP Server]
	id <702020112789.WM28> for <linux-rt-users@vger.kernel.org> from <ejr@inbox.com>;
	Fri, 2 Feb 2007 7:37:50 AM -0800
In-Reply-To: <01E2F9E9290.000004B7ejr@inbox.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

With no response, perhaps someone can tell me what are the basic needs for a ARM platform to use the rt patches.
So far, the pactches hurt rather than help me and I've remove them. So, there must be something I don't know I'm missing.

Your help will be appreciated.
--Jr.


> -----Original Message-----
> From: ejr@inbox.com
> Sent: Sat, 27 Jan 2007 11:34:05 -0800
> To: ejr@inbox.com, r.schwebel@pengutronix.de
> Subject: Re: RT example
> 
> Hi All,
> Does anyone have any comments on my quesions below.
> I'm really looking for a good place to start and it would be a great help
> if someone could suggest one.
> 
> Or, someone could guide me in the right direction with a serial driver
> I'm working on. I'm trying to make the serial driver interrupt
> get serviced with 10-12ms when its fired. Do I use a timer or is there
> something in the rt patch that I can adjust in response to interrupts?
> 
> Thanks much.
> --Junior
> 
>> -----Original Message-----
>> From: ejr@inbox.com
>> Sent: Thu, 25 Jan 2007 07:11:30 -0800
>> To: r.schwebel@pengutronix.de
>> Subject: Re: RT example
>> 
>>> On Wed, Jan 24, 2007 at 10:58:41AM -0800, Junior wrote:
>>>> Does anyone have example code using the PREEMPT_RT patch?
>>> 
>>> You could for example start with cyclictest. It is also a good example
>>> for how to write cyclic realtime programs on Linux.
>> 
>> Thanks, I will start there.
>> 
>> Where do I get the rt library? (-lrt in makefile)?
>> 
>> cyclictest.c: In function `timerthread':
>> cyclictest.c:153: error: `SIGEV_THREAD_ID' undeclared (first use in this
>> function)
>> 
>> Someone got this before but no solution on how to fix it.
>> 
>> 
>>> Note that realtime is not about running fast, but running "in time".
>>> That may often mean that the overall system performance goes down.
>>> 
>>>> PS. I'm using an ARM9 platform
>>> 
>>> Do you have clocksource/clockevent support for your ARM9 chip?
>> 
>> Aparently I don't. It's set as IS_TICK_BASED. How does this affect the
>> system?
>> 
>> Thanks,
>> --Jr.
