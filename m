Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86781C56202
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Nov 2020 16:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C18220B80
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Nov 2020 16:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IElK7CvE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PPilfPvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391534AbgKZQf4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Nov 2020 11:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390021AbgKZQf4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Nov 2020 11:35:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D88AC0613D4
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Nov 2020 08:35:56 -0800 (PST)
Date:   Thu, 26 Nov 2020 17:35:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606408553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpUtxcBTQzI711Z2ADNYfTHEodwwjxuLJ5r3Sp0Ogic=;
        b=IElK7CvEfFXu4ijRaNwfWO+ghiico5X+4WpSY+TAFZRHnXRjkJFv2dDikJQnlom1m6brAK
        xHepRMsY0a3NT8dCoA/mjnmOrEwqwr4uVF+IOZlskfIsjjH0pRawhFS5qeLF1mabdZqB5J
        j4rJJeMAMXAWknu4grqgn7dARuW4clJHVSE1IsE/142LugZnTTTuWF9W+sVuXU22RUJOpV
        RtRYli3bc3DWbJMZBiKGfBosBSv6Z95JJmiQtOuqeEEQML8AchRyPpDRcOFhgnCgoBjydJ
        oIB7S5qGSpnfUCoCyYEh3BKjEBfDbeArRgg7xBSx04/EmSELRNmQ3/Z+avU3Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606408553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpUtxcBTQzI711Z2ADNYfTHEodwwjxuLJ5r3Sp0Ogic=;
        b=PPilfPvPyCp4cESlj0ZK4ikZSH2i4o0+fo5XFryqyc9f5mM5JKXLBtrg4ieVBIzrj/7FEe
        b1SZ452hCcwrHPDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     zqiu2000@126.com
Cc:     linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, lcapitulino@redhat.com
Subject: Re: [PATCH RT] mm/swap: use local lock in deactivate_page()
Message-ID: <20201126163552.ago5fpy3opi5nb7p@linutronix.de>
References: <20201125142858.2559-1-zqiu2000@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201125142858.2559-1-zqiu2000@126.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-25 22:28:58 [+0800], zqiu2000@126.com wrote:
> From: Zanxiong Qiu <zqiu2000@126.com>
>=20
> get_cpu_var() calls preempt_disable(), while on RT kernel,
> pagevec_lru_move_fn() will call spinlock and might schedule
> the context out and hence the schedule bug occurred, issue
> is found on 5.4.70-rt40 and reproducable on 5.4.74-rt41.
>=20
=E2=80=A6

> 2154a0abcc9 ("mm: Revert the DEFINE_PER_CPU_PAGEVEC implementation")
> reverted the lock/unlock_swap_pvec function, however, get_cpu_var()
> was added back in deactivate_page(), actually, get_locked_var()
> shall be used instead to avoid preempt_disable() call for RT.

The commit is
    32154a0abcc97 ("mm: Revert the DEFINE_PER_CPU_PAGEVEC implementation")

the reasoning is correct. deactivate_page() was added in v5.4 and I
missed that part when I added back the old patches which did not handle
it :/

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Signed-off-by: Zanxiong Qiu <zqiu2000@126.com>
> ---
>  mm/swap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/swap.c b/mm/swap.c
> index cdb4f1fa3a48..463cac334fcf 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -666,12 +666,13 @@ void deactivate_file_page(struct page *page)
>  void deactivate_page(struct page *page)
>  {
>  	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
> -		struct pagevec *pvec =3D &get_cpu_var(lru_deactivate_pvecs);
> +		struct pagevec *pvec =3D &get_locked_var(swapvec_lock,
> +							lru_deactivate_pvecs);
> =20
>  		get_page(page);
>  		if (!pagevec_add(pvec, page) || PageCompound(page))
>  			pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
> -		put_cpu_var(lru_deactivate_pvecs);
> +		put_locked_var(swapvec_lock, lru_deactivate_pvecs);
>  	}
>  }
> =20

Sebastian
