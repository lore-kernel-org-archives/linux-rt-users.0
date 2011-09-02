From: Shan Hai <haishan.bai@gmail.com>
Subject: Re: [PATCH V2 1/1] lib/atomic64 using raw_spin_lock_irq[save|resotre]
 for atomicity
Date: Fri, 02 Sep 2011 08:48:33 +0800
Message-ID: <4E6027E1.1090905@gmail.com>
References: <1314847923-26428-1-git-send-email-haishan.bai@gmail.com> <1314847923-26428-2-git-send-email-haishan.bai@gmail.com> <alpine.LFD.2.02.1109011158500.2723@ionos> <alpine.LFD.2.02.1109011209000.2723@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: akpm@linux-foundation.org, eric.dumazet@gmail.com,
	vapier@gentoo.org, asharma@fb.com, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50736 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932747Ab1IBAsZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Sep 2011 20:48:25 -0400
In-Reply-To: <alpine.LFD.2.02.1109011209000.2723@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 09/01/2011 06:11 PM, Thomas Gleixner wrote:
> On Thu, 1 Sep 2011, Thomas Gleixner wrote:
>
>> On Thu, 1 Sep 2011, Shan Hai wrote:
>>
>>> The spin_lock_irq[save|restore] could break the atomicity of the
>>> atomic64_* operations in the PREEMPT-RT configuration, because
>>> the spin_lock_irq[save|restore] themselves are preemptable in the
>>> PREEMPT-RT, using raw variant of the spin lock could provide the
>>> atomicity that atomic64_* need.
>> Good catch. Queued for the next release.
> Though the changelog is misleading. The reason is not that they are
> preemtible.
>
> The reason for your OOPs is that the sleeping locks are not IRQ
> safe. And your system simply deadlocked due to that.
>

Will correct it in the V3 patch, thanks for the advice.

Cheers
Shan Hai

> Thanks,
>
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

