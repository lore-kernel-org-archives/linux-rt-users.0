Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1A1C4320A
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 02:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42AA16101D
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 02:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhHJCmz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 22:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhHJCmz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Aug 2021 22:42:55 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20A5C0613D3;
        Mon,  9 Aug 2021 19:42:33 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id l20so28068522iom.4;
        Mon, 09 Aug 2021 19:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2r1eKT0GHVa73VDvbo2DptlCFZJjgR5mWxSgpJNvXcE=;
        b=SQz9WL37YY+hOktCyV+T3ZifD8c/qTgY2yw7hUxMTTBollxEtPnQH8HrRhNnEeNaoJ
         AJnhVNpfe5f8a/ddQSoSimMdF+b1MCT4Kroo3sVK2YjFnhgxo0sKBE9Zt5v2wXIi23+x
         eiSAS0pPdiZdA9QvD6DwvJ9eV0/QN3+UsfWFdF6P2C5q5VIOsIOERx1j6PcwQJ+mURiH
         AmbO7TksgekQ5Ywet/JxYTiLHkVXL6wbTvOksHuzc1NiBwY1XLAFGksVkIKfOCQBgYzu
         x8pgcG3/HlNVCjCSwx9MHClTkqXFYymfycZwKxpjO+SkObBNUXa2FOd07Pgo7b+y0BjX
         b7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2r1eKT0GHVa73VDvbo2DptlCFZJjgR5mWxSgpJNvXcE=;
        b=BGD/TN6x3KhZJloVE1T4MauK9KwW5iy4/FEiZLBcE+Z/GEnpEaC79o4RourkF0pbQV
         D9A6zePGHCHqSVbHlAoJBRm14UIL0xJJHi3NSfFVTl6tTn0qkKFG/kJl9XQdZgV/RMsc
         /tvTS7VidaWXtfaZWwiEKzSKAILIshKxByvzvdu6YhQVLloiDcr+7VJTiOsrtRbxHttS
         Yb4uCLUtgQCRdd9dkZ79MYFYmXGgZCwzYouwp9I8YaEWS8HYTotyb/c8DO06eGEiSlu4
         ug0z2nsy2aVEPEj88aRYXmC4Y4dOHE0tL5Pz5lR7zD3Qsk574Lq3EH04PY2dI1B1rku5
         sUxg==
X-Gm-Message-State: AOAM531OTGFCPCtf7+aAxs9cc3fFqgExytB/grSyUBn36y/mvaFQt0m8
        zCEP89xqnDjfobQAb0dM9+A=
X-Google-Smtp-Source: ABdhPJzJih5QO/F+2BNnmyBITFJ9dfwTTT/BfBBYWTVH6SE75HmgVfERCfi0lZY/88t+lYGkua3r6A==
X-Received: by 2002:a02:8206:: with SMTP id o6mr25016213jag.92.1628563352967;
        Mon, 09 Aug 2021 19:42:32 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i11sm10268401ilb.15.2021.08.09.19.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 19:42:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 23C3327C0054;
        Mon,  9 Aug 2021 22:42:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 09 Aug 2021 22:42:31 -0400
X-ME-Sender: <xms:lOcRYX2g5bmAZGCK5s4y3PcFOjt1Mdtr93HeGz33estz-bmqANEUOg>
    <xme:lOcRYWG_JxYAqNmHhZuHpJtnUAY8qdqUGk0u_5ZYNn4rNqZxMj3QFtHZRYMczo0cp
    6JHTa6BpKKl_pQK5A>
X-ME-Received: <xmr:lOcRYX76qafXoPgnxfcHtBYYTh89axT3QEUwjE0vbjxMetKF5oRKSJ7BSET_UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeekgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:lOcRYc1HeI9cJrjcsqo1mvD6QfKamxhKZ_30BA2qO5zP_-TXpRWApw>
    <xmx:lOcRYaGE-Fk10ug5dMeWKB9moWZm-bp8ljN8qaUhhp_FSfiYgjCbIg>
    <xmx:lOcRYd-6S_lPqqvDplDsvivFYTv--iPbjga6d22LPYcPIV2O4kyjRg>
    <xmx:lucRYdnzjADhpqqOxGwKrwgxZcBWc-6e-JQDMRj9bHhU3N9lnutPANs08fg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Aug 2021 22:42:28 -0400 (EDT)
Date:   Tue, 10 Aug 2021 10:42:21 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 2/4] sched: Introduce is_pcpu_safe()
Message-ID: <YRHnjQqf28/uFq+Z@boqun-archlinux>
References: <20210807005807.1083943-1-valentin.schneider@arm.com>
 <20210807005807.1083943-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807005807.1083943-3-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On Sat, Aug 07, 2021 at 01:58:05AM +0100, Valentin Schneider wrote:
> Some areas use preempt_disable() + preempt_enable() to safely access
> per-CPU data. The PREEMPT_RT folks have shown this can also be done by
> keeping preemption enabled and instead disabling migration (and acquiring a
> sleepable lock, if relevant).
> 
> Introduce a helper which checks whether the current task can safely access
> per-CPU data, IOW if the task's context guarantees the accesses will target
> a single CPU. This accounts for preemption, CPU affinity, and migrate
> disable - note that the CPU affinity check also mandates the presence of
> PF_NO_SETAFFINITY, as otherwise userspace could concurrently render the
> upcoming per-CPU access(es) unsafe.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  include/linux/sched.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index debc960f41e3..b77d65f677f6 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1715,6 +1715,16 @@ static inline bool is_percpu_thread(void)
>  #endif
>  }
>  
> +/* Is the current task guaranteed not to be migrated elsewhere? */
> +static inline bool is_pcpu_safe(void)
> +{
> +#ifdef CONFIG_SMP
> +	return !preemptible() || is_percpu_thread() || current->migration_disabled;
> +#else
> +	return true;
> +#endif
> +}

I wonder whether the following can happen, say thread A is a worker
thread for CPU 1, so it has the flag PF_NO_SETAFFINITY set.

	{ percpu variable X on CPU 2 is initially 0 }

	thread A
	========

	<preemption enabled>
	if (is_pcpu_safe()) { // nr_cpus_allowed == 1, so return true.
		<preempted>
		<hot unplug CPU 1>
			unbinder_workers(1); // A->cpus_mask becomes cpu_possible_mask
		<back to run on CPU 2>
		__this_cpu_inc(X);
		  tmp = X; // tmp == 0
		  <preempted>
		  <in thread B>
		  this_cpu_inc(X); // X becomes 1
		  <back to run A on CPU 2>
		  X = tmp + 1; // race!
	}

if so, then is_percpu_thread() doesn't indicate is_pcpu_safe()?

Regards,
Boqun

> +
>  /* Per-process atomic flags. */
>  #define PFA_NO_NEW_PRIVS		0	/* May not gain new privileges. */
>  #define PFA_SPREAD_PAGE			1	/* Spread page cache over cpuset */
> -- 
> 2.25.1
> 
