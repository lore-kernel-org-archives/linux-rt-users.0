Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25025C5519F
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 09:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE185206D5
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 09:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UNrg2wsO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s7Mxhqsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgK3J5o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 04:57:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47668 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgK3J5n (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 04:57:43 -0500
Date:   Mon, 30 Nov 2020 10:57:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606730222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tflltwWoQDFzEIAZfxQcqqkmminXYJhABukrplz/Nbw=;
        b=UNrg2wsOoE0VrcMOyXLbIjYA1kJQXs2k1tIhahGql5cbUAaPMgRvL5a4KIwBKwEs3VgQpE
        pZ6kRE1DqfqDN/pcpticnMSoRLz0ULSxi06mXw5/+Eg1DDdv6qSfuvj8kzLLs2cOuu312/
        T3TxcV/ZduYDC3do6Q+KenlqzxEICy54ZLO+foKmdEa+1yVO93JzBih8xzlTzApzIECb70
        QDI7o4MxgihJi4Cynu90SdurZBBCynouvVvybdTUnlcmGTuMW53vPOYYZ+wy+7dshfIlJS
        ZogN59xsm+Y3g0tNtLJZX65O9dDzHwWxO0SWObDE8cnLcBKb4yGqlP2Eqi6PHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606730222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tflltwWoQDFzEIAZfxQcqqkmminXYJhABukrplz/Nbw=;
        b=s7Mxhqsz3VUZ8tm5TlB2PJ2nMBYxo12kkCdZnTRRtOl7lZrnDgbEwDSL8RchAMuyFvM7fu
        Yl+HKAeHbI2LyeAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc5-rt11
Message-ID: <20201130095700.btb5fgzn4k3st52c@linutronix.de>
References: <20201127165957.eukejthckysmjk76@linutronix.de>
 <20201128143651.wjxajv5yrkjv2q4w@spock.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201128143651.wjxajv5yrkjv2q4w@spock.localdomain>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-28 15:36:51 [+0100], Oleksandr Natalenko wrote:
> Hi.
Hi,

> It seems that the v5.10-rc5-rt11 tag was not pushed:

Indeed. Just pushed it.

Sebastian
