Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A329C4320A
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 12:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24C860EFF
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 12:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbhHJMtv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240821AbhHJMtu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 08:49:50 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8297CC0613D3;
        Tue, 10 Aug 2021 05:49:28 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id u7so285465ilk.7;
        Tue, 10 Aug 2021 05:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CDRkvf+rJoAcxbVNpNU7zFOiE0Wsf0lTz3fYz3qZAV0=;
        b=JrVsvoAXeKzYVXrJv/0UdM5aFUuV2yF8ZiUCKaZxxysdmY0fSnreZ++Brhu+X8VTUF
         a3savyhbXE7nqTLZkMEQItv2E63MXOyhXmm/LYrAfPCrh+wn6pVLUspcNQyupi9BrWHM
         pj9SBMhT76vnNKeNItpuvst5j7q+/6Df634FUqWfC3Niv4utdPO5wk4xpEfM3Dve28am
         rmZMAaxFSmGdY7TEd/JMF8Lou2qeewFinS0ZRUvGDkJUcsSXtLFkblAyGojvPjcWXuCn
         4/dPIIWRaFez41qSEIc0p3aDuVXns8E6x9iufCp3Jlk5UaqlWX01kPC6tsLieWZEChnN
         vOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CDRkvf+rJoAcxbVNpNU7zFOiE0Wsf0lTz3fYz3qZAV0=;
        b=fonc2NtynUs11UFr3UzcmR7+zyk83mfqvVwncct4R5Vh43BKw1W4LeNH55ZMrMSRyB
         O7ynnCv0dpcLXlqSDwUqx51U7VVYohm+0Ys6Td6teIBZA5lXUS4mFYv0W1CDLQx75tD/
         KfSu011yOpFQHU8bfYTJo1oobum0u3soh2A2YYXIq3+MgQuVYr0Tj/fL5tGczzakHRS7
         mJdGB7rZHwAIU1I6m9on+9NFFz9suePzwL1Zteds2fIBoOYuK2Yepsio097LzWnwyGQb
         0us0zeUFsgK430rHNfzt6Kqt0MHy2jnzET/zE42/HHTeLAadk6/xCZnc8LJJoleGM7/b
         51+g==
X-Gm-Message-State: AOAM530o6vv1N5ZWZenY6MhSxVIcl+ptfY2hVnQTK+jM0uZ23PLAlXxn
        nyars4nhL4frdH+YZ2TaT9g=
X-Google-Smtp-Source: ABdhPJw0PIAgRtxP9eZhxhiBZXmkwCLdwkiwaWBFPIEs+FATJxD+KPJyHl0YwbxHdDTXuaMwcm4rvA==
X-Received: by 2002:a92:d987:: with SMTP id r7mr21377iln.303.1628599767987;
        Tue, 10 Aug 2021 05:49:27 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q8sm5256775ilg.6.2021.08.10.05.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 05:49:27 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0541827C0054;
        Tue, 10 Aug 2021 08:49:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 10 Aug 2021 08:49:26 -0400
X-ME-Sender: <xms:0nUSYWwiyRiqRt0OH7DNvlNa4t4kiKWQI0lEWCCNtCiaWM4fnX0Rig>
    <xme:0nUSYSTMFu7i3RRW6PsBaMPhWFIbUiQedl7K7WbRifGXIixxR4w8boE5a9EIIuxzl
    fgYGS4r86DnF5ZVGw>
X-ME-Received: <xmr:0nUSYYWbrTtWwHiZALIemtXdTd4bTqL1qTvdGfJU65oO1GsQ_nLB7HPw_QlJ6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeelgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:0nUSYcghJFxB_XZdxrNfT_Ygp4KbumYYQVLYPuxT0950yKasWZi8tQ>
    <xmx:0nUSYYDWX4KghXOpat-ldUas_4CQRpV41yX7P-pZaz3EtIbws14VqA>
    <xmx:0nUSYdLwa9y7S3Oar8Ohrc_IIv5Fln012c1NFrLj505N-0bkcs3Okg>
    <xmx:1XUSYSykqdZ9cGoPKXF_uj8snzP-T47lkQSCtejeC-u7_Y9WCl_g3FK1mPo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Aug 2021 08:49:21 -0400 (EDT)
Date:   Tue, 10 Aug 2021 20:49:14 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
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
Message-ID: <YRJ1yvfRjDJpXZWf@boqun-archlinux>
References: <20210807005807.1083943-1-valentin.schneider@arm.com>
 <20210807005807.1083943-3-valentin.schneider@arm.com>
 <800ff941e3ec86ea1397cddf8ecea3d4a17c55dc.camel@gmx.de>
 <87a6lrap5z.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6lrap5z.mognet@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, Aug 08, 2021 at 05:15:20PM +0100, Valentin Schneider wrote:
> On 07/08/21 03:42, Mike Galbraith wrote:
> > On Sat, 2021-08-07 at 01:58 +0100, Valentin Schneider wrote:
> >>
> >> +static inline bool is_pcpu_safe(void)
> >
> > Nit: seems odd to avoid spelling it out to save two characters, percpu
> > is word like, rolls off the ole tongue better than p-c-p-u.
> >
> >       -Mike
> 
> True. A quick grep says both versions are used, though "percpu" wins by
> about a factor of 2. I'll tweak that for a v3.

I wonder why is_percpu_safe() is the correct name. The safety of
accesses to percpu variables means two things to me:

a)	The thread cannot migrate to other CPU in the middle of
	accessing a percpu variable, in other words, the following
	cannot happen:

	{ percpu variable X is 0 on CPU 0 and 2 on CPU 1
	CPU 0				CPU 1
	========			=========
	<in thread A>
	__this_cpu_inc(X);
	  tmp = X; // tmp is 0
	  <preempted>
	  <migrate to CPU 1>
	  				// continue __this_cpu_inc(X);
					X = tmp + 1; // CPU 0 miss this
						     // increment (this
						     // may be OK), and
						     // CPU 1's X got
						     // corrupted.

b)	The accesses to a percpu variable are exclusive, i.e. no
	interrupt or preemption can happen in the middle of accessing,
	in other words, the following cannot happen:

	{ percpu variable X is 0 on CPU 0 }
	CPU 0
	========
	<in thread A>
	__this_cpu_inc(X);
	  tmp = X; // tmp is 0
	  <preempted>
	  <in other thread>
	  this_cpu_inc(X); // X is 1 afterwards.
	  <back to thread A>
	  X = tmp + 1; // X is 1, and we have a race condition.

And the is_p{er}cpu_safe() only detects the first, and it doesn't mean
totally safe for percpu accesses.

Maybe we can implement a migratable()? Although not sure it's a English
word.

Regards,
Boqun

