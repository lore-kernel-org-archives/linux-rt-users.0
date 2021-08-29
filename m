Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93245C432BE
	for <linux-rt-users@archiver.kernel.org>; Sun, 29 Aug 2021 19:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F0860F44
	for <linux-rt-users@archiver.kernel.org>; Sun, 29 Aug 2021 19:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhH2T70 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 29 Aug 2021 15:59:26 -0400
Received: from mail.nearlyone.de ([46.163.114.145]:34324 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhH2T7W (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 29 Aug 2021 15:59:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D12B5E433;
        Sun, 29 Aug 2021 21:58:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1630267105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=AcyYaVWHu9k/I6R2baRmzMkIezk644/3Kw8QnyWYol4=;
        b=OdgrLwYXpTx293bFp8tAz3zXkkKP6AWpUQfPzCOqhRCMyOCo5Iq5BSB6WkP+dt86IO8CpW
        riMGAPzOL/hWO6ewrUH97ZZd8HOWEKtMXmW8pVHMa1WuX2Ju0nBYppnQZN5NNFqDV9OavS
        J6zONtTMXriKYeS9aqDP1jUDEX+quOFzE2UihebGLkl0qA+pRO2f9z79IzzPLx3hNFupRh
        7rZChaGPq1cF3GEiG+q8aX7qFdN2aA/yTphKJuN0YRzOHtcxCRwFvNXmDXOCRaewKvxMvg
        0E2E7cH5/vLSoEHTwuLch246osFxNxww8kJrB8pKHT5/ozGJj0ORVRfTv/MQWw==
Date:   Sun, 29 Aug 2021 21:58:24 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 1/1] rt-numa: Use sched_getaffinity() instead
 of pthread_getaffinity_np()
Message-ID: <20210829195824.y6sxfey2hazr2mko@beryllium.lan>
References: <20210719081505.520-1-dwagner@suse.de>
 <20210719081505.520-2-dwagner@suse.de>
 <c85f2cf8-4c30-3171-223-b6a95853637a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c85f2cf8-4c30-3171-223-b6a95853637a@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

On Fri, Aug 27, 2021 at 01:09:41PM -0400, John Kacur wrote:
> -Some minor fixes to the description

Thanks a lot. Do you plan to do a release soon? I'd like to update the
versions in LAVA's test-definition test suite. And it's way simpler to
base it on a released version.

Thanks,
Daniel
