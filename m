Return-Path: <SRS0=be3R=ZF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234F8C43331
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Nov 2019 10:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0C1222C1
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Nov 2019 10:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arrikto-com.20150623.gappssmtp.com header.i=@arrikto-com.20150623.gappssmtp.com header.b="dr9wNmnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfKMK3U (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:29:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40577 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfKMK3P (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Nov 2019 05:29:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id j26so1499019lfh.7
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Nov 2019 02:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8U4ilfUNpUqe6+CIAyFMlutnwFO+5K2+9W49ylkKQMM=;
        b=dr9wNmnJxNrZ9PPJKsPqmMMjxbqIyI5x2JwffJyh6U16UMWChMEkFgavLDzptF0dK8
         zO//Ya1JQaLrJM5tO/uXc3HglBtN2n7jsPedHsLtfQ9nGDqBXC+sp2084iYPRJ3ul8J4
         7SvLcN4W/CJ90c2AW+rqSX2aSAty2i9+dHXb3EWCLhCJ3JpG4IcOog+C2T3En8XpxPZB
         iG1009PHMuXwTfNJX9jyEPOaTk0DKxrctJoL+//up1g5T34tGn2czJR1vJwczFT7lRM+
         tnw3mNVOG1J7zGsZyujXZFckSrojnr8Mr9ACobYt4d9Ln+1nKkv+dTPBS6u4aoM5eK5q
         u8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8U4ilfUNpUqe6+CIAyFMlutnwFO+5K2+9W49ylkKQMM=;
        b=PyfGIlmhhua6pe9BI6NlXLFpIlBSFQgP7TPaKbVWH+cHUE46UdpqHS1lFwwjJXV+me
         tR3S04wluAqIK2xtxJ5zU6O6ZOTIHGdy47a91djc+p6E9tB7Dv/o9B63iIIyHFD3niyK
         d+MXV+EBXYlVX9s5nRMQBCe34w5q0aVDVdJ86BstqSzlOQcsedc+HJh4xgGUEA+aMP6y
         68S2EE/wL00Rh55CkBPh3/XQvJ2JWZ8JeORxCdd2rI4NUIL7Sw9ni2b+5fXIQ+8DNTzG
         bIOrdzbwsctEyRZabGvzSWmJpXcuW4G3oZBvQ6ofNrrO3+rIJumWJhWJ5zRpuqaIhZRB
         TdVw==
X-Gm-Message-State: APjAAAW1JwW7ebpkHfwG06NYhgti6/bwpu8gjPK48hrPPxclJSLaAlb9
        u9Uar/VwqL93U88QaJqvgyp1zA==
X-Google-Smtp-Source: APXvYqxXN3i85bszLn6MncK61pEPk1mQY39Ogn/cplUmKYNpImhuBr+oMEicCOaX6tobbAUTwzcbIA==
X-Received: by 2002:ac2:4302:: with SMTP id l2mr461322lfh.116.1573640953556;
        Wed, 13 Nov 2019 02:29:13 -0800 (PST)
Received: from [10.94.250.119] ([31.177.62.212])
        by smtp.gmail.com with ESMTPSA id u5sm826868lfu.4.2019.11.13.02.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 02:29:13 -0800 (PST)
Subject: Re: [PATCH RT 2/2 v2] list_bl: avoid BUG when the list is not locked
To:     Mikulas Patocka <mpatocka@redhat.com>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org
Cc:     Mike Snitzer <msnitzer@redhat.com>, Scott Wood <swood@redhat.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <alpine.LRH.2.02.1911121110430.12815@file01.intranet.prod.int.rdu2.redhat.com>
From:   Nikos Tsironis <ntsironis@arrikto.com>
Message-ID: <335dafcb-5e07-63ed-b288-196516170bde@arrikto.com>
Date:   Wed, 13 Nov 2019 12:29:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1911121110430.12815@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 11/12/19 6:16 PM, Mikulas Patocka wrote:
> list_bl would crash with BUG() if we used it without locking. dm-snapshot 
> uses its own locking on realtime kernels (it can't use list_bl because 
> list_bl uses raw spinlock and dm-snapshot takes other non-raw spinlocks 
> while holding bl_lock).
> 
> To avoid this BUG, we must set LIST_BL_LOCKMASK = 0.
> 
> This patch is intended only for the realtime kernel patchset, not for the 
> upstream kernel.
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

Hi Mikulas,

I think removing __set_bit()/__clear_bit() breaks hlist_bl_is_locked(),
which is used by the RCU variant of list_bl.

Nikos

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
