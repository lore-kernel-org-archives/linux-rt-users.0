Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1E0C2B9F4
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Jun 2021 13:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD2A61C74
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Jun 2021 13:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhF1NxR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Jun 2021 09:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232357AbhF1Nwz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Jun 2021 09:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624888229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DMK9OptVb1F8pIZsdHHHz8DEy/sPMopWfS2vl5q6VgE=;
        b=PwvPbzft6Oae49uso4gpnDrsbdDhnsjKQtD/nV5FHyu8vPJ+N8iPQu6q6c9mn2sQnJZCe6
        HezMJGZLbfFH/GT7lDpJ0vRfSDGm85lBQnF/ypDj9YL09ZuPd+tWxz+r/k2dI8qIuo9JD7
        67+RE2RZ8cnhd6OIGVV16Px4zvlgfF8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-AKsi5pDuMhS_SHmXRrs6BA-1; Mon, 28 Jun 2021 09:50:27 -0400
X-MC-Unique: AKsi5pDuMhS_SHmXRrs6BA-1
Received: by mail-qk1-f198.google.com with SMTP id c3-20020a37b3030000b02903ad0001a2e8so17609793qkf.3
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Jun 2021 06:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=DMK9OptVb1F8pIZsdHHHz8DEy/sPMopWfS2vl5q6VgE=;
        b=Poq8oSEOMFkX5mmTCKNEAzY5OEcCyGLFEAdPK6V31bRkPSy+H5xAOX1hK5eKX1NwCT
         O65u1wuAEttK1+C0ZV/+0JWaEoV8QxsRqb4O7Oahw34xNM1Ug8PeF27mzGWIXKLnuPHm
         RSuvn4tcgaxidyvW35Ha06LQvZutkKtccTOm7L2ASQ5QeHs0OowhlJA1mw5keM0jUm2y
         PrpkgjB0Ty9oqkpvnzzp64RUOofc7bxY8qDtZJi5nIey4cxrDnEqKz3deZKSht5a3Lcw
         GhVcQrnX1lo+HVkan2iBythVmJqkeHdZb9A+wlpCQI4oFvP0SeINLKR/VzPa1M3OO0ar
         XDQg==
X-Gm-Message-State: AOAM530UdLr5P1SP8oLjkaXqUu+WtZsuDLC409SDK4BxE5fl8EEhcOel
        VXrD9Cb7FjM9IBPh55BhqLm0zroKnj5cv31+aYrpAHOGZyesY+btiVeMwiVmy8DgdR9oqP5UiHR
        QIYb7VqzD7SdINVNFHLqrX/6N904=
X-Received: by 2002:a37:454a:: with SMTP id s71mr25281107qka.88.1624888227559;
        Mon, 28 Jun 2021 06:50:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8SSjGVqIolCL+Kaxzfg0aBIfR8K6DyKGVYmp8TXZdr3MGTX+sVfxY14VwzUn5zxjMlZcHrQ==
X-Received: by 2002:a37:454a:: with SMTP id s71mr25281082qka.88.1624888227374;
        Mon, 28 Jun 2021 06:50:27 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-156.dsl.bell.ca. [174.88.120.156])
        by smtp.gmail.com with ESMTPSA id u15sm10318869qku.33.2021.06.28.06.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 06:50:26 -0700 (PDT)
Date:   Mon, 28 Jun 2021 09:50:25 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <wagi@monom.org>
cc:     Mike Galbraith <efault@gmx.de>,
        RT <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Johnathan Schwender <schwenderjonathan@gmail.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [ANNOUNCE] rt-tests-2.0
In-Reply-To: <20210628081135.l7yvya7iaygb23ye@beryllium.lan>
Message-ID: <f31d9d37-df6d-90b0-8bf9-95156c27e8d@redhat.com>
References: <20210625160801.9283-1-jkacur@redhat.com> <549a4a5579068b9b1ca7741cb0f4aafbd04f4389.camel@gmx.de> <1c1966dd51ae6f8ddcd892cba485c332281fbd37.camel@gmx.de> <3d6a6c593eed6f5d59209ba2d8db29fadcc72ad7.camel@gmx.de>
 <20210628081135.l7yvya7iaygb23ye@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 28 Jun 2021, Daniel Wagner wrote:

> Hi Mike,
> 
> On Sat, Jun 26, 2021 at 02:45:27PM +0200, Mike Galbraith wrote:
> > On Sat, 2021-06-26 at 13:47 +0200, Mike Galbraith wrote:
> > > On Sat, 2021-06-26 at 08:55 +0200, Mike Galbraith wrote:
> > > > On Fri, 2021-06-25 at 12:08 -0400, John Kacur wrote:
> > > > > I'm pleased to announce rt-tests-2.0
> > > >
> > > > Greetings,
> > > >
> > > > cyclictest seems to have grown an mlock related regression.
> > >
> > > Ok, chores done, I did a quick bisect/confirm.  I didn't go stare
> > > at rt_test_start() to ponder what the mlockall connection may be.
> >
> > Moving the call above "Get current time" stops it mucking things up.
> 
> Thanks a lot for your excellent report. rt_test_start does
> 
>   static char ts_start[MAX_TS_SIZE];
> 
>   static void get_timestamp(char *tsbuf)
>   {
>           struct timeval tv;
>           struct tm *tm;
>           time_t t;
> 
>           gettimeofday(&tv, NULL);
>           t = tv.tv_sec;
>           tm = localtime(&t);
>           /* RFC 2822-compliant date format */
>           strftime(tsbuf, MAX_TS_SIZE, "%a, %d %b %Y %T %z", tm);
>   }
> 
>   void rt_test_start(void)
>   {
>           get_timestamp(ts_start);
>   }
> 
> I'd say the tsbuf access is the one which triggers a pagefault.
> 
> John, I would suggest to move the rt_test_start() into rt_init() and
> take the timestamp at the execution start (as my initial version was). I
> think the additional pain in slightly more correct start timestamp
> (which is also not defined what it actually means in this context) is
> just not worth the effort.
> 
> Thanks,
> Daniel
> 

Send me a patch, and I'll have a look. The timerthread()function is
sensitive anyway, so it's probably a good idea not to put that kind
of thing there.

Note that the the code following the /* Get Current Time */
is getting the time, but you probably want something rougher that
you can call strftime on?

John

