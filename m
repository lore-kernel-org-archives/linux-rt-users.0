Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B45C27C40
	for <linux-rt-users@archiver.kernel.org>; Wed, 23 Aug 2023 17:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbjHWR54 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 13:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbjHWR5z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 Aug 2023 13:57:55 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7015710CF
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Aug 2023 10:57:43 -0700 (PDT)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DB467401DF;
        Wed, 23 Aug 2023 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692813459;
        bh=QLvNZiVTBu0ovZeKQp117dZcAnizsvKicJZ5TkunzPo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=TWvDAddsCmLRAR95ToM9vmMVFe9Azs62JJ6Fq+4LwI0CCa370msVATYyxmg6O1Rcw
         d/c6pT63Qw0qVTbB4n12/aeGhTsVE9uGSr9EcwaB0INtrxSuvJNJE2dwREuVgbiMkf
         nb5eBGRZM+4kn8CjktCFa3VjzGwai1g8egCukDdOUBwTt1l7Bygcf6CRE2lDWWNtEj
         tswzdh/zEuaSntkyNFj9PIcxjzwvX2Ta3cGkanr/fGuL6yqlaCqOK15uGXJYkC57pl
         jrqzBBk0rsQ5tzip0VcowhYPcZ+hB97S+ox6qOP+CqLi3qBKK6FnmQMCd13HC8nPvh
         NaQljfJmoq/QA==
Message-ID: <a947a3c5-b92f-9d7d-8ab6-7b0112957ed9@canonical.com>
Date:   Wed, 23 Aug 2023 13:57:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1-rt/5.15-rt 0/1] Backport i915 reset fix from v6.4-rt
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        paul.gortmaker@windriver.com
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
References: <20230819024525.2056048-1-paul.gortmaker@windriver.com>
 <20230823133915.gu_SxqTS@linutronix.de>
Content-Language: en-US
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
In-Reply-To: <20230823133915.gu_SxqTS@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 8/23/23 09:39, Sebastian Andrzej Siewior wrote:
> On 2023-08-18 22:45:24 [-0400], paul.gortmaker@windriver.com wrote:
>> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> Hi Paul,
>
>> However, the original regression was reported on v5.15-rt.  This closes
>> the loop by backporting the v6.4-rt change to v5.15-rt/v6.1-rt -- as it
>> turns out, the same backport applies cleanly to both baselines.
> Thanks for the ping. I've sent a backport request
> 	https://lore.kernel.org/all/20230727105040.4V9DQ5pM@linutronix.de/
>
> which includes the patch. It didn't go very so far but I am full of hope
> ;)
>
> Sebastian
Hi Paul,

I will put this on my list to backport to v5.15-rt stable.  I usually 
wait until requested backports land in the next newer version, which is 
v6.1-rt, before I apply to v5.15-rt.

Thanks,

Joe

