Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3219C64E8A
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 14:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7E420705
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 14:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3dvLW58j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y/LNifvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgK3O2t (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgK3O2t (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 09:28:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E5BC0613D3;
        Mon, 30 Nov 2020 06:28:09 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:28:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606746487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JhhjWTvHpqu/MrU5zt4R7Kl4BBTN/cdgdM4DvMarTbg=;
        b=3dvLW58jDbCkGYq836uWzvEPdYeLu0jH6E5hk7RHShRVZ+7SkvPcTilFkwvJbu2BaLTuMp
        Pr+7YydW9/vzPIgCKggYBt3FxJEeIpXUKVjo0U+ipmOSNO9ynEgmps5L4HVualzv/Y2q9W
        67eQcxAKdgzDIGAJLkIY+JDj+QgXAOoIEyaLxb3kGLCbW3C/AkGizMonJmJW3QvAxxLDoP
        YaXesoUGXuFlnAjT87gG99b3uqrJ1G6bwDkLpT+kVD+/LOsdJHxMwCL7cvX6c0yPxoWsf4
        XRsu0nFrrdKRfo7djQEzo2pftCFMmRf/g0qG0yHnJpMvgLyDzyoJ77UWRKR93g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606746487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JhhjWTvHpqu/MrU5zt4R7Kl4BBTN/cdgdM4DvMarTbg=;
        b=y/LNifvj+o9uDsEcVQl+oFz0n0bGiYJRO2oE3oIG0FXzRZrkVMZLyBO8qYjNGl9QPWw7W9
        UTVM58CIn1QKsRDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: scheduling while atomic in z3fold
Message-ID: <20201130142805.ah46i3gfazcdlujj@linutronix.de>
References: <20201128140924.iyqr2h52z2olt6zb@spock.localdomain>
 <20201128142723.zik6d5skvt3uwu5f@spock.localdomain>
 <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
 <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
 <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
 <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
 <20201129112922.db53kmtpu76xxukj@spock.localdomain>
 <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
 <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
 <20201130135322.zi7moa57ajbdvfpy@spock.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201130135322.zi7moa57ajbdvfpy@spock.localdomain>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-30 14:53:22 [+0100], Oleksandr Natalenko wrote:
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 78a20f7b00f2c..b24f761b9241c 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -394,7 +394,9 @@ struct zswap_comp {
> >  	u8 *dstmem;
> >  };
> >  
> > -static DEFINE_PER_CPU(struct zswap_comp, zswap_comp);
> > +static DEFINE_PER_CPU(struct zswap_comp, zswap_comp) = {
> > +	.lock = INIT_LOCAL_LOCK(lock),
> 
> Is it a residue?

It as been added on purpose.

Sebastian
