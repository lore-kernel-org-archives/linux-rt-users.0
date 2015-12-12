From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [4.1.3-rt3] [report][suspend to ram] BUG: sleeping function
 called from invalid context at kernel/locking/rtmutex.c:917
Date: Sat, 12 Dec 2015 10:29:55 +0200
Message-ID: <566BDB03.3040100@ti.com>
References: <55CB8FAE.9020309@ti.com> <20150816114241.GC7004@linutronix.de>
 <55D201DC.5070604@ti.com> <55E9CAFB.9070002@ti.com>
 <20151211162008.GB6720@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Russell King <rmk+kernel@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sekhar Nori <nsekhar@ti.com>, Felipe Balbi <balbi@ti.com>,
	<linux-rt-users@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55373 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbbLLIao (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 12 Dec 2015 03:30:44 -0500
In-Reply-To: <20151211162008.GB6720@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/11/2015 06:20 PM, Sebastian Andrzej Siewior wrote:
> * Grygorii Strashko | 2015-09-04 19:46:51 [+0300]:
>
>> Hi All,
> Hi,
>
>> I'd very appreciated for comments.
>
> did you run into any problems with this or is it working for you?
>

No. And corresponding patch was merged in v4.1.7-rt8
9754cf6 ARM: smp: Move clear_tasks_mm_cpumask() call to __cpu_die()


-- 
regards,
-grygorii
