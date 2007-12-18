From: Steven Rostedt <srostedt@redhat.com>
Subject: Re: [PATCH] sched: dynamically update the root-domain span/online
 maps
Date: Mon, 17 Dec 2007 22:35:45 -0500
Message-ID: <47674011.2050905@redhat.com>
References: <20071218023805.4390.19471.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Clark Williams <williams@redhat.com>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:46678 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbXLRDgK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Dec 2007 22:36:10 -0500
In-Reply-To: <20071218023805.4390.19471.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Gregory Haskins wrote:
> Hi Steven,
>   I posted a suspend-to-ram fix to sched-devel earlier today:
> 
> http://lkml.org/lkml/2007/12/17/445
> 
> This fix should also be applied to -rt as I introduced the same regression
> there.  Here is a version of the fix for 23-rt13.  I can submit a version for
> 24-rc5-rt1 at your request.
> 

Thanks Gregory,

I'll put this into the 2.6.23.11-rt14 queue. I have someone that tells 
me that suspend to RAM breaks. I'll have him try the new update and let 
me know if it fixes his issue before releasing it. I'll also let 
everyone know the results as well.

-- Steve
