From: Allen Pais <allen.pais@oracle.com>
Subject: Re: [PATCH 0/4] PREEMPT_RT support for sparc64
Date: Wed, 05 Feb 2014 09:01:19 +0530
Message-ID: <52F1B087.5090203@oracle.com>
References: <1388980510-10190-1-git-send-email-allen.pais@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:20347 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbaBEDbo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Feb 2014 22:31:44 -0500
In-Reply-To: <1388980510-10190-1-git-send-email-allen.pais@oracle.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> Have tested it on UltraSparc T4 (Niagara4). 
> 
> Allen Pais (4):
>   sparc64: use generic rwsem spinlocks rt
>   sparc64: allow forced irq threading
>   sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
>   sparc64: convert ctx_alloc_lock raw_spinlock_t
> 
>  arch/sparc/Kconfig                      |    7 +++----
>  arch/sparc/include/asm/mmu_64.h         |    2 +-
>  arch/sparc/include/asm/mmu_context_64.h |   10 +++++-----
>  arch/sparc/kernel/smp_64.c              |    4 ++--
>  arch/sparc/mm/init_64.c                 |   14 +++++++-------
>  arch/sparc/mm/tsb.c                     |   20 ++++++++++----------
>  6 files changed, 28 insertions(+), 29 deletions(-)
> 

Sebastian, Any idea on the status of these patches?

Thanks,
Allen
