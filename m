From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3.10-rt] slab: make kmem_cache_node's list_lock
 conditionally raw
Date: Fri, 11 Oct 2013 15:16:37 +0200
Message-ID: <20131011131637.GH6983@linutronix.de>
References: <1381258509-7420-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33364 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab3JKNQk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Oct 2013 09:16:40 -0400
Content-Disposition: inline
In-Reply-To: <1381258509-7420-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul Gortmaker | 2013-10-08 14:55:09 [-0400]:

>The RT patch "mm-disable-slab-on-rt.patch" unconditionally
>converts kmem_cache_node's list_lock into a raw lock.  As
>of mainline commit ca34956b804b7554fc4e88826773380d9d5122a8
>("slab: Common definition for kmem_cache_node") the definition
>is shared -- but slab.c still thinks the lock is non raw.
>
>At the moment SLAB depends on !RT_FULL, however with the lock
>being raw for !RT_FULL, we can't build the SLAB + !RT_FULL
>combination because of the above.  So only convert the lock if
>SLAB is not enabled.
>
>Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Thank you for the 5 patches, all applied.

Sebastian
