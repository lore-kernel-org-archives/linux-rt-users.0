Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EABAC83F12
	for <linux-rt-users@archiver.kernel.org>; Thu, 31 Aug 2023 13:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243286AbjHaNcX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 31 Aug 2023 09:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbjHaNcW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 31 Aug 2023 09:32:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE51CEB;
        Thu, 31 Aug 2023 06:32:19 -0700 (PDT)
Date:   Thu, 31 Aug 2023 15:32:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693488737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=693s0sjibYM7MeyIhOs0wc/rvr9Jp8mEARB1/hOwVUI=;
        b=kwTVa4eRXQqljWMjTC0CgnWT+cM3B1/9CmjTpRDZlUayw3RXGNCS1nsII8Fc1GRUsdQndx
        gRCyFXpX8FIpxiBw488Y3+G1jJDrmre79+k2WcU9PykvpLJxZObL3Xy04kPhOPZAR6LtHV
        TKvZl1hu7HI/+dp1GP9bDNr65upVlQ/ZBwKjzQ/ztgJzFJl5CXPO+vRSUkajodStqI4vcA
        +Lh69A/JFAml7CzyRYBXccKOLWxoh7gm5x2GUfrFF0Lul48VJ8dvTVHufXC5uv++lly2he
        mp24B83o9PfoJA5ZtuuLQR+LzbbdLH4YnL8E7FtlGr6FPrthu90isGdl7RWpbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693488737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=693s0sjibYM7MeyIhOs0wc/rvr9Jp8mEARB1/hOwVUI=;
        b=0xUF4Ws8yBs1qsob6n6h173b6H1cBxpY5r3TTBS9QiccOdD2ppSmSdgBzsclyNvAeYvMiG
        y3zyCn4Cmv3PbwBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Wen Yang <wenyang.linux@foxmail.com>,
        paul.gortmaker@windriver.com, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tick/rcu: fix false positive "softirq work is pending"
 messages on RT
Message-ID: <20230831133214.XF2yjiEb@linutronix.de>
References: <20230818200757.1808398-1-paul.gortmaker@windriver.com>
 <tencent_C80D3EE7563151B306E94C2AA7BF3023F80A@qq.com>
 <ff5263ec-96a8-4e8e-96af-de6ab8a17750@paulmck-laptop>
 <ZOy3S8ajaV8YWtE-@2a01cb09806c67d6fe4a366cc09da8f8.ipv6.abo.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZOy3S8ajaV8YWtE-@2a01cb09806c67d6fe4a366cc09da8f8.ipv6.abo.wanadoo.fr>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-08-28 17:03:39 [+0200], Frederic Weisbecker wrote:
> > Frederic would normally take this, but he appears to be out.  So I am
> > (probably only temporarily) queueing this in -rcu for more testing
> > coverage.
>=20
> I'm back, I should relay this to Thomas to avoid conflicts with
> timers changes.

I somehow missed this thread and I do see this if I enable NO_HZ. I lost
it=E2=80=A6
Anyway, I'm going to pick it up for RT and ping the timer department
after the merge window.

> Thanks all of you, clearly I wasn't thinking much the day I wrote this
> patch.
:)

Sebastian
