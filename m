Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C99C2B9F4
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Jun 2021 17:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 476DB61107
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Jun 2021 17:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhFVRfp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231733AbhFVRfm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 22 Jun 2021 13:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624383205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fprW9and+W4ZesgQO5v/nl41G796IELnfkI2rFtS/Gw=;
        b=CE4y9crAyzrdrLW9yhwhONvwNwRbvoqfuHy6sU392JzjfFaEJQ1cDdTSbTvrphYiJlh7Sg
        kbFw98WSLAAOzmXkUW/OGSVOZqbiARuFrEZ4zdgNYk4ivT4FjDP8LPRuFxAVmmqPHm01nK
        O1l8xDkDvmIfgQM1ekzzgl77XqUkHyc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-kWi9ZnX8M_aWTu1ue41f1g-1; Tue, 22 Jun 2021 13:33:24 -0400
X-MC-Unique: kWi9ZnX8M_aWTu1ue41f1g-1
Received: by mail-wr1-f69.google.com with SMTP id j2-20020a5d61820000b029011a6a8149b5so9591038wru.14
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Jun 2021 10:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fprW9and+W4ZesgQO5v/nl41G796IELnfkI2rFtS/Gw=;
        b=IzTEH4u2X3uja6FTuiePsyDvIUHfJSsjrnMvMTd9MP5LfN1c/R83LYr3Xbq1oYya9r
         lapRgJF0g7KEK2E+3hiHza1iaNjzEteiRzhOPKHYqN/5S/Du8O1vgO1ShuQ1+Z1poJff
         pGElvTWoSitZjqv9yLD/bdmYZH2UQ6HNPQHzg0zSKrcBpBfJTCJaWWGQyavxxx1NlBdV
         se73XBDxHnGLa9Klz279ztsBj6WmH/kKLV89xmgnW5jPpKJDCzBhNt2x35sTop3rNec4
         GyDcgWSshvyCQGJHSa45hu4YKBp+ZeIoSFxqJ86W/nV2HNSkjyxnMkHFbgEj9/UAW1gT
         3pjw==
X-Gm-Message-State: AOAM533NuwOA7TDDUNroBaGNjUTYS3JvABXp30XgANnIu3UfSs1QfrZb
        iAsXHny0hCP7YFjJ8kEV6/KJRi+eD9iPm5Wgo87SaAQ4xIFXzX/UtF7vc8rio7WbKDiiyffi47N
        m9j1V3oNZyHcgAy44ZJZ8rRPfGyw=
X-Received: by 2002:a5d:6485:: with SMTP id o5mr6180819wri.91.1624383203297;
        Tue, 22 Jun 2021 10:33:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRtw4dO+cTagjehQZeZVMFQsiqbYo/AqhuED3rToW/g+49XMW3/di5iqjgVHrjFvLRVb8IMw==
X-Received: by 2002:a5d:6485:: with SMTP id o5mr6180808wri.91.1624383203169;
        Tue, 22 Jun 2021 10:33:23 -0700 (PDT)
Received: from krava ([5.171.242.79])
        by smtp.gmail.com with ESMTPSA id v22sm2915055wmh.40.2021.06.22.10.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 10:33:22 -0700 (PDT)
Date:   Tue, 22 Jun 2021 19:33:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rt-users@vger.kernel.org, frederic@kernel.org,
        mtosatti@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC 2/2] timers: Make sure irq_work is handled when no pending
 timers
Message-ID: <YNIe38WaY0lOTEAZ@krava>
References: <20210610125945.558872-1-nsaenzju@redhat.com>
 <20210610125945.558872-2-nsaenzju@redhat.com>
 <87mtrmeqon.ffs@nanos.tec.linutronix.de>
 <YNHpN1h5hEZdt+Au@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNHpN1h5hEZdt+Au@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jun 22, 2021 at 03:44:23PM +0200, Peter Zijlstra wrote:
> On Sat, Jun 19, 2021 at 12:47:04AM +0200, Thomas Gleixner wrote:
> > There are two solutions:
> > 
> >   1) Create a IRQ_WORK softirq and raise that
> > 
> >   2) Simply delegate it to a workqueue
> 
> IIRC someone was looking to stick the whole thing in a kthread_worker.
> Jiri, was that you?
> 

yep, I still plan on doing that

jirka

