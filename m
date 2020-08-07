Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9823C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 11:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30402073E
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 11:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djPTtHlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgHGLaj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:30:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32336 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726466AbgHGLai (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 07:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596799837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCKj1Ub5pGUVjIAFPQ0S7mbJ7Aa0u7tibFTJP9aEVbI=;
        b=djPTtHlC1oS0xTyeLYuPglb6Khe0ducXyXDJ0uZahBvEOvx1luRx2QxJZEclA+YD8fq7/2
        y2+bElYbBFgrLwGXCSrOo+tQG/YdWHZ3SHql2A0VSgbxE9DknsY9v5hCWJspYPDBQt3SYS
        u98meIDK8Hkfe/9OLINdOn3ToNXrPBM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-AJ16OjxqMiGVlbiNw96nfQ-1; Fri, 07 Aug 2020 07:30:35 -0400
X-MC-Unique: AJ16OjxqMiGVlbiNw96nfQ-1
Received: by mail-ej1-f69.google.com with SMTP id r10so788451ejy.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Aug 2020 04:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pCKj1Ub5pGUVjIAFPQ0S7mbJ7Aa0u7tibFTJP9aEVbI=;
        b=G3rHCkfDoLlpXJO3e4Shzj5t4e+FGwIM6pWpUQ8YNF+QtYZGwWqU292SEflE1hp8IL
         twDc+kTGFivhHVZ6yl/nIY4AeDzCjN/QMdURDdJj9wI5ZHjv6hT8rCmGi3YeKakyXFLE
         XYvdZMItbNtr4xE41h5lkmGpQtmRSoovXwyVBr0FnPydrNMC5FprIiYZrWMoAfV7TAk6
         1FCdFzhp49egMWf5IQrAtCC5qIx2y3jtrj2UlsklujZfJ1Rj/wEqJS22jV+pLK1MpzNo
         iG6HqmHUaARHSUrm4fS5r+izv/GM/kP+gsjwtgdud0v6zDkmrs29VBhebCHQaZSYkz5t
         g3ug==
X-Gm-Message-State: AOAM531JqMvDosJWHF3MYdPM1ZfQLC9ysKEA2nb2KKnm2w0QyAbFwdMK
        jrBfubk2wFKsaH9k1XeapyfbBcStaS2sdvzVdDrjEmr1if9duE1XbPxomIz2IcMw7X+E1IC5F1B
        xVwdaiGc61+xKYr5DUIW+1sc3934=
X-Received: by 2002:a17:906:95d4:: with SMTP id n20mr9384652ejy.485.1596799834377;
        Fri, 07 Aug 2020 04:30:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3MwfwkXe4uLrNhb+rWQK0dJYBQ+SHlXRwTYpdoCxLlpdFKx8XXBJpgx7MCxjK6XTJ+j3B6Q==
X-Received: by 2002:a17:906:95d4:: with SMTP id n20mr9384621ejy.485.1596799834122;
        Fri, 07 Aug 2020 04:30:34 -0700 (PDT)
Received: from x1.bristot.me (host-87-16-204-193.retail.telecomitalia.it. [87.16.204.193])
        by smtp.gmail.com with ESMTPSA id dc23sm4924819edb.50.2020.08.07.04.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 04:30:33 -0700 (PDT)
Subject: Re: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
To:     peterz@infradead.org, Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        dietmar.eggemann@arm.com, linux-rt-users@vger.kernel.org,
        mtosatti@redhat.com, williams@redhat.com,
        valentin.schneider@arm.com
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200807095604.GO42956@localhost.localdomain>
 <20200807104618.GH2674@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <383e33a0-bace-a387-b47e-30fbec4f18db@redhat.com>
Date:   Fri, 7 Aug 2020 13:30:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807104618.GH2674@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/7/20 12:46 PM, peterz@infradead.org wrote:
> On Fri, Aug 07, 2020 at 11:56:04AM +0200, Juri Lelli wrote:
>> Starting deadline server for lower priority classes right away when
>> first task is enqueued might break guarantees, as tasks belonging to
>> intermediate priority classes could be uselessly preempted. E.g., a well
>> behaving (non hog) FIFO task can be preempted by NORMAL tasks even if
>> there are still CPU cycles available for NORMAL tasks to run, as they'll
>> be running inside the fair deadline server for some period of time.
>>
>> To prevent this issue, implement a starvation monitor mechanism that
>> starts the deadline server only if a (fair in this case) task hasn't
>> been scheduled for some interval of time after it has been enqueued.
>> Use pick/put functions to manage starvation monitor status.
> One thing I considerd was scheduling this as a least-laxity entity --
> such that it runs late, not early -- and start the server when
> rq->nr_running != rq->cfs.h_nr_running, IOW when there's !fair tasks
> around.
> 
> Not saying we should do it like that, but that's perhaps more
> deterministic than this.
> 

I agree, what we want here is something that schedules the server if it still
retains some runtime when the laxity is 0. But this is easier said than done, as
this would require another scheduler (other pros and cons and analysis (and
hours of work)...).

But, for the starvation monitor purpose, the goal is not (necessarily) to
provide a deterministic guarantee for the starving task, but to avoid system
issues while minimizing the damage to the "real" real-time workload. With that
in mind, we could relax our ambitions...

Thoughts?

-- Daniel

