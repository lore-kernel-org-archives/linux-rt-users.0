From: Joe Korty <joe.korty@ccur.com>
Subject: Re: [PATCH] fix might sleep oops in irq affinity callback hook
Date: Fri, 30 Aug 2013 09:53:35 -0400
Message-ID: <20130830135335.GA25232@tsunami.ccur.com>
References: <20130820175918.GA18125@tsunami.ccur.com>
 <20130821155347.GB16913@linutronix.de>
 <20130821210928.GA14467@tsunami.ccur.com>
 <20130822190103.GA3198@tsunami.ccur.com>
 <20130829112257.GA15360@linutronix.de>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from flusers.ccur.com ([173.221.59.2]:61468 "EHLO gamx.iccur.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753821Ab3H3NzN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Aug 2013 09:55:13 -0400
Content-Disposition: inline
In-Reply-To: <20130829112257.GA15360@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Aug 29, 2013 at 07:22:57AM -0400, Sebastian Andrzej Siewior wrote:
>> For the rt kernel, I get the message only for the first
>> time the affinity for some SFC IRQ is changed.  Subsequent
>> changes of the _same_ IRQ do not have the callback invoked.
>> If I go and change some other SFC IRQ that will also invoke
>> the callback the first time only.
> 
> I forget to remove that item from the list so your observing was
> correct. Thanks for testing.
> I'm going to tae that one, as it seems to work:


Hi Sebastian,
I backported the new version to 3.6.11.6-rt38, it works perfectly.
Thanks!

Joe
