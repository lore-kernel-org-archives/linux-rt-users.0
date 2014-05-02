From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch 0/6] 3.14-rt1 fixes
Date: Fri, 02 May 2014 15:49:36 +0200
Message-ID: <5363A270.5060109@linutronix.de>
References: <1399029159.5233.124.camel@marge.simpson.net>	 <20140502134408.GF9178@linutronix.de> <1399038349.5233.169.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41224 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbaEBNti (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2014 09:49:38 -0400
In-Reply-To: <1399038349.5233.169.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/02/2014 03:45 PM, Mike Galbraith wrote:
> On Fri, 2014-05-02 at 15:44 +0200, Sebastian Andrzej Siewior wrote: 
>> * Mike Galbraith | 2014-05-02 13:12:39 [+0200]:
>>
>>> drop: (buggy - calls migrate_disable() _after_ maybe blocking)
>>> migrate_disable-pushd-down-in-atomic_dec_and_spin_lo.patch
>>
>> In the thread you quoted also the delayed migrated_disable in
>> rt_read_lock(). Is this one no longer required?
> 
> Steven submitted a patch for that.

Ah I see. Let me look at this. What it looks is that we revert the 3
three push down patches since they break hotplug. Thanks.

> 
> -Mike
> 

Sebastian
