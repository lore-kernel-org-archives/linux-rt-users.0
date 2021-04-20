Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CA3C433B4
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Apr 2021 11:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BBC61354
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Apr 2021 11:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhDTLD4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhDTLDz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Apr 2021 07:03:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED7DC06174A;
        Tue, 20 Apr 2021 04:03:23 -0700 (PDT)
Date:   Tue, 20 Apr 2021 13:03:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618916602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lpaCRDJ6SAGk1AOH1qN2pbBeDF5BoHeFqMuW14MVQIU=;
        b=oYes+ROiEaeWPCXOWbvhNZfvZrDivF2ogbcECfGdnJaJWubABUin6AY426kkU9EOttFz5F
        LiQ9/OfTXx1xNV4aZllqQnr7vHfjALtmRqoV5EIs0/sopmm6tQ3k3OAOYqe+UlUJv4SOyN
        wx2De96c4lTik8GarKObtfENaLiJCcDfb4DVjx0/xIbH1krWasifE/mNAdbJkihPqoYFMs
        L/29vKsdYjjtbP/VGxpuDASzKQEEM9cqv272bflI61ZTDRod/k+zz9qSHqTLnn1O3bZPAU
        z5txrqoIJqgCKXdJ6YjeK9anYW3SXlMGochWzVUIM7wNgAJ3IrZSz+xCo2fuKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618916602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lpaCRDJ6SAGk1AOH1qN2pbBeDF5BoHeFqMuW14MVQIU=;
        b=JqLr3uV3rwYBf22YV6FJVCoTIY+Q2W0LI/Q5mWvFsSk8/6b9d7mZ9SX3ZDVuKgEzj+EfcJ
        pWXQI4X9iumd12Ag==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     ycollette.nospam@free.fr
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] 5.10.30-rt37
Message-ID: <YH60+fd0phU3oTL3@lx-t490>
References: <20210419184731.246fa474@gandalf.local.home>
 <941471789.41891679.1618904363608.JavaMail.root@zimbra35-e6.priv.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <941471789.41891679.1618904363608.JavaMail.root@zimbra35-e6.priv.proxad.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Apr 20, 2021, ycollette.nospam@free.fr wrote:
>
> net/xfrm/xfrm_state.c: In function 'xfrm_state_init':
> ./include/linux/seqlock.h:178:36: error: initialization of 'seqcount_spinlock_t *' {aka 'struct seqcount_spinlock *'} from incompatible pointer type 'seqcount_t *' {aka 'struct seqcount *'} [-Werror=incompatible-pointer-types]
>   178 |   seqcount_##lockname##_t *____s = (s);   \
>       |                                    ^
...
> net/xfrm/xfrm_state.c:2666:2: note: in expansion of macro 'seqcount_spinlock_init'
>  2666 |  seqcount_spinlock_init(&net->xfrm.xfrm_state_hash_generation,
>       |  ^~~~~~~~~~~~~~~~~~~~~~

There is a rebase error at:

  247560698349 ("Merge tag 'v5.10.30' into v5.10-rt")

Cherry-pick mainline's commit:

  bc8e0adff343 ("net: xfrm: Use sequence counter with associated spinlock")

and your compilation issue will be fixed.

Good luck,

--
Ahmed S. Darwish
