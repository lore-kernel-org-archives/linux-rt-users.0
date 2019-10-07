Return-Path: <SRS0=Z5tp=YA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29658C47404
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 16:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A1420673
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEf7pYBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfJGQXl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:23:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41289 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGQXk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Oct 2019 12:23:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id f5so14351427ljg.8;
        Mon, 07 Oct 2019 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XdTXHd6eOg2X0xWdOXFCjDQDWIq75TulzQqD+eDP0mI=;
        b=IEf7pYBd9Obws3WL57L0IeYyuE9rQUWh/aJEJVrbGqa7BbNo/IWHkhNC2Wa/OLJ+Fl
         c/ZALioIs9inOdQexGgrSqKlWw1LRECAuhwvXrqA2GU3Mgv0L/6YEx131fGYoVNF0VGI
         WZr5GQDFGVW46LTyXC8ztGVxwf0y7FUEqb2KzepuDMqtZtpiwf2lUmLMywOSyuLDXhsu
         /hTbKO4A8hczRtdBlXeLfwKAlbRGhUsLvRI2yRLsriouN7T+L68bKUaTeYRf2XWCobxn
         7jxuvRsG1fbxxJYbU11SHiPmvXVgTbeiuzmm0epfV7EwyJF/N1z8fyUYM7FOYezmPs0H
         l16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XdTXHd6eOg2X0xWdOXFCjDQDWIq75TulzQqD+eDP0mI=;
        b=UlA0vC87Y98xhownqT01o2bcuJegabAdROQ13KCm7YPEFbGZZgbbgOJHzZ9Ktg8Vqu
         sYehfyoVa6L8CFo0dzfiOLiERgs77j6dMWl/bF0KkOJtexhRWwWcMYkPf1JETW8yJbNr
         up8pGF2pZLsx8PbNTs+Ag9gYPUlCnpWsUB31WMZbM/on+m5aZ4rB1OowGewAbFQSecq8
         KuQW2DNAM6gXxdWSud5YhEd/lx9c76viFDqGEH/EY9k7QOqDGnv87ScdRo7s4wdW9uZJ
         xOIYvwCw/D/hiyRivkMhOE1UAVfypVtiVfs77fejbOCHZ063o3AzXi3r5xU4E09/yB2y
         npTw==
X-Gm-Message-State: APjAAAVdNxVd0ACnkpDklGJH7oa7j5crnpVUtUjUOThcnbWx5ORV3dOI
        4IDktFEO9x0naoPX/Hdgx2I=
X-Google-Smtp-Source: APXvYqwkzrJdh+KjN76tgwK99YjkKXWXIh8GMApWLohDVRRV/egNWJPDqy8vkQY+4J8gwvRXK19fTA==
X-Received: by 2002:a2e:9799:: with SMTP id y25mr19076940lji.38.1570465418511;
        Mon, 07 Oct 2019 09:23:38 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id u26sm2793207lfd.19.2019.10.07.09.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:23:37 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 7 Oct 2019 18:23:30 +0200
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191007162330.GA26503@pc636>
References: <20191003090906.1261-1-dwagner@suse.de>
 <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
 <20191004162041.GA30806@pc636>
 <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
 <20191007083037.zu3n5gindvo7damg@beryllium.lan>
 <20191007105631.iau6zhxqjeuzajnt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007105631.iau6zhxqjeuzajnt@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello, Daniel, Sebastian.

> > On Fri, Oct 04, 2019 at 06:30:42PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-10-04 18:20:41 [+0200], Uladzislau Rezki wrote:
> > > > If we have migrate_disable/enable, then, i think preempt_enable/disable
> > > > should be replaced by it and not the way how it has been proposed
> > > > in the patch.
> > > 
> > > I don't think this patch is appropriate for upstream.
> > 
> > Yes, I agree. The discussion made this clear, this is only for -rt
> > trees. Initially I though this should be in mainline too.
> 
> Sorry, this was _before_ Uladzislau pointed out that you *just* moved
> the lock that was there from the beginning. I missed that while looking
> over the patch. Based on that I don't think that this patch is not
> appropriate for upstream.
> 
Yes that is a bit messy :) Then i do not see what that patch fixes in
mainline? Instead it will just add an extra blocking, i did not want that
therefore used preempt_enable/disable. But, when i saw this patch i got it
as a preparation of PREEMPT_RT merging work.

--
Vlad Rezki
