From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.8.10-rt6: suspend/resume irqs enabled splat
Date: Fri, 21 Jun 2013 16:18:16 +0200
Message-ID: <51C460A8.4010800@linutronix.de>
References: <1367473433.5808.8.camel@marge.simpson.net>  <20130621104940.GB21228@linutronix.de> <1371819580.5992.2.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39583 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422708Ab3FUOSS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 10:18:18 -0400
In-Reply-To: <1371819580.5992.2.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/21/2013 02:59 PM, Mike Galbraith wrote:
> On Fri, 2013-06-21 at 12:49 +0200, Sebastian Andrzej Siewior wrote: 
>> * Mike Galbraith | 2013-05-02 07:43:53 [+0200]:
>>
>>> Suspend/resume works fine on laptop, but, suspend, let it sit there a
>>> bit, then resume produces the gripe below.  Seems to be -rt specific,
>>> 3.8.10 with only voluntary preempt/autogroup config delta doesn't gripe.
>>
>> Could you please check if you see those on latest RT?
> 
> Yup, during boot.

Argh. So I tried a few things and I still don't see it.

> -Mike
> 

Sebastian
