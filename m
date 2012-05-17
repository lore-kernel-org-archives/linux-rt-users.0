From: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Subject: Re: patch to fix early printks with PREMPT_RT_FULL
Date: Thu, 17 May 2012 14:33:21 -0700
Message-ID: <4FB56EA1.4040609@caviumnetworks.com>
References: <4FA47D4A.6020009@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19486 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab2EQVdX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 May 2012 17:33:23 -0400
In-Reply-To: <4FA47D4A.6020009@caviumnetworks.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas,
Is this patch going to make it to a release or should this sent be sent 
to more folks for review?
Thanks,
Venkat

On 05/04/2012 06:07 PM, Venkat Subbiah wrote:
> Hello,
>
> With PREMPT_RT_FULL I notice couple of issues when early printk is turned on
>
> 1)  printks show up only after the full console is enabled
> 2)  There are double prints for each of the prinkts before the full
> console was enabled.
>
> The attached patch seem to fix the issue, but I am not sure whether this
> is completely with
> the lock being acquired in console_trylock_for_printk().
>
> Thanks,
> Venkat
>

