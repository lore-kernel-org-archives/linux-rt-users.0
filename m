Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908FEC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3700864E57
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhBSQu3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:50:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:39068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBSQu3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:50:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DECBCABAE;
        Fri, 19 Feb 2021 16:49:47 +0000 (UTC)
Subject: Re: [PATCH] oslat: Fix --cpu-list won't allow to schedule on all
 possible cores
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
References: <20210218192729.116427-1-peterx@redhat.com>
 <20210219081611.xsugonlz7dl4zhvx@beryllium.lan> <20210219152417.GE6669@xz-x1>
 <20210219162019.giw2yy25vjuzc56f@beryllium.lan> <20210219163930.GG6669@xz-x1>
From:   Daniel Wagner <dwagner@suse.de>
Message-ID: <16b412ed-eaad-e305-faee-709eb75f79cf@suse.de>
Date:   Fri, 19 Feb 2021 17:49:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210219163930.GG6669@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Peter,

On 19.02.21 17:39, Peter Xu wrote:
> Now I tried to fix it but it seems you don't really like my fix.

Sorry I didn't want to say I don't like your fix. I just said, I would 
appreciate if things would stay consistent. But then it seems there is
not much interest in this.

> Would you propose yours instead?  I would be more than glad if your version is
> better then I'm happy to drop mine.  Otherwise I'll still prefer to have this
> patch merged to unbreak it first.

I don't care too much. If this patch fixes your problem don't let me
stop you.

Thanks,
Daniel
