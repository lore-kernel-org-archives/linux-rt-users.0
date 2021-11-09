Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2183DC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 07:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B78B610F8
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 07:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243893AbhKIICM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 03:02:12 -0500
Received: from mail.nearlyone.de ([46.163.114.145]:46262 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243884AbhKIICI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Nov 2021 03:02:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96E6361898;
        Tue,  9 Nov 2021 08:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1636444761; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=Xiy159kv85syhhDl0o2bBtoo1mQPRHeMh4lGzKFCZ/8=;
        b=spxr9pQ6W1LsKZlmcFYRdgaMnWiIMhJOh2bgp8eBZnrt8y31yppnmbSM5DNN/OiX6S651a
        QAWhHBibTbpEA8QoiYqnt02WSowH6yU3mhG+V2tkjbajOeTTC0X81d0fQZji+6cC77yVTE
        LPZXpRGbWd8d869zMC6u94Bcy8DdXMXeYT8AQcHnO6ps1/Z17KdIvS8SO7lzKUP+pXkcAW
        AOW717l6Kq4nqrvUUY5YKvja13aDCzQYxCkMwzzsOSyowsxxMWaZEqLIebW2ctCtmJ9iAm
        cHB4odngvQq6eA20/vlkmlaPP9xx5jH+TjQxJ/+xTHKz9cJvb+Sm4i/9BrR9uQ==
Date:   Tue, 9 Nov 2021 08:59:20 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Gylstorff Quirin <quirin.gylstorff@siemens.com>
Cc:     linux-rt-users@vger.kernel.org,
        "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>,
        bigeasy@linutronix.de,
        SCHILD HENNING Z003BPMR <henning.schild@siemens.com>
Subject: Re: Questions to CI Testing the RT-Kernel
Message-ID: <20211109075920.dx3xkcvpweeiodgd@carbon.lan>
References: <290ce1c2-9298-7b98-1717-771c2602687e@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <290ce1c2-9298-7b98-1717-771c2602687e@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Quirin,

On Mon, Nov 08, 2021 at 11:28:15AM +0100, Gylstorff Quirin wrote:
> From what I found the RT-Project also uses the combination of cyclictest
> with hackbench for testing or are there currently any other tests
> specifically for real-time executed?

I run most of the rt-tests with some background load. Usually it's a
hackbench. Since recently, I let run stress-ng (disabling a bunch of
stressors which trigger OOM situation for example).

For your CI setup, I would recommend trying to get real workloads from
your projects. hackbench is a very artificial workload for and only
exercises a small part of the kernel.

> Are there recommended tests that should be added to the CI testing of a
> RT-Kernel?

As mentioned, rt-tests is a good start. IIRC, ltp has also some RT tests
but I don't know their exact status. We (SUSE) did recently review
the ltp tests and most of them are covered by rt-tests, IIRC.

BTW, a bunch of links you might be interested if you are planing
to use LAVA:

https://github.com/kernelci/kernelci-core/issues/474
https://github.com/Linaro/test-definitions/pull/85
https://github.com/Linaro/test-definitions/pull/201

HTH,
Daniel
