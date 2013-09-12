From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT]  rt,ipc,sem: fix -rt livelock
Date: Thu, 12 Sep 2013 15:15:47 -0400
Message-ID: <20130912151547.389673d2@gandalf.local.home>
References: <20130819213324.405942342@goodmis.org>
	<1377842245.5422.7.camel@marge.simpson.net>
	<1377873580.5422.25.camel@marge.simpson.net>
	<1377926850.6234.22.camel@marge.simpson.net>
	<1378451338.5434.91.camel@marge.simpson.net>
	<1378794614.6046.37.camel@marge.simpson.net>
	<52307814.4020104@colorfullife.com>
	<1378971628.10696.88.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Manfred Spraul <manfred@colorfullife.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:24251 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab3ILTPu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Sep 2013 15:15:50 -0400
In-Reply-To: <1378971628.10696.88.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 12 Sep 2013 09:40:28 +0200
Mike Galbraith <bitbucket@online.de> wrote:


> If maintainers are interested, I can add that and clean up hammer marks
> so it can be applied in lieu of the existing rt wakeup patch instead of
> being crammed in on top of it, or they can trivially do that themselves,
> both options presuming your (implied) approval.
> 

Mike,

What's the final patch for this?

Could you post another one with what you believe is the correct fix.

Thanks,

-- Steve
