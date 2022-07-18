Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B45C43334
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Jul 2022 13:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiGRNBr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbiGRNBk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Jul 2022 09:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BC2663C1
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Jul 2022 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658149298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eys+Z4CsioRJRql2AEhhAjwV+0wb8WqObF1vNqWzRYU=;
        b=VjNQWcT6vghx3vDsBcM5THUWtYYoEoa23U6Rq0Bs7O476UPCZ2JokAzLmYu7I6Fh0SHE6j
        0AYYDtPFuvAqa49Lv3NUZN+2k9gold+7nsVfxtxRbowBfOGe1g7U5RXnRCkKyzR6n3sMTa
        yVjUpTzHvnbNdzFZpiAlN0Ux8YqYUxk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-raNaw8m_OGyVZo_Lz4oiBg-1; Mon, 18 Jul 2022 09:01:28 -0400
X-MC-Unique: raNaw8m_OGyVZo_Lz4oiBg-1
Received: by mail-wm1-f72.google.com with SMTP id i132-20020a1c3b8a000000b003a2fe4c345cso5580934wma.0
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Jul 2022 06:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eys+Z4CsioRJRql2AEhhAjwV+0wb8WqObF1vNqWzRYU=;
        b=vObYKhj9bk93f8VqbCnGI3jKWKMrMnuNpGazj+wSa84V+yc9kohLA80i4hKFtafXdG
         II+f7dQIUo13mucmtT3VhZDD6sekLxIvPJfeg/cBe2xvvAxfjE5ONHxIdXF8F94d1SS9
         0bDHfhwXeqC3+a3GhivAW4ysvu8aztzEXV35BVpc21gim2TZbhtge5MSLrWsmq0veCmD
         lr1Z4h2Omj5N3Gt8kJ265Rlgk9xz0R4K+eTG3ndBmnyMGV5GiYmqeBs+aghbHdCuH/Ye
         0qcwF8r4HNV3IcF77+7HPJpyH+kQh2nnb7x0Vxanh42qBxJBrO3hVFVafyYPPsi+Lmb8
         GXxQ==
X-Gm-Message-State: AJIora8MMT30FFzILJqo8eUjnSGjvvxzVrQvoqBhaYSp8yvk7Caeg2av
        ia+867fqk24lzpjtNfd4ULNgrDUJzsdRMDrMjBMUbakKC3NtWrR9r3NZWsx7zoPm8PW/7A+dCvj
        twoI8ALIzRVBgAXd78cl1u6onR+U=
X-Received: by 2002:a05:600c:348d:b0:3a3:1fe6:6b38 with SMTP id a13-20020a05600c348d00b003a31fe66b38mr1467537wmq.144.1658149286604;
        Mon, 18 Jul 2022 06:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vXuNVNsIeKnZKdua0sBlCscP7wWrQFFJY6q2dJH6v/YJjUFsSjlnw3rB0/veB2xpWl9vf6nQ==
X-Received: by 2002:a05:600c:348d:b0:3a3:1fe6:6b38 with SMTP id a13-20020a05600c348d00b003a31fe66b38mr1467515wmq.144.1658149286348;
        Mon, 18 Jul 2022 06:01:26 -0700 (PDT)
Received: from localhost.localdomain ([151.29.59.195])
        by smtp.gmail.com with ESMTPSA id q10-20020adfab0a000000b0021d4155cd6fsm10667881wrc.53.2022.07.18.06.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:01:25 -0700 (PDT)
Date:   Mon, 18 Jul 2022 15:01:22 +0200
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
Message-ID: <YtVZokpe+l50EpWs@localhost.localdomain>
References: <20220713075014.411739-1-juri.lelli@redhat.com>
 <806a86d3-5204-145e-af46-023bf0142aa8@csail.mit.edu>
 <Ys/FiJ3tgc0CYDcu@localhost.localdomain>
 <D5F4086A-AD87-4CCB-B926-25713BBF00ED@vmware.com>
 <YtEbd2WjIOB6nXvr@localhost.localdomain>
 <DC16804A-D429-402E-B076-783B6373D21C@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC16804A-D429-402E-B076-783B6373D21C@vmware.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 18/07/22 07:46, Ankit Jain wrote:

...

> Hi Juri,
> 
> Actually, while testing I already included below commits in 4.19-rt :
> 
> feff2e65efd8d84cf831668e182b2ce73c604bbb (sched/deadline: Unthrottle PI boosted threads while
>  enqueuing)
> 46fcc4b00c3cca8adb9b7c9afdd499f64e427135 (sched/deadline: Fix stale throttling on de-/boosted tasks)
> 2279f540ea7d05f22d2f0c4224319330228586bc (sched/deadline: Fix priority inheritance with multiple)
> 0e3872499de1a1230cef5221607d71aa09264bd5 (kernel/sched: Remove dl_boosted flag comment)

Interesting.

Is the workload you are using to test this easily reproducible? I'd like
to try that out on my end to check if I see the same (of course the
issue I was working on goes away with my fix :).

Best,
Juri

