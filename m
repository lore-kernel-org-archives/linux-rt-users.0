From: Junior <ejr@inbox.com>
Subject: Re: RT example
Date: Thu, 25 Jan 2007 06:30:47 -0800
Message-ID: <E617BEE4136.0000021Fejr@inbox.com>
References: <dbdbe3a7ef0.0000058dejr@inbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wm28.inbox.com ([208.50.6.28]:4449 "HELO WM28.inbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965375AbXAYOay convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Jan 2007 09:30:54 -0500
Received: from inbox.com (127.0.0.1:25)
	by inbox.com with [InBox.Com SMTP Server]
	id <701250066231.WM28> for <linux-rt-users@vger.kernel.org> from <ejr@inbox.com>;
	Thu, 25 Jan 2007 6:30:47 AM -0800
In-Reply-To: <20070125070133.GY28808@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> On Wed, Jan 24, 2007 at 10:58:41AM -0800, Junior wrote:
>> Does anyone have example code using the PREEMPT_RT patch?
> 
> You could for example start with cyclictest. It is also a good example
> for how to write cyclic realtime programs on Linux.

Thanks, I will start there.

> Note that realtime is not about running fast, but running "in time".
> That may often mean that the overall system performance goes down.
> 
>> PS. I'm using an ARM9 platform
> 
> Do you have clocksource/clockevent support for your ARM9 chip?

Aparently I don't. It's set as IS_TICK_BASED. How does this affect the system?

Thanks,
--Jr.

____________________________________________________________
ONE-CLICK WEBMAIL ACCESS - Easily monitor & access your email accounts!
Visit http://www.inbox.com/notifier and check it out!
