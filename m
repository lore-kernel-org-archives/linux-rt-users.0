From: Venkat Subbiah <venkat.subbiah@cavium.com>
Subject: Re: rt patch set and tags on mainline repo
Date: Wed, 05 Oct 2011 20:41:03 -0700
Message-ID: <4E8D234F.9040803@cavium.com>
References: <4E8CA60F.3080700@cavium.com> <alpine.LFD.2.02.1110052143420.18778@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16416 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab1JFDmO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Oct 2011 23:42:14 -0400
In-Reply-To: <alpine.LFD.2.02.1110052143420.18778@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/05/2011 12:47 PM, Thomas Gleixner wrote:
> On Wed, 5 Oct 2011, Venkat Subbiah wrote:
>
>> Hello,
>>
>> I am still not able to figure out which of Linus's tag in the mainline repo
>> would an rt patch set apply to.
>>
>> For example this patch here
>> http://web.archive.org/web/20110612145812/http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.33.9-rt31.gz
> 2.6.33.9-rt applies to 2.6.33.9 which is a stable release. Stable
> kernels are not part of Linus tree.
>
> http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=shortlog;h=refs/heads/linux-2.6.33.y
>> Q1) Alsolooks like the https://rt.wiki.kernel.org/index.php/Main_Page is still
>> not available. Is there a location where I can get the split patch equivalent
>> of "patch-2.6.33.9-rt31.gz".
> Not at the moment.
Thanks for you reply.

Once the rt wiki is back would there be one or a split patch hasn't been created at all for 2.6.33.9-rt1?

Is there a split patch for any 2.6.33 version?


>
>> Q2) I am really looking to patch a 2.6.32 kernel. Are there rt patch sets
>> available for this version even if they are unofficial?
> No. Just my 0,01$: Move your BSP to 2.6.33 or 3.0 instead of
> attempting to backport rt to 33. But it's your decision and your time
> to waste. :0
Thanks for you input, but it may not be my decision too!

> Thanks,
>
> 	tglx

