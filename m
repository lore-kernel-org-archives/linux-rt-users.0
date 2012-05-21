From: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Subject: Re: patch to fix early printks with PREMPT_RT_FULL
Date: Mon, 21 May 2012 13:12:35 -0700
Message-ID: <4FBAA1B3.40102@caviumnetworks.com>
References: <4FA47D4A.6020009@caviumnetworks.com> <4FB56EA1.4040609@caviumnetworks.com> <4FB5A646.7060803@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Subbiah, Venkat" <Venkat.Subbiah@caviumnetworks.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: "frank.rowand@am.sony.com" <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13840 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab2EUUMg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 May 2012 16:12:36 -0400
In-Reply-To: <4FB5A646.7060803@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/17/2012 06:30 PM, Frank Rowand wrote:
> On 05/17/12 14:33, Venkat Subbiah wrote:
>> Thomas,
>> Is this patch going to make it to a release or should this sent be sent
>> to more folks for review?
>> Thanks,
>> Venkat
>>
>> On 05/04/2012 06:07 PM, Venkat Subbiah wrote:
>>> Hello,
>>>
>>> With PREMPT_RT_FULL I notice couple of issues when early printk is turned on
>>>
>>> 1)  printks show up only after the full console is enabled
>>> 2)  There are double prints for each of the prinkts before the full
>>> console was enabled.
> Venkat,
>
> Do my patches from yesterday solve problem #1 for you?  (I can't
> test for your problem, because I don't see it on my ARM system.)
Frank,

Looks like the fix is not architecture specific. Curious as to why it 
doesn't show up
on ARM?

Thanks,
Venkat
>
>     http://marc.info/?l=linux-rt-users&m=133721694105947&w=2
>
>     http://marc.info/?l=linux-rt-users&m=133721717706004&w=2
>
> For problem #2, does that also exist without the RT patches?
>
> -Frank
>
>

