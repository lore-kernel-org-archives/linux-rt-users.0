From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: patch to fix early printks with PREMPT_RT_FULL
Date: Thu, 17 May 2012 18:30:46 -0700
Message-ID: <4FB5A646.7060803@am.sony.com>
References: <4FA47D4A.6020009@caviumnetworks.com> <4FB56EA1.4040609@caviumnetworks.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:16827
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965134Ab2ERBbI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 May 2012 21:31:08 -0400
In-Reply-To: <4FB56EA1.4040609@caviumnetworks.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/17/12 14:33, Venkat Subbiah wrote:
> Thomas,
> Is this patch going to make it to a release or should this sent be sent 
> to more folks for review?
> Thanks,
> Venkat
> 
> On 05/04/2012 06:07 PM, Venkat Subbiah wrote:
>> Hello,
>>
>> With PREMPT_RT_FULL I notice couple of issues when early printk is turned on
>>
>> 1)  printks show up only after the full console is enabled
>> 2)  There are double prints for each of the prinkts before the full
>> console was enabled.

Venkat,

Do my patches from yesterday solve problem #1 for you?  (I can't
test for your problem, because I don't see it on my ARM system.)

   http://marc.info/?l=linux-rt-users&m=133721694105947&w=2

   http://marc.info/?l=linux-rt-users&m=133721717706004&w=2

For problem #2, does that also exist without the RT patches?

-Frank

