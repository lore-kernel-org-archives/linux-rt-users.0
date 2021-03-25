Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100D2C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 09:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BED4B61A0E
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 09:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCYJPj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Mar 2021 05:15:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46364 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCYJPK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Mar 2021 05:15:10 -0400
Date:   Thu, 25 Mar 2021 10:15:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616663709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9y1yp/euJECyuFFoRTMRja4i7Cb/9cPre8h0EO3ena4=;
        b=u3NvCOh3salUZxdQRYhdKgVOCPnY4vcxX3Zc993LP+x2sB3GKb3jWyMzxctHvnDQnoB3FN
        8R+jiWA5ighl0+DM4+x7L4Ufpd6W5g2eccOifbHbFO93MFrR6SYY/Uye32pbUzvxUvIuzR
        BvBtkPpmch4QXJ0W2bU1fBEhQKooEurkl03Myjv3SFR2RQocJMJQnkiFJrI6DyikF2bSHZ
        cAY8jusyZh74YGlCtTN9CunzYNP6GoGuCcio6VIdXWji8OHF1oFV05zM22a8Qyy4bITXZj
        i+x/8UXE8wcTPQAqSFvYhvvXIdu7ig8jpSKoOynn/uf6btio+PT35H2uBRQ1Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616663709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9y1yp/euJECyuFFoRTMRja4i7Cb/9cPre8h0EO3ena4=;
        b=CCPpI4M9LEAV8+PCFAwyBIp1ATX9/crJI2hClwM0zQEyEtTgbNM+a1tHnont1oXijDx3+B
        N9DwrNFRSUgdrFCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-rt-users@vger.kernel.org, kernel@pengutronix.de
Subject: Re: "printk: move console printing to kthreads" breaks NFS boot on
 i.MX8
Message-ID: <20210325091508.w3evcij7b4bbrwkt@linutronix.de>
References: <20210325090746.ukwwhslcruo77sqq@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210325090746.ukwwhslcruo77sqq@pengutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-03-25 10:07:46 [+0100], Uwe Kleine-K=C3=B6nig wrote:
> Hello,
Hi Uwe,
=E2=80=A6
> I bisected and identified
>=20
> 	42afcbce7b62 (printk: move console printing to kthreads)
>=20
> as the problematic commit. I just double checked that 42afcbce7b62 is
> indeed bad and it's parent boots just fine.
>=20
> I didn't start to look into what is the actual problem yet. Does this
> ring a bell? Do you have a hint how to debug this?

I don't see a link. I'm don't know if there will be another v5.11
release.
Could you please check if this problem exists in the latest v5.10 and
v5.12?
v5.10 will be maintained longer.
v5.12 is more or less staging for upstream. Its printk code should be
newer compared to v5.11.

> Best regards
> Uwe

Sebastian
