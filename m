Return-Path: <SRS0=kQBB=2D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA06C341DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9539246AE
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfLMMmC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Dec 2019 07:42:02 -0500
Received: from mail.monom.org ([188.138.9.77]:35880 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfLMMmC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Dec 2019 07:42:02 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 3F3B0500796;
        Fri, 13 Dec 2019 13:42:00 +0100 (CET)
Received: from [192.168.154.174] (b9168f78.cgn.dg-w.de [185.22.143.120])
        by mail.monom.org (Postfix) with ESMTPSA id 040E4500243;
        Fri, 13 Dec 2019 13:41:59 +0100 (CET)
Subject: Re: [PATCH rt-tests] queuelat: use ARM implementation of gettick also
 for all !x86 archs
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <ukleinek@debian.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
References: <20191208210625.5999-1-ukleinek@debian.org>
 <20191212174604.xa6p46zhhii7qrhw@linutronix.de>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <715fece0-66ff-beef-7ce8-bf8cea47301c@monom.org>
Date:   Fri, 13 Dec 2019 13:41:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212174604.xa6p46zhhii7qrhw@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 2019-12-12 18:46, Sebastian Andrzej Siewior wrote:
> So what I select as frequency for the !x86 case? And why.

IMO, an user should be able to run rt-tests without the need to provide 
special configuration or tuning. queuelat is a bit hard to use at this 
point.

> That freq. script reports here:
> |1555.184 1566.269 1566.498 1560.055 1593.149 1568.185 1583.807 1599.096 2574.546 2572.408 2573.849 2583.862 2619.402 1825.680 1847.264 1870.318 2552.102 1570.552 1589.650 1595.813 1590.253 1573.834 1589.438 1599.439 1770.963 1786.370 1814.918 1811.936 1828.277 1850.905 1861.976 1792.809
> 
> I guess I pick one…
> 
> Could someone please figure out the actual difference of clock_gettime()
> vs rdtsc() so we know how important it is.

I didn't really understood what the test is doing. The initial 
clock_gettime() patch was just to shoutup the compiler.

Thanks,
Daniel
