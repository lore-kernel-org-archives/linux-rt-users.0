From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: Slub support with PREEMPT_RT ?
Date: Wed, 17 Nov 2010 17:23:57 -0800
Message-ID: <4CE4802D.6070903@linux.intel.com>
References: <AANLkTimUb7rfRKCwhnf3s=Qw+J79_PqL_1Zk=fz5B99q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:11057 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab0KRBX6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Nov 2010 20:23:58 -0500
In-Reply-To: <AANLkTimUb7rfRKCwhnf3s=Qw+J79_PqL_1Zk=fz5B99q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/17/2010 08:18 AM, Jean-Michel Hautbois wrote:
> Hi !
>
> I am wondering why SLUB isn't supported with PREEMPT_RT ?
> I cannot find any info on that except the fact it is not working yet.
> What do we have to do in order to support it ?

Peter can answer this better than I can, but it has something to do with 
all the local_bh_disable() calls not being compatible with the goals of 
PREEMPT_RT - if I remember correctly.


-- 
Darren Hart
Yocto Linux Kernel
