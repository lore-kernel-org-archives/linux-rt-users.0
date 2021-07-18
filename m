Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1DDC636C8
	for <linux-rt-users@archiver.kernel.org>; Sun, 18 Jul 2021 15:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C9061183
	for <linux-rt-users@archiver.kernel.org>; Sun, 18 Jul 2021 15:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhGRPqQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 18 Jul 2021 11:46:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:56665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232895AbhGRPqP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 18 Jul 2021 11:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626622986;
        bh=a+VvLRIxhM4HpYMb3aSKVzaKVRxoB06CViB/BbBakoI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ImynfnIpUFmhlBzlUzYKMdRUnM1qgiFmW0x45GUJpFov/xNjPCsHaUqhLtBcUAn9W
         PiaMAJ1pdClM751DHET5hXhoLlFJTSJpd181sHiV6lwLyXLyBxxHXWi6dS2BXVB1Gm
         fZWHQUf7GgRCk/DZlSNJcuMsmPgNPnT0pWX4Bpmk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYXm-1lOxRU0Axy-00m5bA; Sun, 18
 Jul 2021 17:43:06 +0200
Message-ID: <fba5b2ca7472ea06690e4a92ba0fbd4dd8557f86.camel@gmx.de>
Subject: Re: [patch] v2 mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sun, 18 Jul 2021 17:43:05 +0200
In-Reply-To: <476d147ab6eec386a1e8b8e11cb09708377f8c3e.camel@gmx.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
         <878s2fnv79.ffs@nanos.tec.linutronix.de>
         <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
         <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
         <476d147ab6eec386a1e8b8e11cb09708377f8c3e.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r16f4cB0F6DSMRY35FPrWtAmuhXmjMyXaD80Tug0wlWZeLA/shA
 gbSnrzuyxOMuQT5Xqm9jzmEZpgp39LttxGh5qUJidYNpBnkunaRa/fZS5MxA8/ua5vwNgaA
 NJ/vRdkaxWTAlldWuylcQznU2xRY1q+EFRJTUWTDLkZOCRh7ovdVDC7EjizpVdyIzMzJezm
 XjoJTcGkcRypmTLxKkAlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IfIZN4BWmn8=:EQJILZUQNjelhPj94JRUlw
 eoZhFT2lUk+a8lQMeARAQ31IN8USPAZjEcbqoaTbZoHQBN1RAWinSVZrXfLaM2yoCqLuF08tU
 WbBH08kRe86RxJVbnB3NeN/TWrhFpi8To0fq52E+YayFv8cnOmFdUSHCig+BcDA1/xJbE6iZD
 KTut94TfY/gVm5V2sfXZy78zrN5hiUexeef0ujRNF6wmrzawc64577GyNM0XhcmDtD5iNikIH
 bMNRAlqObE0GiDhWYqsvyoL2uveaYLPSl1xbmYoePDjJdgs9zTccTQhFpgBimdT4rdh1cjQfj
 e3Q/cureqHYsUQ6/6M7JtFfg0VCjNBwhPwHX4QQx29EKx02uCvW/nCXOiwuhKZHKOltMsTwww
 BiZe9p7KMWJqT6SjASHN21VWaUjUj4KlkkPHtWQhAjcewoEuqTD65AbgJbdmeBHyvfcqFH3lr
 xsuIMdet1OM2kH20NpUDQAcO9MLHQSOdeVkIhLSCQsRTyJr0CIARC68t6xzWuMiTyF106nHLt
 4CK5MB/WpWSdXhPYdE5kj/1OK6J8e6k8OMLYLBoEulvSjnJgCmXmAJHcxhP6Dk15wHQjbL+75
 7VXa8vqC3JrtdfZJnrPze4xRLiLSVXGy1jzMHJQDE6AoqKGdAZU9smgwM+tll/EJBP52WwC8s
 M5ImoL15HysJnmv+gB8IkU78FFOXF0elB5YE6Qy5smrFLVVjLcrBlx+1WKuW/qpQJgXNeAkFD
 Rxf8a9EGcZPpHxFgEpOLFD3uIPTfiJNBOzkYKYuSyf5pulHk3+YKPU4VuW0y4n2w03hsOfwqF
 jSkeTPMaRE65oqOQ+XjGOeKkbQOk/mK/AbqzRWSm9Dy8PwGHuHnEg9h2lzhzkNpXlLLlpAi+o
 2fKzV18D3R5P/rlfGn/F7cujW2dTLNV/YbmU5flQsZ+AomOM2aBHIW7Xdav440QPkikPBffZq
 PzIQ/Tyb/CO8IKQnuTbiUADiIqQbbA1iFkk1DnXSZhuBB8oZzg99QwTxlK7v5Nxq+5kFKuKTs
 5r6mkS6VjVtVrU9yInKoFV4lu4b8cveoBl3LlOy1pBHc2/4Nihsft95vrkFfUAzOr+K+4LAnx
 m+rgnXIAbcTDOnxBtCDJdXHtu6SywdzU2u4
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

It's moot, but for the record...

@@ -2418,6 +2418,17 @@ static void __unfreeze_partials(struct k
>  	if (n)
>  		spin_unlock_irqrestore(&n->list_lock, flags);
>
> +	/*
> +	 * If we got here via __slab_free() -> put_cpu_partial(),
> +	 * memcg_free_page_obj_cgroups() ->kfree() may send us
> +	 * back to __slab_free() -> put_cpu_partial() for an
> +	 * unfortunate second encounter with cpu_slab->lock.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && memcg_kmem_enabled()) {
> +		lockdep_assert_held(this_cpu_ptr(&s->cpu_slab.lock.lock));

...that assert needs to hide behind something less transparent.

	-Mike

