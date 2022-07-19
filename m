Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768D3CCA47F
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Jul 2022 07:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbiGSHTV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Jul 2022 03:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbiGSHTT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Jul 2022 03:19:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6A241F2D8
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Jul 2022 00:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658215157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c9hDHTDlizIptgWB6Wc2g1JY5Cp3r9WdCLFbnkktkQc=;
        b=hfVdGRsxkC+7LeI+0tVjsQfq/f7HQKClKUmRa83D1ndMwQVYZ3bIwz+/DV+DaHcSEkvpS1
        7dwrWNuL0++yva/gdCzDNm/e6j3Oj6t6fzeDx1YNO0ljM3L1Ptilj5rcrHSO4iUuMWOFA/
        haI4QR3K2+VHfJQSrRDnm0+LlKiLkI4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-mCadqFO0OvCbRjNDv18GBw-1; Tue, 19 Jul 2022 03:19:10 -0400
X-MC-Unique: mCadqFO0OvCbRjNDv18GBw-1
Received: by mail-wm1-f72.google.com with SMTP id i184-20020a1c3bc1000000b003a026f48333so6454160wma.4
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Jul 2022 00:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c9hDHTDlizIptgWB6Wc2g1JY5Cp3r9WdCLFbnkktkQc=;
        b=3l5kURLZx8WqMBU8ojmHqiy3glmSdGBAjRVgIaRrhICY49DPRf7hfUstA/Cg8ySEX+
         KDXVByVTp8G3Gj1oMcDjlPDndSx86sxV3P9sWc2D3dHbfZhK1R/Amzb3Iu0e7MLLiGgx
         iGGyHyv4TDkBy5F1+j6I83XBkhw5psXQugJkdBKL4qEOOJK0CvUC9z9pNnDr07UEyYGB
         iAyC2YUqK42duNkVOb18El9ju9pRk4UiUfVdux6UBk9UQmFKnbve+K4JAekQ6kodNY4B
         WRtWFCvj1HeBKGWKJxZdChTkYPUH/XOsvT3taI/DaAHkQOb7zRbqIn2F3x2lOROQb2Dl
         0oIg==
X-Gm-Message-State: AJIora/W7AOYpO8StYz3zZ5Pj6i5jldWUZKX7RirzOwZmP2ktj/aCHUs
        MZuJcn0m/1AzQXmK+4rMg2NusQlW87xxq86J+4Rt2OHDbSOyYxYWMixmhc4gle86DQH+o8zOHIO
        +naSDvjtyJGbQ5fr+8dxESZAv9Kk=
X-Received: by 2002:a05:600c:1e8d:b0:3a1:9eb0:fd81 with SMTP id be13-20020a05600c1e8d00b003a19eb0fd81mr28211944wmb.19.1658215149269;
        Tue, 19 Jul 2022 00:19:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tAQs17h1Ymb8uk5JFCX89t+L/+vzCNvu6h2agEgN2ZYhi+24NX+nsWLtaM89NhetUbKjlAtg==
X-Received: by 2002:a05:600c:1e8d:b0:3a1:9eb0:fd81 with SMTP id be13-20020a05600c1e8d00b003a19eb0fd81mr28211917wmb.19.1658215149021;
        Tue, 19 Jul 2022 00:19:09 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.74])
        by smtp.gmail.com with ESMTPSA id j17-20020adfd211000000b002185631adf0sm12244730wrh.23.2022.07.19.00.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 00:19:08 -0700 (PDT)
Date:   Tue, 19 Jul 2022 09:19:05 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Ankit Jain <ankitja@vmware.com>
Cc:     "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sharan Turlapati <sturlapati@vmware.com>,
        Him Kalyan Bordoloi <bordoloih@vmware.com>,
        Keerthana Kalyanasundaram <keerthanak@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>
Subject: Re: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Message-ID: <YtZa6YYnMPVUP345@localhost.localdomain>
References: <20220713075014.411739-1-juri.lelli@redhat.com>
 <806a86d3-5204-145e-af46-023bf0142aa8@csail.mit.edu>
 <Ys/FiJ3tgc0CYDcu@localhost.localdomain>
 <D5F4086A-AD87-4CCB-B926-25713BBF00ED@vmware.com>
 <YtEbd2WjIOB6nXvr@localhost.localdomain>
 <DC16804A-D429-402E-B076-783B6373D21C@vmware.com>
 <YtVZokpe+l50EpWs@localhost.localdomain>
 <B466E709-EFCF-4B27-B3F6-D7561C381BF7@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B466E709-EFCF-4B27-B3F6-D7561C381BF7@vmware.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 19/07/22 05:30, Ankit Jain wrote:
> 
> 
> > On 18-Jul-2022, at 6:31 PM, Juri Lelli <juri.lelli@redhat.com> wrote:
> > 
> > ⚠ External Email
> > 
> > On 18/07/22 07:46, Ankit Jain wrote:
> > 
> > ...
> > 
> >> Hi Juri,
> >> 
> >> Actually, while testing I already included below commits in 4.19-rt :
> >> 
> >> feff2e65efd8d84cf831668e182b2ce73c604bbb (sched/deadline: Unthrottle PI boosted threads while
> >> enqueuing)
> >> 46fcc4b00c3cca8adb9b7c9afdd499f64e427135 (sched/deadline: Fix stale throttling on de-/boosted tasks)
> >> 2279f540ea7d05f22d2f0c4224319330228586bc (sched/deadline: Fix priority inheritance with multiple)
> >> 0e3872499de1a1230cef5221607d71aa09264bd5 (kernel/sched: Remove dl_boosted flag comment)
> > 
> > Interesting.
> > 
> > Is the workload you are using to test this easily reproducible? I'd like
> > to try that out on my end to check if I see the same (of course the
> > issue I was working on goes away with my fix :).
> > 
> > Best,
> > Juri
> > 
> 
> Hi Juri,
> 
> The test with which i am able to hit the issue is as follows:
> 	• Schedule SCHED_FIFO/55 (sched_priority = 55) tasks running infinite loop on all isolated cores.
> 	• spwan 30-40 docker containers in loop (docker load , docker run)
> 	• Immediately after that schedule SCHED_FIFO/55 (sched_priority = 55) tasks running infinite loop on all isolated cores again.
> 	• BUG_ON gets hit almost every time.
> System config as follows:
> 	• 4.19-rt kernel
> 	• 40 cpu (0-1 housekeeping, 2-39 isol cpus)
> 	• stalld-1.3.0 with the fixes from latest version (for task starvation avoidance), "tuned" with real-time profile 

Thanks for the details. Yeah, I should be able to set this up on my end.
It might just take a bit though, as I have some pto planned coming up.
But, I'll get to it eventually.

Thanks again,
Juri

