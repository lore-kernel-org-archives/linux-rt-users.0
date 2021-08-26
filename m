Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E9AC432BE
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 15:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A210E61026
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 15:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbhHZPTT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 11:19:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32778 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhHZPTR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Aug 2021 11:19:17 -0400
Date:   Thu, 26 Aug 2021 17:18:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629991108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3zue165L4KWF/Yn6MZ6VV0wxa4gJF32q3Ptr3Tfjkx8=;
        b=JZckgiHb0unbBwrEtXHiy+nF+8VaDu4s36q/fOCJ4rXq1wOpXsuuUsK9RLLNRMhvVK3j7f
        N8Wo1rqs/Zd3+serXhLDbASpY1JmV1e3GE7a9sNZttM8SSgd6sU2Ftm6+Vp/SnTcvOA/Iy
        G6+enBFFJXBUrJg4uI5dP/E+ldj8+4HBj012ydi/CHZwaV7iiq5QKsFEE5OOzZQqKnkm64
        r05PjO+32UwEHOSmIL3qUptaukYVkG/+eB8ZYpggOdfyT5ho5rbq47JW1WDPqxWiPcUoS9
        FYv0kOQLce6j+BBK4f2+eHsnlhf45IdCtNrNMNWVMO8DHXQzNPRrO0bQlE1ocg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629991108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3zue165L4KWF/Yn6MZ6VV0wxa4gJF32q3Ptr3Tfjkx8=;
        b=jH0bL0wFVFygjr9kHgSY6RgoyVcdeyf2k7JhfwkZHOah+9B2ug6Diz/LNkGLOGvbq5vASy
        n154ibwnBvQeNcAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mike Galbraith <efault@gmx.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] kcsan: Make it RT aware
Message-ID: <20210826151827.wvsm7civflz62olx@linutronix.de>
References: <dc0cb448d46f465bb0064b1c301cb0b3ab4f8492.camel@gmx.de>
 <34f1e1dadb2c3d19389427303da6ea53e321e726.camel@gmx.de>
 <86f35f7c-c545-d870-b36e-5d091799f54c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <86f35f7c-c545-d870-b36e-5d091799f54c@suse.cz>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-22 19:29:00 [+0200], Vlastimil Babka wrote:
> On 8/22/21 6:35 PM, Mike Galbraith wrote:
> > On second thought, burn both patches.  Making K[AC]SAN work with RT
> > ain't worth the warts.
>=20
> The stackdepot part of kasan patch will be useful at some point.
> slub_debug should eventually switch to stackdepot - it almost did in
> mainline already. I'll try to remember and dig that part up when needed.
> Thanks.

If you want them dropped, sure.=20
Regarding KASAN, if the on_each_cpu() is really needed and why the
workqueue version of it can't be used. Sure without it it is simpler=E2=80=
=A6
The stackdepot doesn't look that bad. Maybe with pre-allocation like we
have for debug obj.

> > 	-Mike

Sebastian
