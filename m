Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B075C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 May 2022 15:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbiEWPjb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 May 2022 11:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbiEWPj0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 May 2022 11:39:26 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E2EDFA2
        for <linux-rt-users@vger.kernel.org>; Mon, 23 May 2022 08:39:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VED2nYH_1653320360;
Received: from B-V5AVMD6P-1927.local(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0VED2nYH_1653320360)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 May 2022 23:39:20 +0800
Subject: Re: [PATCH 1/2] hackbench: Fix negativity opt checking
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20220428103726.108597-1-wuyihao@linux.alibaba.com>
 <20220428103726.108597-2-wuyihao@linux.alibaba.com>
 <3986d547-06e-b7f9-353c-1ff05f1bcee@redhat.com>
From:   Yihao Wu <wuyihao@linux.alibaba.com>
Message-ID: <489b13a9-a4ff-87ce-ea2c-ed99a068cbaa@linux.alibaba.com>
Date:   Mon, 23 May 2022 23:39:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <3986d547-06e-b7f9-353c-1ff05f1bcee@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I'm sorry! John. In the commit log, I described the problem wrong. It 
should be more trivially reproduced like this,

./hackbench --datasize 4096 -g 1 -l 1

This command gives an error "--datasize|-s requires an integer > 0". But 
if you append any argument (or nonsense) after this command, like,

./hackbench --datasize 4096 -g 1 -l 1 whatever

This command runs without any error message.

My original intention of this patch was to remove "!(argv[optind]". I 
suppose this condition leads to this bug. (Pardon me for I don't know 
what's it for. I'd admit I'm not familiar with getopt)

This negative bugfix should only be a piggypack fix. But as you've 
pointed out, it merely hides misusage. So it's a bad bugfix.

Thanks,

Yihao

On 2022/5/10 02:59, John Kacur wrote:
> Well, the code doesn't work the way the author intended, that's for sure.
> As your patch indicates, you realize the problem is that an unsigned
> variable can never be less than zero, so the check is meaningless.
> However, is changing the data type the right solution, just to make a
> check against something stupid a user might input the correct thing to do?
> It decreases the size of valid input. Maybe that doesn't matter, but then
> could it introduce a new bug somewhere? You've dropped the argv[optind]
> too which also doesn't work the way the author intended, but it was
> probably meant as a check of whether the user provided an argument or not.
> 
> What I would rather see if you want to fix this, is a check against the
> user input that doesn't change the datatype. For example, if you treat the
> input as a char, if (optarg[0] == '-') then we can tell the difference
> between a really big number or user input that is stupid or malicious.
> If you look in cyclictest, (there could be bugs lurking there too), there
> is an attempt to parse this kind of thing and to check whether there are
> arguments too.
> 
> Thanks
> 
> John
