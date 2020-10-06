Return-Path: <SRS0=1NWT=DN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AE8C41604
	for <linux-rt-users@archiver.kernel.org>; Tue,  6 Oct 2020 14:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970F9208B8
	for <linux-rt-users@archiver.kernel.org>; Tue,  6 Oct 2020 14:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgJFOoD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 6 Oct 2020 10:44:03 -0400
Received: from mail.monom.org ([188.138.9.77]:50458 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgJFOoD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Oct 2020 10:44:03 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 10:44:02 EDT
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 8B68B5004AF;
        Tue,  6 Oct 2020 16:37:22 +0200 (CEST)
Received: from [192.168.154.220] (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 47C4F500103;
        Tue,  6 Oct 2020 16:37:22 +0200 (CEST)
Subject: Re: [ANNOUNCE] v5.9-rc8-rt12
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20201006085811.mtizrfff6k5r3me7@linutronix.de>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <6c5bce4f-1c7f-a9e4-6707-2cda54141d8e@monom.org>
Date:   Tue, 6 Oct 2020 16:37:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201006085811.mtizrfff6k5r3me7@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On 06.10.20 10:58, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v5.9-rc8-rt12 patch set.

Just as heads up. I just tried to build for arm64 but PREEMPT_RT
is not available anymore. Looks like ARCH_SUPPORTS_RT is only
available for !KVM.

Thanks,
Daniel
