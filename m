Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CE3C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jun 2022 01:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiF3BVd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 21:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiF3BVc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jun 2022 21:21:32 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9247C33E2B
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 18:21:30 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:33134.552274135
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 7B3C31002D7;
        Thu, 30 Jun 2022 09:21:28 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-749df8664c-npclk with ESMTP id dc482b05c111473c8aab7f578ab762eb for wagi@monom.org;
        Thu, 30 Jun 2022 09:21:29 CST
X-Transaction-ID: dc482b05c111473c8aab7f578ab762eb
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <50490782-6d83-3fac-75aa-0988889a6558@189.cn>
Date:   Thu, 30 Jun 2022 09:21:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] sched_deadline/cyclicdeadline add tracelimit
Content-Language: en-US
To:     Daniel Wagner <wagi@monom.org>, John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com
References: <1655448052-12537-1-git-send-email-chensong_2000@189.cn>
 <20220629065848.zpppngaem7qqazzf@beryllium.lan>
 <8d2bbda3-492-a5c9-4efc-722bddbc7bf6@redhat.com>
 <20220629170304.abppmxmie7yq3kmh@beryllium.lan>
From:   Song Chen <chensong_2000@189.cn>
In-Reply-To: <20220629170304.abppmxmie7yq3kmh@beryllium.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

在 2022/6/30 01:03, Daniel Wagner 写道:
> On Wed, Jun 29, 2022 at 11:34:40AM -0400, John Kacur wrote:
>> @Danel Wagner, is that just a comment or would you like a Reviewed-by ?
> 
> I just noticed that several option have been added to various tools an
> no one cared to add them to the manual patches. Makes a bit sad after
> spending time syncing all man pages up.

I totally agree with you in this point, in a lot of cases, document 
updates are behind the code implementation. people got confused if they
are not synced.

Thanks for pointing it out.

BR

Song

>   
