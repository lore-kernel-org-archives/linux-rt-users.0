From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch] rt,mce: fix mce timer interval
Date: Fri, 31 May 2013 16:05:39 +0200
Message-ID: <51A8AE33.1090100@linutronix.de>
References: <1369828333.6089.133.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38201 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab3EaOFm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 May 2013 10:05:42 -0400
In-Reply-To: <1369828333.6089.133.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/29/2013 01:52 PM, Mike Galbraith wrote:
> Seems mce timer fire at the wrong frequency in -rt kernels since roughly
> forever due to 32 bit overflow.  3.8-rt is also missing a multiplier.
> 
> Add missing us -> ns conversion and 32 bit overflow prevention.
> 
> Signed-off-by: Mike Galbraith <bitbucket@online.de>

Thank you. I replaced (u64) cast by adding ULL to the numeric value.

Sebastian
