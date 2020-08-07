Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8721C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 13:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A892A2224D
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 13:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4iat7ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgHGNax (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:30:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32459 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726066AbgHGNat (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 09:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596807047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JlW88KfYji9Ra9jnSteVpNm3mvfdBDzitQCHAgDFcO8=;
        b=R4iat7riAHVIjqYrB8eri2vPyuoClAzlMcV6FEhTBuR7hcforFolfEL1xV3s++fzFOoXrc
        Rn30h7orAJNpV3YU8T30uAUUzshVcsytwYTmOJQvsuGUzsYCbwL3StnMF1ymCML7de5f0j
        UmIGIJDFWip+LsQ3QazCOzpe5Vv7GQ8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-yEBqDRWDPLGjbqFjcgEXaw-1; Fri, 07 Aug 2020 09:30:45 -0400
X-MC-Unique: yEBqDRWDPLGjbqFjcgEXaw-1
Received: by mail-wr1-f71.google.com with SMTP id 5so750661wrc.17
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Aug 2020 06:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JlW88KfYji9Ra9jnSteVpNm3mvfdBDzitQCHAgDFcO8=;
        b=GjoBxJIvvh4TZ3UxQS4YUeyLJrC9Tl22haNWMTJM0K+H04bQ3Qmp5ev+q69WKQUuML
         2GOr7/bSudasOJn7LAI7383dhFti9IXc1njxFn2az510fP/Cj6L0clw9HCkCFuVQ/16R
         OcIL+kM92kVyja1vgyP94PGscLdwY60oPcaNOMHANBrJ9ePhyXScsShUBRjyHW6W20yR
         hQsSkiVyVCOI0pQ0p1VMOnCETzrBMsomNfKDJNcakvExmG9k6yWL+a4mQNlyFTs6UAsB
         9ibQaysi2yBSk14c5NOtptaBE9kYzfxq35fOOkWvcKAthmMy+W7ouHXVwqXdkMxKE+xV
         cNrQ==
X-Gm-Message-State: AOAM533v9JXqHtQAVRBSUwDWK+Acb1AXM4Ufx+IkzQ2LFYfNHcB86Tkj
        ST0/8IRhjN9PJb5FwG49i8sD7mYvwURQKrUdIZV3mVqk3HOTtLklYuMD9OBd0VP27ceGWcKaXD8
        1jr1gi1inx1Nw6M3amyYSxhAkwyc=
X-Received: by 2002:a1c:8094:: with SMTP id b142mr13602034wmd.59.1596807044404;
        Fri, 07 Aug 2020 06:30:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJXju9dEYjqzXP/t/6RanLHxFfCcjjybxAFY39+WPY8C/mz/r5dn5/Y/9Bqa7vbGb48GF5og==
X-Received: by 2002:a1c:8094:: with SMTP id b142mr13602020wmd.59.1596807044137;
        Fri, 07 Aug 2020 06:30:44 -0700 (PDT)
Received: from localhost.localdomain ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id k1sm10561732wrw.91.2020.08.07.06.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 06:30:43 -0700 (PDT)
Date:   Fri, 7 Aug 2020 15:30:41 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 0/6] SCHED_DEADLINE server infrastructure
Message-ID: <20200807133041.GQ42956@localhost.localdomain>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200807151632.36dc6200@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807151632.36dc6200@nowhere>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Luca,

On 07/08/20 15:16, luca abeni wrote:
> Hi Juri,
> 
> thanks for sharing the v2 patchset!
> 
> In the next days I'll have a look at it, and try some tests...

Thanks!

> In the meanwhile, I have some questions/comments after a first quick
> look.
> 
> If I understand well, the patchset does not apply deadline servers to
> FIFO and RR tasks, right? How does this patchset interact with RT
> throttling?

Well, it's something like the dual of it, in that RT Throttling directly
throttles RT tasks to make spare CPU cycles available to fair tasks
while this patchset introduces deadline servers to schedule fair tasks,
thus still reserving CPU time for those (when needed).

> If I understand well, patch 6/6 does something like "use deadline
> servers for SCHED_OTHER only if FIFO/RR tasks risk to starve
> SCHED_OTHER tasks"... Right?

That's the basic idea, yes.

> I understand this is because you do not
> want to delay RT tasks if they are not starving other tasks. But then,
> maybe what you want is not deadline-based scheduling. Maybe a
> reservation-based scheduler based on fixed priorities is what you want?
> (with SCHED_DEADLINE, you could provide exact performance guarantees to
> SCHED_OTHER tasks, but I suspect patch 6/6 breaks these guarantees?)

I agree that we are not interested in exact guarantees in this case, but
why not using something that it's already there and would give us the
functionality we need (fix starvation for fair)? It would also work well
in presence of "real" deadline tasks I think, in that you could account
for these fair servers while performing admission control.

Best,

Juri

