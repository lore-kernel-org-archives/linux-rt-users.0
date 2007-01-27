From: Junior <ejr@inbox.com>
Subject: Re: RT example
Date: Sat, 27 Jan 2007 11:34:05 -0800
Message-ID: <01E2F9E9290.000004B7ejr@inbox.com>
References: <dbdbe3a7ef0.0000058dejr@inbox.com>
  <20070125070133.gy28808@pengutronix.de>
  <e617bee4136.0000021fejr@inbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Junior <ejr@inbox.com>, Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wm28.inbox.com ([208.50.6.28]:4549 "HELO WM28.inbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751826AbXA0TeI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Jan 2007 14:34:08 -0500
Received: from inbox.com (127.0.0.1:25)
	by inbox.com with [InBox.Com SMTP Server]
	id <701270154934.WM28> for <linux-rt-users@vger.kernel.org> from <ejr@inbox.com>;
	Sat, 27 Jan 2007 11:34:05 AM -0800
In-Reply-To: <E672C199FC4.000002A6ejr@inbox.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi All,
Does anyone have any comments on my quesions below.
I'm really looking for a good place to start and it would be a great help  if someone could suggest one.

Or, someone could guide me in the right direction with a serial driver I'm working on. I'm trying to make the serial driver interrupt
get serviced with 10-12ms when its fired. Do I use a timer or is there something in the rt patch that I can adjust in response to interrupts?

Thanks much.
--Junior

> -----Original Message-----
> From: ejr@inbox.com
> Sent: Thu, 25 Jan 2007 07:11:30 -0800
> To: r.schwebel@pengutronix.de
> Subject: Re: RT example
> 
>> On Wed, Jan 24, 2007 at 10:58:41AM -0800, Junior wrote:
>>> Does anyone have example code using the PREEMPT_RT patch?
>> 
>> You could for example start with cyclictest. It is also a good example
>> for how to write cyclic realtime programs on Linux.
> 
> Thanks, I will start there.
> 
> Where do I get the rt library? (-lrt in makefile)?
> 
> cyclictest.c: In function `timerthread':
> cyclictest.c:153: error: `SIGEV_THREAD_ID' undeclared (first use in this
> function)
> 
> Someone got this before but no solution on how to fix it.
> 
> 
>> Note that realtime is not about running fast, but running "in time".
>> That may often mean that the overall system performance goes down.
>> 
>>> PS. I'm using an ARM9 platform
>> 
>> Do you have clocksource/clockevent support for your ARM9 chip?
> 
> Aparently I don't. It's set as IS_TICK_BASED. How does this affect the
> system?
> 
> Thanks,
> --Jr.
> 
