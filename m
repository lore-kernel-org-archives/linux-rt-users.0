From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [4.4-rc6-rt1 PATCH 0/2] ARM: am437x: boot test report
Date: Wed, 13 Jan 2016 13:41:33 +0200
Message-ID: <569637ED.1030304@ti.com>
References: <1451325611-21678-1-git-send-email-grygorii.strashko@ti.com>
 <20160112171556.GB31009@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Sekhar Nori <nsekhar@ti.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46405 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932726AbcAMLlp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jan 2016 06:41:45 -0500
In-Reply-To: <20160112171556.GB31009@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/12/2016 07:15 PM, Sebastian Andrzej Siewior wrote:
> * Grygorii Strashko | 2015-12-28 20:00:09 [+0200]:
> 
>> Hi All, Sebastian,
> Hi Grygorii,
> 
>> 3) Seems there are some problem with HIGHMEM :(. System crashes if I'm trying
>>    to run hackbench (see log 1). I can run hackbench only if HIGHMEM is disabled.
>>    I've also tried to disable CONFIG_CPU_SW_DOMAIN_PAN, CONFIG_ARM_PATCH_PHYS_VIRT,
>>    and CONFIG_CPUSETS, before disabling HIGHMEM.
>>    Sorry, I'll not able to investigate it further because of Christmas holidays here.
> 
> I see. It seems not to trigger anything on x86.

Yah. I saw other reports - it seems this issue is not triggered on ARM SMP also
(as per report from Tim Sander). Will try to dig deeper.


> 
>> 4) Could we revert commit 4fa5422 'ARM: OMAP2: Drop the concept of certain power
>>    domains not being able to lose context.'? It's not required for 4.4-rt wakeup
>>    and introduces build warnings.
> 
> done.

Thanks.

-- 
regards,
-grygorii
