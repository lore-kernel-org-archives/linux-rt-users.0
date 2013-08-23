From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] fix might sleep oops in irq affinity callback hook
Date: Fri, 23 Aug 2013 09:23:36 +0200
Message-ID: <52170DF8.90703@linutronix.de>
References: <20130820175918.GA18125@tsunami.ccur.com> <20130821155347.GB16913@linutronix.de> <20130821210928.GA14467@tsunami.ccur.com> <20130822190103.GA3198@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Joe Korty <joe.korty@ccur.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46365 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350Ab3HWHXk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Aug 2013 03:23:40 -0400
In-Reply-To: <20130822190103.GA3198@tsunami.ccur.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/22/2013 09:01 PM, Joe Korty wrote:
> Hi Sebastian,

Hi Joe,

> For the rt kernel, I get the message only for the first
> time the affinity for some SFC IRQ is changed.  Subsequent
> changes of the _same_ IRQ do not have the callback invoked.
> If I go and change some other SFC IRQ that will also invoke
> the callback the first time only.

it seems the thread does not get woken up second invocation. I try to
check this somehow here.

> 
> 
> Regards,
> Joe
> 
Sebastian
