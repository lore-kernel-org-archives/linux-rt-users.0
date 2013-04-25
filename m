From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched: fix the wrong macro name of CONFIG_DEBUG_PREEMPT
Date: Thu, 25 Apr 2013 18:35:34 +0200
Message-ID: <20130425163534.GE5561@linutronix.de>
References: <5162AE51.8030804@huawei.com>
 <1365518245.25498.57.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Qiang Huang <h.huangqiang@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45030 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921Ab3DYQfi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Apr 2013 12:35:38 -0400
Content-Disposition: inline
In-Reply-To: <1365518245.25498.57.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2013-04-09 10:37:25 [-0400]:

>Thomas, 
>
>Can you pick up this patch for 3.8-rt? I'll add it to stable after you
>have done so.
>
>Thanks,
>
>-- Steve
>
>On Mon, 2013-04-08 at 19:47 +0800, Qiang Huang wrote:
>> Might be a typo, would cause some debug code never be run.

Looks like a type, indeed. Applied.

Sebastian
