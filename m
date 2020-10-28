Return-Path: <SRS0=Biag=ED=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F43C55179
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Oct 2020 22:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F06208FE
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Oct 2020 22:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oWOhmHgf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c98ZRA4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbgJ1Wla (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388251AbgJ1Wj0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Oct 2020 18:39:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B2C0613CF
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Oct 2020 15:39:26 -0700 (PDT)
Date:   Wed, 28 Oct 2020 17:40:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603903260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j7LlZ6FFv6ZKciSemcsmcX0SpqpuDZ/wVHDXbBgjYQc=;
        b=oWOhmHgfNovyZ9fJev1QjwqZWqF24ksygWeGafE2pX+wL0IJPIBKVQBt9YKkWxmuCTlKxt
        bwqRiEkkzV+9pIZzMnff0xb8OJyeayZEK1+gDt4IFaTRs5V7F34nFaXbCqFd77Fzk8A35R
        DPkfx9hq2JCtpUp21S55dME7ad986+w55oCg3zgbMVD6QHPZIImqAiEhtd3ZTT6mCWBfEC
        jV2INW0BPVRNMeITwqBTBvtu1SaxP0NUJNRkXWayzJwi0Nuwe4dVQUDO0vuaIUCmUlbTf5
        4bp/N4XkMHub9NJOjatJjHATOkIAMnDYXg+TMGTMU0P3i4aNvHiRSZTEBvsIhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603903260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j7LlZ6FFv6ZKciSemcsmcX0SpqpuDZ/wVHDXbBgjYQc=;
        b=c98ZRA4Lr4WHyqs8cVS8a2GgSKMMpzPHyMoZ3SYwpVeDD0swjMDi8nBczCWmWoSdPkT4Ys
        /xW3oNtrlccRSrCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     dieter@bieler.li
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Error-Report rt-tests
Message-ID: <20201028164059.m7ygqaikxqox6res@linutronix.de>
References: <006101d6ab85$88d32f70$9a798e50$@bieler.li>
 <007501d6ab85$f3369910$d9a3cb30$@bieler.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <007501d6ab85$f3369910$d9a3cb30$@bieler.li>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-26 11:51:24 [+0100], dieter@bieler.li wrote:
> 
> Hello,
Hi,

> I tried to compile the rt-tests-1.9 on my system:
> Kernel - 5.4.70-rt40
> Gcc : gcc cc (Ubuntu 10.2.0-5ubuntu1~20.04) 10.2.0

is this by any chance 32bit? Say i386/i686 or so?

> Error message:
> 
> 'bld/cyclictest.o: `stderr@@GLIBC_2.2.5' can not be used when making a
> shared object;
> recompile with -fPIC
> 
> Any idea ?

If so, please try
	make clean
	make CFLAGS=-fPIC

> Thanks
> Dieter Bieler

Sebastian
