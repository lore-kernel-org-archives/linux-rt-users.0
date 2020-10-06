Return-Path: <SRS0=1NWT=DN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E57FC46466
	for <linux-rt-users@archiver.kernel.org>; Tue,  6 Oct 2020 16:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C2720760
	for <linux-rt-users@archiver.kernel.org>; Tue,  6 Oct 2020 16:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJFQgm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 6 Oct 2020 12:36:42 -0400
Received: from mail.monom.org ([188.138.9.77]:50910 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgJFQgm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Oct 2020 12:36:42 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 1902E5004AF;
        Tue,  6 Oct 2020 18:36:40 +0200 (CEST)
Received: from [192.168.154.220] (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id D62E1500103;
        Tue,  6 Oct 2020 18:36:39 +0200 (CEST)
Subject: Re: [ANNOUNCE] v5.9-rc8-rt12
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20201006085811.mtizrfff6k5r3me7@linutronix.de>
 <6c5bce4f-1c7f-a9e4-6707-2cda54141d8e@monom.org>
 <20201006161323.wsjkbnlj5smbffpz@linutronix.de>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <c9037696-555d-bff4-b132-dce2bdfcf0ac@monom.org>
Date:   Tue, 6 Oct 2020 18:36:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201006161323.wsjkbnlj5smbffpz@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On 06.10.20 18:13, Sebastian Andrzej Siewior wrote:
>> Just as heads up. I just tried to build for arm64 but PREEMPT_RT
>> is not available anymore. Looks like ARCH_SUPPORTS_RT is only
>> available for !KVM.
> 
> It has been announced in v5.9-rc2-rt1
>     https://lore.kernel.org/linux-rt-users/20200824154605.v66t2rsxobt3r5jg@linutronix.de/
> 
> and you replied to that mail. That mail contains information why and
> what needs to be done to remove that restriction.

D'oh, you have clearly a better memory than me. I forgot about it 
completely. Sorry for the noise.

Thanks,
Daniel
