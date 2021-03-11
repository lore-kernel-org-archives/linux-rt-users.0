Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6811AC433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 12:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13FCD64FF9
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 12:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhCKM1y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Mar 2021 07:27:54 -0500
Received: from mail.monom.org ([188.138.9.77]:42508 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230430AbhCKM1o (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Mar 2021 07:27:44 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 06C825005CF;
        Thu, 11 Mar 2021 13:27:42 +0100 (CET)
Received: from [192.168.154.221] (unknown [94.31.96.195])
        by mail.monom.org (Postfix) with ESMTPSA id B5ED1500300;
        Thu, 11 Mar 2021 13:27:41 +0100 (CET)
Subject: Re: PREEMPT_RT benchmark
To:     Michel Macena Oliveira <michel@austral-dynamics.com>,
        linux-rt-users@vger.kernel.org
References: <CAKkbJ-ypaPZ5JKpXD+PykvO6oYzxEUdxXY2RbVJKWdGY3ALuLg@mail.gmail.com>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <9be68ca5-9fec-161c-1b37-1b47c0a1d845@monom.org>
Date:   Thu, 11 Mar 2021 13:27:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAKkbJ-ypaPZ5JKpXD+PykvO6oYzxEUdxXY2RbVJKWdGY3ALuLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Michel,

On 10.03.21 21:07, Michel Macena Oliveira wrote:
> At least that's what I expected, but my latencies are much bigger than
> Cyclictest ones.
>  From cyclictest I get an average in my computer of  something between
> 2300 and 2500 nanoseconds.  However, in my application I'm having
> something between 47000 and 55000 nanoseconds. As you can see it is
> much higher!
> 
> I'm not sure of what I'm doing wrong, could you help or suggest something?

Check if your system uses power managment. cyclictest disables the power 
management by using the /dev/cpu_dma_latency API.

HTH,
Daniel
