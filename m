Return-Path: <SRS0=yjnb=2L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E091C2D0C0
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Dec 2019 10:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8B821D7D
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Dec 2019 10:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfLUKtW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 21 Dec 2019 05:49:22 -0500
Received: from mail.monom.org ([188.138.9.77]:40584 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfLUKtW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 21 Dec 2019 05:49:22 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 66EE75005A3;
        Sat, 21 Dec 2019 11:49:16 +0100 (CET)
Received: from [192.168.154.174] (b9168f78.cgn.dg-w.de [185.22.143.120])
        by mail.monom.org (Postfix) with ESMTPSA id C057B500518;
        Sat, 21 Dec 2019 11:49:15 +0100 (CET)
Subject: Re: [ANNOUNCE] 4.4.206-rt190
To:     Pavel Machek <pavel@denx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
References: <20191206104701.CC686500518@mail.monom.org>
 <20191216132724.GA22097@amd>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <e2256c5e-826b-3046-de15-7c2599b1444c@monom.org>
Date:   Sat, 21 Dec 2019 11:49:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191216132724.GA22097@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Pavel,

Sorry for the delay.

On 16.12.19 14:27, Pavel Machek wrote:
> Hi!
> 
>> I'm pleased to announce the 4.4.206-rt190 stable release.
>>
>> This release is just an update to the new stable 4.4.206 version
>> and no RT specific changes have been made.
> 
> Thanks!
> 
> I'm getting failures with one of our configs:
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/380509098
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/103388506
> 
> This failure is not new, we have been working around it for a
> while. It can be fixed using:
> 
> git cherry-pick 8409299
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/103395886
> 
> (If you prefer, I can submit patch via email).

We should route this patch via stable. I'll send out the request to 
Greg. Just a sec.

Thanks,
Daniel
