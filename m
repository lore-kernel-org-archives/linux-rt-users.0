Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16FFC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Feb 2022 12:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiBIMDa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Feb 2022 07:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiBIMDM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5920BC033258
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Feb 2022 03:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644406567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XfermB6CMKU1zKQ537x6yTA+IzQs5j2AWlksK8pCcRU=;
        b=RTTwdLCVIBcSbOth+M/OZx1x1gfPdvw8oOU6lo31GHp+gjyFd2vdt8RwPD7Yc1HJWNZQC8
        HD5FfEH5rYcy/JJBsOvzdglnhvbBvUeIKZT6ECuNMOF0t+UmobjdNqwvfmITtyCvXRQSUe
        7QG+1SsK47G/UVxH7Bwksamf8nnAB0Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-30IvB01CNHSpfP89G8V1PA-1; Wed, 09 Feb 2022 06:36:06 -0500
X-MC-Unique: 30IvB01CNHSpfP89G8V1PA-1
Received: by mail-wm1-f69.google.com with SMTP id c7-20020a1c3507000000b0034a0dfc86aaso2522827wma.6
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Feb 2022 03:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XfermB6CMKU1zKQ537x6yTA+IzQs5j2AWlksK8pCcRU=;
        b=EZvTOe6Qsmw6uaUFVDYFllTxgkccG/p0DTBYa7f3RnSdXHZoyYNscTz9vTO58KUqaY
         LDuBMwJ1CjdcqAuRtK0SGMYkV8f5J2oYVTMIYslobl8QjHmBtg/qFm3U/gppBqpqTJk2
         BHee7vn27nlDvShe/EifqvUM72KePps3GPR+TVsqPlgYv2QVkkj1gsbISsZjSbx1p48W
         zegRrFpPapJPRQhaESGCYzKLYX4Tf6dD7zlktQjgApAN+yliTnNjNT1IfwVZN3w9Qsek
         IxMmjhPjRXsG0DUwzjPrRkHuj6cnF/Cwx1F5k5VGlkUjxcgSG6bCyxbSdkqBTPXAevGo
         0SiQ==
X-Gm-Message-State: AOAM531KCtN57HYweZaUlL/hhkt5HMMiehcEeVvazjMsq/VQXN/ju7ab
        sR1V8OPmsPnQkq/nURAEff57PkNPZ3r8K995aCbyF/O/FVSsg/jbbDffSWDc9nCdI/bF2kebkY0
        onVRT4SraCGRMrJz1FjwxRQw/pUA=
X-Received: by 2002:a05:600c:3b97:: with SMTP id n23mr640438wms.116.1644406564898;
        Wed, 09 Feb 2022 03:36:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0JWcCTHjUFiG4IzG96xqlvCJC9eJ8y4HTIUnEUHpgEQcFZRU1VGpZWbVwcZeHh2mrYMIrCw==
X-Received: by 2002:a05:600c:3b97:: with SMTP id n23mr640405wms.116.1644406564445;
        Wed, 09 Feb 2022 03:36:04 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1204:1500:37e7:8150:d9df:36f? ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id z17sm4531039wmf.11.2022.02.09.03.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 03:36:04 -0800 (PST)
Message-ID: <035d9c7a21eb024e336dce0942fa3f85b864aaea.camel@redhat.com>
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, mtosatti@redhat.com,
        mgorman@suse.de, linux-rt-users@vger.kernel.org, vbabka@suse.cz,
        cl@linux.com, paulmck@kernel.org, willy@infradead.org
Date:   Wed, 09 Feb 2022 12:36:02 +0100
In-Reply-To: <b2e7ea31-0a56-6415-474b-a952fb1d36ef@huawei.com>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
         <7c87f388-cc50-e9a1-17a7-802bb42656e4@huawei.com>
         <b5363ced8e17d07d41554da8fde06c410e6688e0.camel@redhat.com>
         <b2e7ea31-0a56-6415-474b-a952fb1d36ef@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2022-02-09 at 19:26 +0800, Xiongfeng Wang wrote:
> Hi,
> 
> On 2022/2/9 17:45, Nicolas Saenz Julienne wrote:
> > Hi Xiongfeng, thanks for taking the time to look at this.
> > 
> > On Wed, 2022-02-09 at 16:55 +0800, Xiongfeng Wang wrote:
> > > Hi Nicolas，
> > > 
> > > When I applied the patchset on the following commit and tested on QEMU, I came
> > > accross the following CallTrace.
> > >   commit dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
> > > 
> > > I wrote a userspace application to consume the memory. When the memory is used
> > > out, the OOM killer is triggered and the following Calltrace is printed. I am
> > > not sure if it is related to this patchset. But when I reverted this patchset,
> > > the 'NULL pointer' Calltrace didn't show.
> > 
> > It's a silly mistake on my part, while cleaning up the code I messed up one of
> > the 'struct per_cpu_pages' accessors. This should fix it:
> > 
> > ------------------------->8-------------------------
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 0caa7155ca34..e65b991c3dc8 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3279,7 +3279,7 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
> >                                 has_pcps = true;
> >                 } else {
> >                         for_each_populated_zone(z) {
> > -                               pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
> > +                               pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
> >                                 lp = rcu_dereference_protected(pcp->lp,
> >                                                 mutex_is_locked(&pcpu_drain_mutex));
> >                                 if (lp->count) {
> 
> I have tested it. It works well. No more 'NULL pointer' Calltrace.

Thanks!

-- 
Nicolás Sáenz

