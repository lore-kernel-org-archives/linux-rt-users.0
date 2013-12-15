From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/3]  PREEMPT_RT support for Sparc64
Date: Sun, 15 Dec 2013 16:34:19 +0100
Message-ID: <20131215153419.GK31090@linutronix.de>
References: <1386908084-32064-1-git-send-email-allen.pais@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: Allen Pais <allen.pais@oracle.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55832 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab3LOPeV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 10:34:21 -0500
Content-Disposition: inline
In-Reply-To: <1386908084-32064-1-git-send-email-allen.pais@oracle.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Allen Pais | 2013-12-13 09:44:40 [+0530]:

>PREEMPT_RT support for Sparc64. 
>I have tested it UltraSparc T4 (Niagara4).
Nice.

>
>Allen Pais (3):
>  sparc64: use generic rwsem spinlocks rt
I can pick this one up.

Could you please forward this two upstream unless you have done so?
>  sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
>  sparc64: convert ctx_alloc_lock raw_spinlock_t

Sebastian
