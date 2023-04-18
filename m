Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA22C77B75
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Apr 2023 15:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjDRPId (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Apr 2023 11:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRPIc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Apr 2023 11:08:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A376C97;
        Tue, 18 Apr 2023 08:08:31 -0700 (PDT)
Date:   Tue, 18 Apr 2023 17:08:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681830510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75KsEmvYQy/DSB/q8qRWT5/I9jFfd1OWuZ0WyNDPhU0=;
        b=MszvwWBrJMT7c5nIIB+BI++c5db8pjJizdbkLiUzT0Po4EkdqKQk422EL2PSTtuc5bh9vy
        2+/iR4qLemxJRRvEchiyIiEYVAI9BpyADXts4+xsNLMIl2aKrv1zCnQuq+RNQ7DhF45Db/
        2v7bwZ4p+KdKpyzPnJpvv6kLf5ZJlAogt0uFz4j9hy24Zmg9X1G3v4NyeOQ0TNY7N3udoA
        Hz09mi2q/BL3sP9Yi9TeClL6ZNsHrG6IYuAdx2yKHcuTUp1a57fFg65CCjceCel0t8eVBm
        aWmclGjiMpeh8cloCSmxvpRWtn2uqWxE0aoRp/tPZ7zlsifukLQpjdv9M+cw+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681830510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75KsEmvYQy/DSB/q8qRWT5/I9jFfd1OWuZ0WyNDPhU0=;
        b=IolrOAjHEHrNTeUuEBjIJFKs2aK5/iv5uGURxzS5/hwpHG2zIQMB6ZV42n0XMoGY9TJueN
        6VOxUK/7uk077SBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Pierre Gondois <pierre.gondois@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] v6.3-rc2-rt3
Message-ID: <20230418150828.tNv46UyK@linutronix.de>
References: <20230314170502.OHw1_FK3@linutronix.de>
 <20230314171231.jwtham4a@linutronix.de>
 <9ee941ae-ae22-f14b-4e69-f81b29bbba4b@arm.com>
 <87ttxiefpd.fsf@jogness.linutronix.de>
 <73b5657a-4c47-980a-e709-cd6a880c067c@suse.cz>
 <87pm86ece2.fsf@jogness.linutronix.de>
 <c49c2984-10a3-de8e-c12b-9a3833270a11@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c49c2984-10a3-de8e-c12b-9a3833270a11@suse.cz>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-04-14 17:38:56 [+0200], Vlastimil Babka wrote:
> What I meant that in the linked thread a solution seems to be forming in the
> form of annotation for lockdep/CONFIG_PROVE_RAW_LOCK_NESTING to make it
> aware that on CONFIG_PREEMPT_RT the problem it sees is side-stepped so it
> shouldn't warn about it on !PREEMPT_RT, and maybe that solution could be
> used for the printk issue as well (I admit I didn't check the code, just by
> reading your mail it sounded very similar).

Yes, you right and it would work and I would include it. Once the
DEBUG_OBJECT part is merged (the LD_LOCK_WAIT logic is missing) I would
add something here.

Sebastian
