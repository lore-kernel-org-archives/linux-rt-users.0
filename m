Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC49C4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6769960C41
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhHDQrx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 12:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhHDQrw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 12:47:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007F8C0613D5;
        Wed,  4 Aug 2021 09:47:39 -0700 (PDT)
Date:   Wed, 4 Aug 2021 18:47:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628095657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UxPYxOF4A4JUP0r6M+S9tDc8uzqmIZFWGWT516RNpn8=;
        b=o9BnbFXXPzOZZ/x+VXt9pCIu3NyUqiCBTx7LLcRJyaYB4A3v0C/AqWQYv3mDJove6Ot+QF
        U0ldEhCZ7SoLHFK+qpmorw/014PQuDOYKAiukoaYhKl8CbYV9uLor1DWBwb44Sy8CFym+s
        7bW5qLK4DfNwCuv8L5+uJ/hu05H8thLVzN5ljJm7paK0XZTwFTF3bhmSjromhlIx8JY41i
        Pyv5KU1rPctfC/wc+K9GQ7bGdyuuycA1MyFRntiubN6sAZzY2Tl/rqFMe9Q1JAb1GP1qbw
        FAeEOfcZWY4re92yz3cssmCzjilozcD4sx6RVclq+wGhmhOQYDgQM35R4nDTYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628095657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UxPYxOF4A4JUP0r6M+S9tDc8uzqmIZFWGWT516RNpn8=;
        b=ZLjcLvnMiKWbeqbfLvgOONa1DvU8L6n839OIwaXSFVM0pRo7WU7bE5gZpYoSv0b09FFOrd
        F59mW7PYjqlvCJBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804164735.sq6sjejusa37abkw@linutronix.de>
References: <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
 <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
 <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
 <20210804154743.niogqvnladdkfgi2@linutronix.de>
 <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
 <20210804155747.cwayhjsdjc4zaubd@linutronix.de>
 <c3fa07d1-a3c4-6775-f419-4875eb41bc88@kernel.dk>
 <20210804122029.6c5c837a@oasis.local.home>
 <4ffb8f7c-085c-f6cc-e308-3f75b24b8e47@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ffb8f7c-085c-f6cc-e308-3f75b24b8e47@kernel.dk>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-04 10:22:59 [-0600], Jens Axboe wrote:
> 
> In that regard, I do still consider those patches out-of-tree, which
> they are. And while I'm more sympathetic to them compared to other
> out-of-tree code as there's a long term plan to get it all in, it's
> still out-of-tree. Best solution here is probably to just carry that
> particular change in the RT patchset for now.

So today in the morning I learned that there is a memory allocation in
an IRQ-off section and now, a patch later, it is almost gone. So that
makes me actually happy :)

The spin_lock_irq() vs local_irq_disable() + spin_lock() is documented
in Documentation/locking/locktypes.rst.
That said I have no problem by carrying that patch in the RT-patchset
and revisit it later.

Sebastian
