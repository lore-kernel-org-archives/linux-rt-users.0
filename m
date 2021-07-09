Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CF1C07E99
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 05:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB526140F
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 05:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhGIFXd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 01:23:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:59597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhGIFXc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 01:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625808037;
        bh=OCW7oljHM6ncvS3+WmeaxtPjxKjop38O0bgGSXlwec4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=dwBZoO71An4asQnnszWWJjKf3TKTGO/GBGxwg/jcaZzBw5A6QiI8sUVlsKek+54Jw
         EA+v45nFbvfwm4QOcvQgCJ+XHYPOPAdV2cbEfOPeI1aD23b3EfMiSJld+OAUZjhRt4
         t15bRWHSagrO8n8C+C613/zGGAn12okSNIA2XHbw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.33]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybKf-1lFusi0rCX-00yyNh; Fri, 09
 Jul 2021 07:20:37 +0200
Message-ID: <966f27f7999acb1db8d60e241a73dfde3344345c.camel@gmx.de>
Subject: [patch] mm/slub: Fix kmem_cache_alloc_bulk() error path
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Fri, 09 Jul 2021 07:20:36 +0200
In-Reply-To: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:X0SMFsCtIjHy5TeQqmMzGnMgSjxHIdat64X17zv9akVokK2mr5V
 h/fBqIvDm4JgtYTRZinezDexdCg0ynG0BOnxfIqOApbeTFx43rAs5Aa75JVBcy06xq+/+YC
 WN7hyVhRXCWpSDTwuqN43bKkMqtXOPRbfmYfKYSPKhjcJerW/ivq7DkAVHLJB7Qx00r4rex
 HaHUIAuAEXAbUH5RG4SOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:08dDrrprXM0=:IyqFnAUomg3/CSP/mVFmuk
 qeDV5L2fW2JLDB64tD0EMUXkYxdLOkglkGAIQ07z8P0aPCmqegtwMV/aVNY3gKjsVtsB+W5Gn
 n+a4aStrAEfj/wHsNg5P8hgohvuoRTPFw12Nt4Cb/3OxiZ/vKmcP0jHVoV+2DMiwgJlA0lAPG
 wlU9U+eXx3ofS6Nzx80hAa4cYtBzM2Qx/55Z4kkmQu6HaDhvu2/69MuT5XOaXJaMu9hhIuFEy
 DTIr0phbICTdWGrHLnGXFSURezF6fGtwRF3pTtpNS3LN7xBs1re/CMnrFwYpgz3Dv9zyYKk6V
 pq3vk1EThNJrGV0IdHyA5GLxPMd3IvnWujuad0kNcv+5oO2UqCJvg4202txT2GmsRMN0lDH2e
 sjpxZdxLfplVdzqxyBfbiZQHZgYWFEgo1ziBAf6/A8c6Nuli9o7twqHf9ZW+BU4SAQtFtXtPU
 3KT6/37cUPMIoA3OV+K8sOJw+FkzZdyEmmEgWHL+iiFFKKISkMnrP4ztm7wOqOSHF1sgeAd0k
 bIAp3t8H+enRvrGgOMHRH0nv4pGEnMzX6zagENBg3ZafPd6md2zgXY2Y2yDOLbebBQAuB01Ow
 3s2bN0r8f4A5VVQpdLmcdVeRyKgalJ89+ekB/8C489H48g//KPTqIJxtubyK46zLCCMuxCns1
 1BAN8UPkgZvZnqOletCDjTslQ1SINN5r1VJTl2k2txR3R6ZvgCkmAckLzxrSg0xA4WCFCpSJL
 5piyJiz8SdgTS3E3pG1w0nIPn8w1JlQ1fEYeHtddZhFap9TekIDfC3IiJb/+43xwJi7NSkwZt
 QkbDxsDSq9uK39mJwpcXtPj/Kp67qYv/Bcp4x1aD+U9OcWBcjdx6NpNG8NKfnP0HpA/TyNHIU
 vfzCM3edPSkRlse1HugPBOokbPyYG/QPFy6GaRX2jA1/SBINtT6PTIb4Rb5gRM0DTaRyYPZxC
 rNKkehFUnqji2QjGoQ4eiq2WAgrf49HU0Pg9DwD29SMcp6VAtJS/adnvPr1GRf4o0eDpY4kJm
 KgdZT45AtLMeBNZl0Ib9nPbXBjiA2gNM8soKmrVWr09TIruYAw1SRYOgVJbRfTl9nNqDt0vhX
 3DcKqUuk9Cg5uR69JJgzihB8pNbmkkGURZX
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


The kmem_cache_alloc_bulk() error exit path double unlocks cpu_slab->lock
instead of making the required slub_put_cpu_ptr() call.  Fix that.

Boring details:
1. 12c69bab1ece ("mm, slub: move disabling/enabling irqs to ___slab_alloc())")
adds local_irq_enable() above goto error, leaving the one at error: intact.
2. 2180da7ea70a0 ("mm, slub: use migrate_disable() on PREEMPT_RT") adds
slub_get/put_cpu_ptr() calls, missing the already broken error path,
creating unpaired slub_put_cpu_ptr()/slub_put_cpu_ptr() calls.
3. 340e7c4136c3 ("mm, slub: convert kmem_cpu_slab protection to local_lock")
converts local_irq_enable() to local_unlock_irq(), culminating in a
double unlock and unpaired slub_put_cpu_ptr()/slub_put_cpu_ptr().

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 mm/slub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3605,7 +3605,7 @@ int kmem_cache_alloc_bulk(struct kmem_ca
 				slab_want_init_on_alloc(flags, s));
 	return i;
 error:
-	local_unlock_irq(&s->cpu_slab->lock);
+	slub_put_cpu_ptr(s->cpu_slab);
 	slab_post_alloc_hook(s, objcg, flags, i, p, false);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;

