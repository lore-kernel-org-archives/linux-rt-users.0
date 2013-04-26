From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.[68]-rt: CONFIG_PROVE_LOCKING + CONFIG_DEBUG_FORCE_WEAK_PER_CPU
 = boot time swap_lock deadlock
Date: Fri, 26 Apr 2013 16:49:28 +0200
Message-ID: <517A93F8.2060906@linutronix.de>
References: <1365937652.4717.25.camel@marge.simpson.net>   <1366685096.9609.145.camel@gandalf.local.home>   <20130426091656.GD20927@linutronix.de>   <1366978398.10248.21.camel@gandalf.local.home>   <20130426133855.GG20927@linutronix.de>  <1366984320.16752.7.camel@gandalf.local.home>  <517A8957.1060908@linutronix.de> <1366985748.16752.16.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <bitbucket@online.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49260 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab3DZOtc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Apr 2013 10:49:32 -0400
In-Reply-To: <1366985748.16752.16.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/26/2013 04:15 PM, Steven Rostedt wrote:
> 
> Ah, you did the clean up for me.
> 
> Looks good.

Yes, but I did not try to fix the second workqueue.

> -- Steve

Sebastian
