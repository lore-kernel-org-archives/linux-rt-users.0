Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1687C63797
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Jan 2023 08:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbjAQIxG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Jan 2023 03:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbjAQIww (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Jan 2023 03:52:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646824C2C
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Jan 2023 00:52:50 -0800 (PST)
Date:   Tue, 17 Jan 2023 09:52:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673945567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jgbws5IcTXpPYA+TIccNFu/oAysmZ73KGxRws3vcyF0=;
        b=WHGXsSxuorvZXkD3KuRVgBlLikykrXQOBcds4Pvfvq9FulEOoz5WPAYiGAIG0WWAkH/LSK
        qYZBZNvN48J5mqamzUsxv3CWo+mVEYp3noPnxUQafDGu+RCMQCO1HU/SsCy/7HaKQA4cO5
        5uyDI6OfpkiWrT3Ju6qEs9grE8W41AAo1Wjuhg7BdoDQFY6svJJ0dmo99Ty0T39IgOcj/9
        PtnklvIeAbA85ixCwkePATiEgbCuRdfUijDeG98dE9SgI0dhqrrMtCjc/7s08b1A1Vk48I
        SLkWLKZrx9Mhqy2cRGuL+HAAW2DJDzV/o2cYehtC/967yg2MbG0yQ4Q8Zrt17w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673945567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jgbws5IcTXpPYA+TIccNFu/oAysmZ73KGxRws3vcyF0=;
        b=HA8Yq+LhXw+MOkpVMBOVccZV10pMHorrr6y4DLzEUTpxvH5chaUOpMqc9SZChYRoRGni3B
        HUuPHC1lIpLpvJDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-numa: Use a reasonable default max CPU value.
Message-ID: <Y8Zh3h17Fu1uChsa@linutronix.de>
References: <Y7/aS/dW0H0CK8Oe@linutronix.de>
 <5515f090-51cf-37fd-68a-66283fb0c639@redhat.com>
 <Y8WaaXViNE5dEuyc@lx-t490>
 <25a775d-77e-e76e-a626-1e6c605e1df3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25a775d-77e-e76e-a626-1e6c605e1df3@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-01-16 13:58:42 [-0500], John Kacur wrote:
> 
> Okay, not sure how that adds to the conversation. I'm all for "sane" 
> defaults for --smp too, but we care about other kinds of invocations too. 
> As soon as I get a patch that doesn't break other things as well, I'll 
> apply it.

BROKEN IT IS.

I want to use that and not fix every time I use it. Using
	-S -p 90 -d0 -m

are already a lot of options just for a simple test to use all CPUs on a
system. This used to work on this machine. Now it starts way more
threads than I have CPUs. I accept that this might be something that
someone wants to test so he can use -t 100. But the simple test that is
no longer working. srsly. Starting more threads than the current
available online CPUs or even CPU affinity makes no sense since the
results with equal priority distribution or not reproducible.

> John

Sebastian
