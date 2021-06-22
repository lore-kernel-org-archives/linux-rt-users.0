Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D60DC2B9F4
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Jun 2021 17:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294276109E
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Jun 2021 17:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhFVRpU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232332AbhFVRpS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 22 Jun 2021 13:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624383781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Li6M8eB7WFoY4AUKWeE2vP5iJVKbyiAFbNV5HezuJLI=;
        b=cdCM9zmjyEgRgHbbd7PuCO0S5nzI07EifNr+g0fL1wo+pFtmuwEQmZf+IdqloAXwEDCETy
        oPx4FWbJfYQMUgIz2mO3n+Ygg8KLIXCGEJyUSqbee+/Kt1sLjoFckIGdal8tsEJ0RDMGGK
        4ACwWTuNSJ3KmppVC4STc1n92uLRipY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-kC_3lpGZMSSb0k_zPkAlxw-1; Tue, 22 Jun 2021 13:43:00 -0400
X-MC-Unique: kC_3lpGZMSSb0k_zPkAlxw-1
Received: by mail-wm1-f71.google.com with SMTP id l2-20020a05600c2cc2b02901e28c565271so314984wmc.6
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Jun 2021 10:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Li6M8eB7WFoY4AUKWeE2vP5iJVKbyiAFbNV5HezuJLI=;
        b=RH8bDUFDni3qcO6IuvVDsDGkpGbanu6e0VT+KHWYsk6UivULguWDGOOEiqHdRPBVPG
         WK5cCGXUQyXuXLrvpCNd/V33ikDsZvLfWFIWp24O54vpfPWB2fYcHAaXYhHd1PkwAUAS
         pz2Il0P8CrCtYdmYyIa+MiP3vWGTVQmmeRGkd8r0UEBcqaKZU5QZYhpIY37Cs1SFdBdw
         2eHvfKeihQBiqXdvcMBisyL6qHE7EHCHRyCjghs+u2zWxf/qVgN9xAF1/Trk1pOjlI7N
         ipY84+JQ4A9mhq4PINfeAReBf3cCkvfnsfkrNgifZdlz4v3MZZ1YfPJFfsSS21v9yIrz
         g8JA==
X-Gm-Message-State: AOAM532wW4XXX2Gd9MXTlRcxefeFqvK2lRcfhblsaeK+Fgk2xzvecXp3
        dLxWeUNkUuC8LZlOIPHE4IFJzfiu2sCkHpzoX4kgfx6naMm52kaIecDT9CzjMZyxAjHml+YxSlN
        pxn67GhtaiY2QMBT0Y0aLLbjebEA=
X-Received: by 2002:a1c:ed14:: with SMTP id l20mr5850605wmh.20.1624383778931;
        Tue, 22 Jun 2021 10:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbRc0bStZfinicCTWvb1Utq2odV+ee26gaS8OLQrldd250i3h7Tfqzr6WyZCM+YumzDFhIsA==
X-Received: by 2002:a1c:ed14:: with SMTP id l20mr5850596wmh.20.1624383778839;
        Tue, 22 Jun 2021 10:42:58 -0700 (PDT)
Received: from krava ([5.171.242.79])
        by smtp.gmail.com with ESMTPSA id e15sm32960wrm.60.2021.06.22.10.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 10:42:58 -0700 (PDT)
Date:   Tue, 22 Jun 2021 19:42:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rt-users@vger.kernel.org, frederic@kernel.org,
        mtosatti@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC 2/2] timers: Make sure irq_work is handled when no pending
 timers
Message-ID: <YNIhHmAekp2sUBCN@krava>
References: <20210610125945.558872-1-nsaenzju@redhat.com>
 <20210610125945.558872-2-nsaenzju@redhat.com>
 <87mtrmeqon.ffs@nanos.tec.linutronix.de>
 <YNHpN1h5hEZdt+Au@hirez.programming.kicks-ass.net>
 <YNIe38WaY0lOTEAZ@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNIe38WaY0lOTEAZ@krava>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jun 22, 2021 at 07:33:23PM +0200, Jiri Olsa wrote:
> On Tue, Jun 22, 2021 at 03:44:23PM +0200, Peter Zijlstra wrote:
> > On Sat, Jun 19, 2021 at 12:47:04AM +0200, Thomas Gleixner wrote:
> > > There are two solutions:
> > > 
> > >   1) Create a IRQ_WORK softirq and raise that
> > > 
> > >   2) Simply delegate it to a workqueue
> > 
> > IIRC someone was looking to stick the whole thing in a kthread_worker.
> > Jiri, was that you?
> > 
> 
> yep, I still plan on doing that

hum, IIRC that was actually perf specific change we discussed some
time ago I should have read the whole thread before answering

I'll check what was my plan to do and get back ;-)

jirka

