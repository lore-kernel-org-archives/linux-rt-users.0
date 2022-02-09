Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FDBC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Feb 2022 10:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiBIK07 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Feb 2022 05:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiBIK06 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Feb 2022 05:26:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F0C3E11B4D1
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Feb 2022 02:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644401880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOGT40PA5LmAnBRQIBrjCAxhYJpsutSMC+lcUcCHisA=;
        b=TR6kX7R3VdAqs+T1+QHb0ZzP9XdmmPHjAVWT39rDpdLmIhN0bPfGjbmFYPjQPcjFrqCFt6
        +sxxPac59KcdBEKLJFA+JsjmHZfRbkldjy5idFdow1quEvS7YBdYUlzZejRyTDSq4rM5Ui
        8VGLeIka263pabMFb1S+3qx95BAd1aE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-XpHzB-s3PzOattWy4PW7EQ-1; Wed, 09 Feb 2022 04:45:02 -0500
X-MC-Unique: XpHzB-s3PzOattWy4PW7EQ-1
Received: by mail-wr1-f69.google.com with SMTP id g6-20020adfbc86000000b001a2d62be244so858387wrh.23
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Feb 2022 01:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bOGT40PA5LmAnBRQIBrjCAxhYJpsutSMC+lcUcCHisA=;
        b=gBKANyon73Pd43blNMOLRF/Ci+cP3Ky6ZIObVKhU0VZsiMr/lj2o56pKYjJKztR3ik
         5Pq63B0sy0p1Vat3iWZP8tTN8Td3kLMjR2/tL2bcQOwlmRF1XEs3MYIbuGuSd8SjdbA3
         Wa3NN7qvLi0sNoTN/0jRlhhn5vtRDqbCXveowlZWSlfWU+xUqId9KVAY2wL8b5qF5dYj
         ocRd/QZ96Lg66KGTtvFKc4DxVKHqqHuKpXdi/EQh5GLaDhRgoBGSgg7JicM0eGJcsHTP
         KqC2gTHmdSqcLUMTNFLr9jTP1Bkz+bmMUZHcEIhgCMKuMtJ34jYC8nFFDmy8O1bCmHcI
         SBSQ==
X-Gm-Message-State: AOAM533HHS+WmbvvczyhcqLQV4F6G8Kcffl9OCP2zJqABgRRWmNF09Xt
        GQlkMlpJSaaP+dBeyFfK39U/8UtQBCZtWRMZJ3ANYhi+ce4KskI/tYolJwSYqm+bTjzaNT80LRB
        QU5AlCCcRSrJ5YFoorBriCsFkO24=
X-Received: by 2002:a1c:7418:: with SMTP id p24mr1246558wmc.21.1644399901426;
        Wed, 09 Feb 2022 01:45:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvFdeFjkesIm97KwdAHOETISeFDFk5mT6+L7zC0mhqZYGBbdP+JGwExuY5pOJJ7UuI+EuXSg==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr1246546wmc.21.1644399901192;
        Wed, 09 Feb 2022 01:45:01 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1204:1500:37e7:8150:d9df:36f? ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id h6sm4428856wmq.26.2022.02.09.01.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 01:45:00 -0800 (PST)
Message-ID: <b5363ced8e17d07d41554da8fde06c410e6688e0.camel@redhat.com>
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, mtosatti@redhat.com,
        mgorman@suse.de, linux-rt-users@vger.kernel.org, vbabka@suse.cz,
        cl@linux.com, paulmck@kernel.org, willy@infradead.org
Date:   Wed, 09 Feb 2022 10:45:00 +0100
In-Reply-To: <7c87f388-cc50-e9a1-17a7-802bb42656e4@huawei.com>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
         <7c87f388-cc50-e9a1-17a7-802bb42656e4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Xiongfeng, thanks for taking the time to look at this.

On Wed, 2022-02-09 at 16:55 +0800, Xiongfeng Wang wrote:
> Hi Nicolas，
> 
> When I applied the patchset on the following commit and tested on QEMU, I came
> accross the following CallTrace.
>   commit dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
> 
> I wrote a userspace application to consume the memory. When the memory is used
> out, the OOM killer is triggered and the following Calltrace is printed. I am
> not sure if it is related to this patchset. But when I reverted this patchset,
> the 'NULL pointer' Calltrace didn't show.

It's a silly mistake on my part, while cleaning up the code I messed up one of
the 'struct per_cpu_pages' accessors. This should fix it:

------------------------->8-------------------------
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0caa7155ca34..e65b991c3dc8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3279,7 +3279,7 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
                                has_pcps = true;
                } else {
                        for_each_populated_zone(z) {
-                               pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+                               pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
                                lp = rcu_dereference_protected(pcp->lp,
                                                mutex_is_locked(&pcpu_drain_mutex));
                                if (lp->count) {
------------------------->8-------------------------

Thanks!

-- 
Nicolás Sáenz

