From: Allen Pais <allen.pais@oracle.com>
Subject: Re: [PATCH 0/3]  PREEMPT_RT support for Sparc64
Date: Mon, 16 Dec 2013 09:22:48 +0530
Message-ID: <52AE7910.7070501@oracle.com>
References: <1386908084-32064-1-git-send-email-allen.pais@oracle.com> <20131215153419.GK31090@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:44261 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab3LPDxM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 22:53:12 -0500
In-Reply-To: <20131215153419.GK31090@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


>>
>> Allen Pais (3):
>>  sparc64: use generic rwsem spinlocks rt
> I can pick this one up.
> 
> Could you please forward this two upstream unless you have done so?
>>  sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
>>  sparc64: convert ctx_alloc_lock raw_spinlock_t

I'll send them upstream. 

- Allen

