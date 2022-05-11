Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4047C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 May 2022 16:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245081AbiEKQTB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 May 2022 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344526AbiEKQTA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 May 2022 12:19:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED0F532CF
        for <linux-rt-users@vger.kernel.org>; Wed, 11 May 2022 09:18:59 -0700 (PDT)
Date:   Wed, 11 May 2022 18:18:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652285938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CXD7+tDH9aaCgTGorUoFCoIw6jkDsDIiVDDVDAFt6q4=;
        b=R8JBDZCQQPEallqtbQsqvfWRXuPDXoAgCCer5ci5hct14UOA2Djzrg0g/qW+mM0c0ohuUI
        PjmO7IGSGwVQTU/S6nWRpI10y2EHguSUpevHEFMsUoNGbLDBzXbNEgmN2sXntvaS1gNLVr
        WlyWAyDajZDrKmAmKBskCicHBwKcsvXQlZXPHxy1d7lR2QEhP4k8zx2tRAn/wXq68NdoKY
        AUrNWvk/jQOOf4gu2tMVKqkBAbZvyUxxeuUWV+NaIBSiwPbtwKXsOWlqPUbr6KopdQhxag
        SMbYIqeLRGP7oAceEFlcm004qM7ViGmvnDyRjD9A10SFjcaPFqMSN0Kdy/p45g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652285938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CXD7+tDH9aaCgTGorUoFCoIw6jkDsDIiVDDVDAFt6q4=;
        b=q3vUlH1m15bz4B0c95O+9Ajo8rQnGv6y8gSOgYyu2bq9xX1ewcRhyu3Mulex08L1Qi1lcp
        IrEJvTRPqQiBcVBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yimin Deng <yimin11.deng@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Oops or bad page in page_alloc.c
Message-ID: <Ynvh8Nh7hyp4tSKk@linutronix.de>
References: <CAAh1qtktzZQxXp_t43YhxL6FZTS58rn_xvK2Zrq33-s3=j_sGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAh1qtktzZQxXp_t43YhxL6FZTS58rn_xvK2Zrq33-s3=j_sGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-05-09 15:40:43 [+0800], Yimin Deng wrote:
> Hi
Hi,

> I encountered an oops in isolate_pcp_pages() and a bad page in
> get_page_from_freelist().
>=20
> linux: 3.12.37-rt51  (CONFIG_PREEMPT_RT_BASE not enabled)
> arch: PowperPC (e500)
=E2=80=A6
What you mean by CONFIG_PREEMPT_RT_BASE is not enabled? Is
CONFIG_PREEMPT_RT_FULL enabled or none of those options?

> Any suggestions will be appreciated!
>=20
> [18857088.953420] Unable to handle kernel paging request for data at
> address 0x00100104
> [18857089.046143] Faulting instruction address: 0xc0075624
=E2=80=A6
> [18857090.073578] NIP [c0075624] isolate_pcp_pages+0x84/0xc4
> [18857090.138173] LR [c0078f24] free_hot_cold_page+0x124/0x174
=E2=80=A6

I can't even tell if I saw a report as yours earlier or not. I do
remember that I saw the "bad page state" reports earlier but I don't
remember how they went away. I know that I had two 8572DS systems and
one started to report all kind different errors (including "bad page
state") but this was due to bad RAM (probably) since the other system
never had this error despite that they had the same configuration.

Your kernel is kind of old. The latest v3.12 is v3.12.74-rt99 which
contains a few bug fixes including commit
    f1aca90802af9 ("Revert "slub: delay ctor until the object is requested"=
")

which is probably not what you see but a possible crash.
You could disable memory compacting and so on but as far as I remember
they could lead higher latencies in some cases, not to a crash.
You could enable list-debugging in case an entry is added/removed
multiple times.
The e500 support is quite good upstream so you could upgrade to a later
kernel (one of the current LTS kernels).

> B.R.
> Yimin

Sebastian
