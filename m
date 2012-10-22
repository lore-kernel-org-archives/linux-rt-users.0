From: Stanislav Meduna <stano@meduna.org>
Subject: Re: SLAB leaks filep in 3.4.13-rt21 with PREEMPT_RT_FULL
Date: Mon, 22 Oct 2012 18:10:32 +0200
Message-ID: <50856FF8.60407@meduna.org>
References: <5082C7B9.9010502@meduna.org> <alpine.LFD.2.02.1210202125560.2719@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:34469 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755543Ab2JVQKo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Oct 2012 12:10:44 -0400
In-Reply-To: <alpine.LFD.2.02.1210202125560.2719@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 20.10.2012 21:30, Thomas Gleixner wrote:

>> Looking at the slabtop output the "filp" is responsible for
>> most of the allocations, but there are more, even the "pid"
>> is rising although the number of threads in the system stays
>> the same.
> 
> It's a UP problem in tiny RCU. Fix is below.

Many thanks, the fix helped.

Best regards
-- 
                                       Stano

