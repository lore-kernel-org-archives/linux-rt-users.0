Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC94C43334
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Jul 2022 07:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbiGNH2R (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Jul 2022 03:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiGNH2Q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Jul 2022 03:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 168DB31DDE
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Jul 2022 00:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657783695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=550DnVq2EPGtnDKY2qpgJkb609RpXGjFmRJ5BQ0wADQ=;
        b=N2OcUcvvuNTgPXWkJkdMUWxC9rJvDPKPf3+FfTcPP6Fy0ANUvAR3T7EGwaEtjghgE+PU8x
        Opj7tQNlkp8vWO6/Hiy/xTUJ8wP1aNZpWKchVyjTnSwjtpHrWtMHopTifwly2QsbOZfqpc
        rmLtn6tn5JmhU1XygNM5L0Pu3b4vhwc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-jNpkzmkIPmaDyeisMS5eRQ-1; Thu, 14 Jul 2022 03:28:13 -0400
X-MC-Unique: jNpkzmkIPmaDyeisMS5eRQ-1
Received: by mail-wm1-f69.google.com with SMTP id c126-20020a1c3584000000b003a02fa133ceso274063wma.2
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Jul 2022 00:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=550DnVq2EPGtnDKY2qpgJkb609RpXGjFmRJ5BQ0wADQ=;
        b=lsLjUFmKGF58xEKRToD1/Tmke+/wBsyf1AMRl4CSPt2gmuTNgDomWYryGylyBIjPj6
         fR98hnE3UtPdc5xJTTTs9/tJ3nuvgMfdJinvAYoZ9OupyRnSh6GiZsbaTQnWosirUWEa
         G8qZm9O8pBo9GgPSlMwZ7b2NkZHUCPgxPCXSIOTv0b77KEkbaOzUZTJ9P+4HvGbUMr0N
         VNB9Px5IcgjjqF/TqwRSZ1Buq61BZStMgk+aRfqN4P7hOEpnmrZTO7uRfDC45+GLiArc
         vuHKRWhTKlGwsBWDBd+2zSo20hEbIwjwzvZLhQDCcRxo0kqR/P1gfAUkxYiyLiY/yx+G
         vV8Q==
X-Gm-Message-State: AJIora+nPrg9iwXzacgcsnYHIbG3pcKP9LBiunZiDFxJk700QrKzqqK0
        SucoE5y17dvADv84u6qvWvQH3By+NIxLiXXFwZVdYgHypGcBPHDjZ9UPJ6Qt4qfFEynhfqNzY1o
        vEd+h0VX4/YdzbUs2jZnXLaUKM8Y=
X-Received: by 2002:a05:6000:184f:b0:21d:a1fb:4581 with SMTP id c15-20020a056000184f00b0021da1fb4581mr7101590wri.651.1657783692023;
        Thu, 14 Jul 2022 00:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sjhAbKxOlxMx3NXmtd/EXEqUwfGIgEpReiSfsIDYPLQEnzkffk8gHoAGkQGXKHLczrIWYK8A==
X-Received: by 2002:a05:6000:184f:b0:21d:a1fb:4581 with SMTP id c15-20020a056000184f00b0021da1fb4581mr7101549wri.651.1657783691723;
        Thu, 14 Jul 2022 00:28:11 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.26])
        by smtp.gmail.com with ESMTPSA id r3-20020adfe683000000b0021004d7d75asm705037wrm.84.2022.07.14.00.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 00:28:11 -0700 (PDT)
Date:   Thu, 14 Jul 2022 09:28:08 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sharan Turlapati <sturlapati@vmware.com>, bordoloih@vmware.com,
        ankitja@vmware.com, Keerthana K <keerthanak@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>
Subject: Re: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Message-ID: <Ys/FiJ3tgc0CYDcu@localhost.localdomain>
References: <20220713075014.411739-1-juri.lelli@redhat.com>
 <806a86d3-5204-145e-af46-023bf0142aa8@csail.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <806a86d3-5204-145e-af46-023bf0142aa8@csail.mit.edu>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 13/07/22 14:31, Srivatsa S. Bhat wrote:
> 
> Hi Juri,
> 
> On 7/13/22 12:50 AM, Juri Lelli wrote:
> > Tasks the are being deboosted from SCHED_DEADLINE might enter
> > enqueue_task_dl() one last time and hit an erroneous BUG_ON condition:
> > since they are not boosted anymore, the if (is_dl_boosted()) branch is
> > not taken, but the else if (!dl_prio) is and inside this one we
> > BUG_ON(!is_dl_boosted), which is of course false (BUG_ON triggered)
> > otherwise we had entered the if branch above. Long story short, the
> > current condition doesn't make sense and always leads to triggering of a
> > BUG.
> > 
> > Fix this by only checking enqueue flags, properly: ENQUEUE_REPLENISH has
> > to be present, but additional flags are not a problem.
> > 
> > Fixes: 2279f540ea7d ("sched/deadline: Fix priority inheritance with multiple scheduling classes")
> 
> It looks like this problem goes further back than the above commit
> (which was merged in v5.10).
> 
> Even the oldest LTS kernel (4.9) has code like this:
> 
> if (... && p->dl.dl_boosted && ...)) {
> 	/* code */
> 
> } else if (!dl_prio(p->normal_prio)) {
> 
> 	BUG_ON(!p->dl.dl_boosted || flags != ENQUEUE_REPLENISH);
> 	return;
> } 
> 
> And we have observed crashes in the 4.19 kernel series too (CC'ed
> Ankit Jain and Him Kalyan who have reproduced this issue).
> 
> I believe commit 64be6f1f5f71 ("sched/deadline: Don't replenish from a
> !SCHED_DEADLINE entity") introduced the problem, which dates back to
> v3.18.
> 
> Would you mind updating the Fixes: tag and adding a CC: stable tag as
> well, when you respin the patch, please?

I think you are right. Will do.

Thanks for taking a look!

Best,
Juri

