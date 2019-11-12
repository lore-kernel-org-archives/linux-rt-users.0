Return-Path: <SRS0=ZIbK=ZE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112C6C43331
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Nov 2019 09:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D779D20674
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Nov 2019 09:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKLJKq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:10:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:38428 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfKLJKq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Nov 2019 04:10:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9BD8BAE65;
        Tue, 12 Nov 2019 09:10:44 +0000 (UTC)
Date:   Tue, 12 Nov 2019 10:10:44 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Snitzer <msnitzer@redhat.com>, Scott Wood <swood@redhat.com>,
        dm-devel@redhat.com, Nikos Tsironis <ntsironis@arrikto.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de
Subject: Re: [dm-devel] [PATCH 2/2] realtime: avoid BUG when the list is not
 locked
Message-ID: <20191112091044.lf7okijocx2wajhk@beryllium.lan>
References: <alpine.LRH.2.02.1911110853100.30532@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1911110853100.30532@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

[cc: linux-user-rt, Thomas and Sebastian]

On Mon, Nov 11, 2019 at 08:59:44AM -0500, Mikulas Patocka wrote:
> list_bl.h would crash with BUG() if we used it without locking. 
> dm-snapshot uses its own locking on readltime kernels, so to avoid this 
> BUG, we must set LIST_BL_LOCKMASK = 0.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> Index: linux-rt-devel/include/linux/list_bl.h
> ===================================================================
> --- linux-rt-devel.orig/include/linux/list_bl.h	2019-11-07 14:01:51.000000000 +0100
> +++ linux-rt-devel/include/linux/list_bl.h	2019-11-08 10:12:49.000000000 +0100
> @@ -19,7 +19,7 @@
>   * some fast and compact auxiliary data.
>   */
>  
> -#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> +#if (defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)) && !defined(CONFIG_PREEMPT_RT_BASE)

CONFIG_PREEMPT_RT_BASE is only available in the out of tree -rt patch
set, therefore I assume it's not for mainline, right?

>  #define LIST_BL_LOCKMASK	1UL
>  #else
>  #define LIST_BL_LOCKMASK	0UL
> @@ -161,9 +161,6 @@ static inline void hlist_bl_lock(struct
>  	bit_spin_lock(0, (unsigned long *)b);
>  #else
>  	raw_spin_lock(&b->lock);
> -#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> -	__set_bit(0, (unsigned long *)b);
> -#endif
>  #endif
>  }
>  
> @@ -172,9 +169,6 @@ static inline void hlist_bl_unlock(struc
>  #ifndef CONFIG_PREEMPT_RT_BASE
>  	__bit_spin_unlock(0, (unsigned long *)b);
>  #else
> -#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> -	__clear_bit(0, (unsigned long *)b);
> -#endif
>  	raw_spin_unlock(&b->lock);
>  #endif
>  }
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
> 

Thanks,
Daniel
