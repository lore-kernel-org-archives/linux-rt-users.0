Return-Path: <SRS0=AdNn=BF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0511C433E3
	for <linux-rt-users@archiver.kernel.org>; Sun, 26 Jul 2020 11:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A21020715
	for <linux-rt-users@archiver.kernel.org>; Sun, 26 Jul 2020 11:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGZLzQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 26 Jul 2020 07:55:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:47388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGZLzP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 26 Jul 2020 07:55:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 383DAAFD2;
        Sun, 26 Jul 2020 11:55:23 +0000 (UTC)
Subject: Re: [ANNOUNCE] v4.4.231-rt202
From:   Daniel Wagner <dwagner@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
References: <159559806551.29587.13643956941367278015@beryllium>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Pavel Machek <pavel@denx.de>,
        Joe Korty <joe.korty@concurrent-rt.com>
Message-ID: <3732c1c4-36d4-2cdc-677a-cb58a9507df1@suse.de>
Date:   Sun, 26 Jul 2020 13:55:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159559806551.29587.13643956941367278015@beryllium>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 24.07.20 15:41, Daniel Wagner wrote:
> Known issues:
> 
>     sigwaittest with hackbench as workload is able to trigger a crash on x86_64,
>     the same as reported for the v4.4.220-rt196 release. As it turns
>     out it was not triggered by BPF.
>     https://paste.opensuse.org/view/raw/58939248

Joe pointed out [1] that v4.4-rt is missing 9567db2ebe56 ("signal: 
Prevent double-free of user struct") from devel-rt. With this
patch all my tests pass.

@stable-rt team: Can you please add it to the missing trees?

Thanks,
Daniel

[1] 
https://lore.kernel.org/linux-rt-users/20200626130544.GA37967@zipoli.concurrent-rt.com/

