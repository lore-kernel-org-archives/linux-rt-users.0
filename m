Return-Path: <SRS0=K+Cf=YC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A3EECE58E
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Oct 2019 09:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D01E21835
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Oct 2019 09:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T710TA+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfJIJr0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:47:26 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37750 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfJIJr0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Oct 2019 05:47:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id w67so1151808lff.4;
        Wed, 09 Oct 2019 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5zz6stZNbLOUF9RwmhIaciO7nTqVUA3pHO2Wwoa5u3U=;
        b=T710TA+mgpU24hfq4k3XUSrSB5fQWM40wBiC0MV8fEQSFOg/BSkVKCfGlCo7GRiIc8
         igjpw/S/CIUKNkItOeJ77GtdveVvz6LrhpYdOrkVsmUcxJvneKpEhtHTyMPJG+A8TE9v
         HmXn/MmSWBbpVKKJRuUm3gBoM3k9+Un6euf25+Uc7HikTS51G9q+ojV3RLbec5vVHyPT
         ACHHQfE5GPPAaAa60tQ/M+DCIO77/lj9Xv3m2G9Vmpfy+lr5Ev6i8v33Du03sfUeNlfT
         bKNEjLJTtiEQ4/md0Iizcc8DlCN3mLlHdRYaOUL2bgf0MrdLXg5C1tht1LJ4CHsmVB6+
         TwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5zz6stZNbLOUF9RwmhIaciO7nTqVUA3pHO2Wwoa5u3U=;
        b=J2w2RQzQ1b7pIQ8ubJKPyu9qeYKoiOUxrNkEyQYJniadwCQhXA1M6ap1QuyuRaVCZa
         0tsO8AcRs+X7MS7Motsa0CPP8aWtdRK2+xuy3M3ToxlkE1lvLLoV57wMi9Oio5mSw8On
         Tg2nwhCY998SLBKzdbOqTbWg2jN4+bo/had17JR1DzJZdQ2iWCbOt/IItlANGQYrBaux
         m6tnRYpQuQY1tjTykwGZi5ShvUzqVxMu9EUrRUEnqVRXwzddqR5qpBqLGv/umxO5Zcnb
         pMKSPRAIVZti0oTgeBt3YrhuD7Uxurh9VIaiAKivJ6MFtEY4OpRjTPpK6PWHF0Ss2/IU
         wcbg==
X-Gm-Message-State: APjAAAWusGmSUjzkogN0j0qNpYL/ogiVQq8KhOiMQU6dpAvDnLA2t5WH
        ZMzQISKx3AuYocNtHVKrNBA=
X-Google-Smtp-Source: APXvYqzW0zTmznOtUew4N93EV23Ym5wYfpfwTtt85xVX0FBrdwA6+SXB468dIAk+oDGTwFgxbfUjZQ==
X-Received: by 2002:a19:f709:: with SMTP id z9mr1489231lfe.170.1570614443447;
        Wed, 09 Oct 2019 02:47:23 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id d28sm361521lfq.88.2019.10.09.02.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 02:47:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 9 Oct 2019 11:47:14 +0200
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191009094714.GA7343@pc636>
References: <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
 <20191007083037.zu3n5gindvo7damg@beryllium.lan>
 <20191007105631.iau6zhxqjeuzajnt@linutronix.de>
 <20191007162330.GA26503@pc636>
 <20191007163443.6owts5jp2frum7cy@beryllium.lan>
 <20191007165611.GA26964@pc636>
 <20191007173644.hiiukrl2xryziro3@linutronix.de>
 <20191007214420.GA3212@pc636>
 <20191008160459.GA5487@pc636>
 <20191009060539.fmpqesc4wfisulrl@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009060539.fmpqesc4wfisulrl@beryllium.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello, Daniel.

On Wed, Oct 09, 2019 at 08:05:39AM +0200, Daniel Wagner wrote:
> On Tue, Oct 08, 2019 at 06:04:59PM +0200, Uladzislau Rezki wrote:
> > > so, we do not guarantee, instead we minimize number of allocations
> > > with GFP_NOWAIT flag. For example on my 4xCPUs i am not able to
> > > even trigger the case when CPU is not preloaded.
> > > 
> > > I can test it tomorrow on my 12xCPUs to see its behavior there.
> > > 
> > Tested it on different systems. For example on my 8xCPUs system that
> > runs PREEMPT kernel i see only few GFP_NOWAIT allocations, i.e. it
> > happens when we land to another CPU that was not preloaded.
> > 
> > I run the special test case that follows the preload pattern and path.
> > So 20 "unbind" threads run it and each does 1000000 allocations. As a
> > result only 3.5 times among 1000000, during splitting, CPU was not
> > preloaded thus, GFP_NOWAIT was used to obtain an extra object.
> > 
> > It is obvious that slightly modified approach still minimizes allocations
> > in atomic context, so it can happen but the number is negligible and can
> > be ignored, i think.
> 
> Thanks for doing the tests. In this case I would suggest to get rid of
> the preempt_disable() micro optimization, since there is almost no
> gain in doing so. Do you send a patch? :)
> 
I can do it, for sure, in case you do not mind, since it was your
initiative. Otherwise you can upload v2.

--
Vlad Rezki
