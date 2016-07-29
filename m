From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] sched: Fix compile warning when using CONFIG_PREEMPT_NONE
Date: Fri, 29 Jul 2016 12:49:31 -0500
Message-ID: <579B972B.3050409@mvista.com>
References: <1467219311-19424-1-git-send-email-minyard@acm.org>
 <20160729154602.GF21715@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, minyard@acm.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33146 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbcG2Rte (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2016 13:49:34 -0400
Received: by mail-pa0-f46.google.com with SMTP id ks6so33196213pab.0
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Jul 2016 10:49:33 -0700 (PDT)
In-Reply-To: <20160729154602.GF21715@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/29/2016 10:46 AM, Sebastian Andrzej Siewior wrote:
> * minyard@acm.org | 2016-06-29 11:55:11 [-0500]:
>
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> preemptible_lazy() is only used under CONFIG_PREEMPT, but it was
>> always defined.  Move it into a CONFIG_PREEMPT ifdef.
> Oh sorry, I missed that one but the problem is gone, right?
>
> Sebastian
Yes, it appears to be gone.  Before I think you could define 
CONFIG_PREEMPT_LAZY
without CONFIG_PREEMPT being defined.

-corey
