Return-Path: <SRS0=Qk+l=Z4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D49C43603
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Dec 2019 06:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6D42466E
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Dec 2019 06:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jv-coder.de header.i=@jv-coder.de header.b="knini1mS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfLFGTB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Dec 2019 01:19:01 -0500
Received: from mail.jv-coder.de ([5.9.79.73]:46908 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfLFGTB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Dec 2019 01:19:01 -0500
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Dec 2019 01:19:00 EST
Received: from [10.61.40.7] (unknown [37.156.92.209])
        by mail.jv-coder.de (Postfix) with ESMTPSA id 335039F7F0;
        Fri,  6 Dec 2019 06:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1575612810; bh=mCGqUStDAETTN1hhVIkY9yJtytRNAwoNuENyR2bVjl0=;
        h=Subject:To:From:Message-ID:Date:MIME-Version;
        b=knini1mStgf1FpA7hTdBBZ2CkRDDCaXlTSk6KFtv67UZrSx4PMlwbx2N5q8vSi+q4
         LNyyowruJN3qA7uvZnI53QKx/jpnbBXQlHaFvRG423NL1nJ0ddJQnA2kSQt4MJ7NTx
         LAYpQhkTwHxxPrYvn3CbuN4Tnr2MGs6hK6DaIIJw=
Subject: Re: [LTP] LTP realtime tests
To:     Petr Vorel <pvorel@suse.cz>, linux-rt-users@vger.kernel.org,
        rt@linutronix.de
Cc:     ltp@lists.linux.it
References: <20191205135020.GA7951@dell5510>
From:   Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <6a7fbfdf-4fda-70bb-01d8-19fb6218170d@jv-coder.de>
Date:   Fri, 6 Dec 2019 07:13:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191205135020.GA7951@dell5510>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Petr,

we are running these tests and from what I've seen the quality is very poor.
We had to make changes to a lot of them to make them pass reliably:
most of the tests: Missing checks of return value for pthread function 
and resulting deadlock
prio-wake and prio-preempt: Bound to a single cpu core
sched_football: Needs a sleep to run reliable (I send a mail some time 
ago to this mailing list
regarding the validity of the test, which got forwarded to lkml by 
cyril, but no reply)

Some tests do not return the correct result e.g.:
testpi-5, testpi-6, sched_jitter, gtod_latency

I haven't really looked into most of these tests.

Jörg

Am 05.12.2019 um 14:50 schrieb Petr Vorel:
> Hi RT folks,
>
> looking into LTP realtime tests (testcases/realtime/ [1]),
> the code certainly deserves cleanup.
>
> Looking at [2], it does not mention these tests at all.
> Can anyone comment on relevance of these tests to current RT?
> Does anyone use these tests?
>
> Thanks for feedback.
>
> Kind regards,
> Petr
>
> [1] https://github.com/linux-test-project/ltp/tree/master/testcases/realtime
> [2] https://elinux.org/Realtime_Testing_Best_Practices#Test_programs
>

