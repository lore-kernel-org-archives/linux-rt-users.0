Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27786C63777
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 09:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFF720C56
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 09:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgLCJss (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbgLCJss (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Dec 2020 04:48:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A201C061A4D
        for <linux-rt-users@vger.kernel.org>; Thu,  3 Dec 2020 01:48:08 -0800 (PST)
Date:   Thu, 3 Dec 2020 10:48:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606988886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdjqZekJLk1nY1Jg4B6dX8mNhTOhxyUg77FMuBfoKXc=;
        b=PKoso9QSBYbP9QMAXq7/4RoGY+1En15R0QvNSmQPsq3ju3GJgp8g57cUgfEKCcv3mdCEe8
        TU2V8Z7z+OhU6g3k9Ck4HxFInXixdDKlU+SBKhQ3OhE7hiNQU4ozWIt2jcuHhvP0v1MbjP
        9vXHYbNeEuRCOCruvVeUhb6IjVYEV5+COgpHWxMtNzDJfn0TnV1a1WSVTSHX4DMc1r+iMH
        MECu8Rh1QN2I26NQjKGJYGh5F5sOEPTfGb0z9V8Lg88ZJsXt2iZ4FxsPpDOymqo5t0S5Ft
        4O08L7VGwdsXPwMEvZsfmM0Ic6x1rm6lscEKQn9pRumTOzNjjWLMi7DzH3lFfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606988886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdjqZekJLk1nY1Jg4B6dX8mNhTOhxyUg77FMuBfoKXc=;
        b=QYanhV3NE1VuQ6Wys7Y161KaIqJZbYwb9JVcb1zFbK0vXOEf7pxDJTZXX/ClWRRB68VZRd
        MibCWtdD6j30pzBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
Subject: Re: zswap explosion when using zsmalloc pool compression
Message-ID: <20201203094805.dhk3f7mlth3vm6ck@linutronix.de>
References: <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
 <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
 <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
 <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
 <20201130160327.ov32m4rapk4h432a@linutronix.de>
 <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
 <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
 <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
 <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
 <345fdb33f5bc0046b80c6319e61e9ee33b83cac6.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <345fdb33f5bc0046b80c6319e61e9ee33b83cac6.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-12-03 10:40:16 [+0100], Mike Galbraith wrote:
> In thread "scheduling while atomic in z3fold", I mentioned that of the
> three pool methods, only zbud did not explode.  Below is the explosion
> encountered when zsmalloc is used in conjunction with runltp -f mm.  As
> with the z3fold explosion, this one also seems to be highly repeatable,
> this from one of my full distro "my box plays russian dolls [1]" KVMs.

great.

> [ 5763.720268] kernel BUG at kernel/locking/rtmutex.c:1057!
=E2=80=A6
> [ 5763.726016] RAX: 00000000ffffffdd RBX: ffff903f77c68080 RCX: 000000000=
0000001

That is a deadlock. Does lockdep say anything or does it disable the bug
=66rom happening?

Sebastian
