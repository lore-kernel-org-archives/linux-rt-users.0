Return-Path: <SRS0=gcb+=EK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9E4C388F7
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 10:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537812065E
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 10:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iAyysEd2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aLraScZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgKDK0R (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Nov 2020 05:26:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48404 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKDKYy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Nov 2020 05:24:54 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604485493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QF7gOMWfQDZgYKl8HMctCKSmJoXxRmC5ydZKdzt45/I=;
        b=iAyysEd2Z5k1ZT91y/zLech4NG6DuvCEWaYRM5oB3PUnOI08agh5Lt8Z1edtUyJIL3WJqa
        +pP/3rDBuyG9A3wAcad8ZGQK+uYdgpHY1dC/dJkr01QlReTMv48nPaKexn/LGcVlDLLOSF
        dOYMIt1LcBhltGf0BXnrRgSCxLWFx6RiOODHLKCSofy28/mvYvuGsZry4SiXxy+JvnMl+b
        sYe+Kq2XdZHrfpXFy4l0uorgezpJbG8WNb5e1iAgN5Ui5WQVFdfG5vwjK+ak/SVDlR5dy+
        /OMFUDju+zJI+x2tHSc8ajC336KvWvcp8PsSJXWV2EMLlMoh+rnAbxP+aPzA5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604485493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QF7gOMWfQDZgYKl8HMctCKSmJoXxRmC5ydZKdzt45/I=;
        b=aLraScZgkWsVIFnZXILsnEAOiqFRSIC3DgMrnzRtPqWpbl5PAy0FtBlncddV4j+/KAcnG2
        pvsU2Sq6YtqYp1Ag==
To:     Mike Galbraith <efault@gmx.de>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Brandon Streiff <brandon.streiff@ni.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        James Minor <james.minor@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: BUG_ON(!newowner) in fixup_pi_state_owner()
In-Reply-To: <5f536491708682fc3b86cb5b7bc1e05ffa3521e7.camel@gmx.de>
References: <87a6w6x7bb.fsf@ni.com> <878sbixbk4.fsf@ni.com> <2376f4e71c638aee215a4911e5efed14c5adf56e.camel@gmx.de> <5f536491708682fc3b86cb5b7bc1e05ffa3521e7.camel@gmx.de>
Date:   Wed, 04 Nov 2020 11:24:52 +0100
Message-ID: <874km5mnbf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Nov 04 2020 at 08:42, Mike Galbraith wrote:
> On Wed, 2020-11-04 at 01:56 +0100, Mike Galbraith wrote:
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -2383,7 +2383,18 @@ static int fixup_pi_state_owner(u32 __us
>  		 * Since we just failed the trylock; there must be an owner.
>  		 */
>  		newowner = rt_mutex_owner(&pi_state->pi_mutex);
> -		BUG_ON(!newowner);
> +
> +		/*
> +		 * Why? Because I know what I'm doing with these beasts?  Nope,
> +		 * but what the hell, a busy restart loop let f_boosted become
> +		 * owner, so go for it. Box still boots, works, no longer makes
> +		 * boom with fbomb_v2, and as an added bonus, didn't even blow
> +		 * futextests all up.  Maybe it'll help... or not, we'll see.
> +		 */
> +		if (unlikely(!newowner)) {
> +			err = -EAGAIN;
> +			goto handle_err;

Yes, that cures it, but does not really explain why newowner is
NULL. Lemme stare more.

