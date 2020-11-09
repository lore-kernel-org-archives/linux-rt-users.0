Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7CDC388F7
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Nov 2020 16:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7872068D
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Nov 2020 16:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mu457md3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/vucz2X5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgKIQbq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Nov 2020 11:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729973AbgKIQbq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Nov 2020 11:31:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BDCC0613CF;
        Mon,  9 Nov 2020 08:31:46 -0800 (PST)
Date:   Mon, 9 Nov 2020 17:31:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604939504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cfIH4zCygb0xsqKOAsZVWmK7sE1u+5N1IHdvzVHI/o4=;
        b=mu457md3fSMTD2xwNljjTZjhceTk+SZUIdHZSPiEFU/IGRc6FbaehdAfwPoK1+PxDcFz0b
        hnBdQaPYLJamGrbAWA/3KqYlh5Fys9eEqEAMm/9KNRgLwyIdLcUashJOmv1fG58V++F5SQ
        OI+8Zyid+MCbsGuCwD4oy+qIENofF/jnOLouwIDSCVnaNA8ppxQMghiTRZqLd3JdfuNpC+
        GwZB+mGJpGlAOeaSfKu8K9mJ3RF5zbf4CS/FMgjuvEBV9kliyl7DmWqS+HxFphjMMK38qM
        mO0ig6dtEp1L+JufZYbxxcF42jXVggxYo8ENstyz0UcY+RTX7RgRXPwhFSy3Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604939504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cfIH4zCygb0xsqKOAsZVWmK7sE1u+5N1IHdvzVHI/o4=;
        b=/vucz2X5YHGAJoFEVrfQps+GNc4JBuBkgFMybIbKrxXXCa1hJ0hsQEEDjhEvJtK8nj9IuO
        HFyS+ApwZYTe1XBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201109163143.tm5gjz77rr734lm5@linutronix.de>
References: <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
 <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
 <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
 <20201104124746.74jdsig3dffomv3k@beryllium.lan>
 <20201104130930.llx56gtqt532h7c7@linutronix.de>
 <20201104160650.b63zqof74wohgpa2@beryllium.lan>
 <20201106105447.2lasulgjrbqdhnlh@linutronix.de>
 <20201106161413.7c65uxenamy474uh@beryllium.lan>
 <20201109124718.ljf7inok4zakkjed@linutronix.de>
 <20201109143703.ps7gxhqrirhntilr@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201109143703.ps7gxhqrirhntilr@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-09 15:37:03 [+0100], Daniel Wagner wrote:
> > this looks odd. So rt1 has 415, rt2 has 399 and rt3 has 420 so lets say
> > it is the same. And then rt4 should reduce it to 340. The only part that
> > could have some influence is the are the highmem/kmap patches. But for
> > ARM64 these are still a nop and in both cases kmap_atomic() disables
> > migrate & page-fault.
> >=20
> > Are you sure those numbers always reproducible and not something that
> > goes wrong and sometimes it is captured at 300us and sometimes 400us.
>=20
> These test run only very short with hackbench as worlkload (5 minutes).
> Though I running these tests now for more than year with v4.4-rt and
> some times the newer -rt releases and I've never seen the latency
> numbers above 200us unless something was broken. Given that 5 minutes is
> not really long, I'll let those test run for longer to see if I get the
> same results when they run for one hour.

oki.

> > I've been staring at the code of signaltest on Friday and I might need
> > to stare longer to figure out what it does.
>=20
> I hear you. Anyway, I gave the current head a run with lazy preemption
> disabled as you asked for.

=E2=80=A6
> 5.10.0-rc2-rt4 vs 5.10.0-rc2-rt4(lazy preemption disabled)
>=20
>   0_cyclicdeadline     t2-max-latency       pass/pass                274.=
00/     61.00     349.18%

So the value went from 274us to 61us after disabling lazy-preempt?

> cyclicdeadline seems heavily affected by the change.

Sebastian
