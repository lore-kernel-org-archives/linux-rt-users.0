Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082BEC4708C
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 May 2021 15:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2D6611C2
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 May 2021 15:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhE1PM6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 May 2021 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbhE1PMx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 May 2021 11:12:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC2FC061760;
        Fri, 28 May 2021 08:11:17 -0700 (PDT)
Date:   Fri, 28 May 2021 17:11:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622214674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NqKOQAfvyt+jzwrzPZmX2cFEmEVtOFvl9de23IZJw44=;
        b=f4KFXAEnQtZqr8c5FBv+H4z7PxXv1eaZNTVMoqZ/vZmOaK4DdUayREtZcGBePe5QC8RRB/
        VX/tNpORZIT70kJcHiQJCCXYDIekkuYKhQ1R/f6E1Mry4I17R7pyGNL0iSY+zsKzfTbX08
        y52vRjeIvC2oRfNmh+dOSD/nNRLboq9SSfLHhc/iFh3rzaog41sJJtejWcKpGBogNkZLIj
        Rzxxp32TrhDfEdTtizbUtdJwmM4gY5rCFcyJP4qnVIHEgaUXpC660xJFLYT7IKe3ApE6oU
        4P45InAzqm266K05Gvbr3stiEusf5gLGDWFi2X7UPqctaLwBr7of5UWIVM4MiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622214674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NqKOQAfvyt+jzwrzPZmX2cFEmEVtOFvl9de23IZJw44=;
        b=LWxeTJIPdPzpxWiqRWQmP+z+TenWtCY/2/AYuJZelRkd7AAm2XA5czAdJc8m9zBY7Q6LUO
        es/iMtL3msAltnAg==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Varad Gautam <varad.gautam@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH] xfrm: policy: Read seqcount outside of rcu-read side in
 xfrm_policy_lookup_bytype
Message-ID: <YLEIEa6DLjgd5mu5@lx-t490>
References: <20210528120357.29542-1-varad.gautam@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528120357.29542-1-varad.gautam@suse.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, May 28, 2021, Varad Gautam wrote:
...
>
> Thead 1 (xfrm_hash_resize)	Thread 2 (xfrm_policy_lookup_bytype)
>
> 				rcu_read_lock();
> mutex_lock(&hash_resize_mutex);
> 				read_seqcount_begin(&xfrm_policy_hash_generation);
> 				mutex_lock(&hash_resize_mutex); // block
> xfrm_bydst_resize();
> synchronize_rcu(); // block
> 		<RCU stalls in xfrm_policy_lookup_bytype>
>
...
> Fixes: a7c44247f70 ("xfrm: policy: make xfrm_policy_lookup_bytype lockless")

Minor note: the 'Fixes' commit should be 77cc278f7b20 ("xfrm: policy:
Use sequence counters with associated lock") instead.

The reason read_seqcount_begin() is emitting a mutex_lock() on
PREEMPT_RT is because of the s/seqcount_t/seqcount_mutex_t/ change.

Kind regards,

--
Ahmed S. Darwish
Linutronix GmbH
