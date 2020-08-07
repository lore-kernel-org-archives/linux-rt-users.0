Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C39C433DF
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 14:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4BB22CA1
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 14:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBd3rcPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgHGOLx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:11:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37100 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGOLm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 10:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596809501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3c1yw7k9X8hm0dHhBiwxK4zbTgM0Mhf/wXgVInw3T7o=;
        b=RBd3rcPFwHz/eJQ2LlX+tnHbg3xoi2tmGJ4MBmR/ZwCqz5H7dzNYEvK0Wfelh7KlvdGCfD
        44Ve8WPX3yv4+KQ+pDZYT5HvI5QpGwTqbhtRKsZLk2bDNv2a/Rj5NrdR/slZka6V36K/mC
        kymkjOTafw+ZNS4J7sQZfK7cUM0GFtM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-cFoMWULnP-y8Y_3D1LSeEw-1; Fri, 07 Aug 2020 10:11:39 -0400
X-MC-Unique: cFoMWULnP-y8Y_3D1LSeEw-1
Received: by mail-wr1-f69.google.com with SMTP id k11so798248wrv.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Aug 2020 07:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3c1yw7k9X8hm0dHhBiwxK4zbTgM0Mhf/wXgVInw3T7o=;
        b=OS5vtyyk+TzJYeObt58wcZXp2RiZGZgyWhtnk/bpZ2qDSytJZ4dXnkoeWXrzbC9Vic
         +tDHD5/Q45s85FI48PVE4HKgrEX9j9ynPVYEiBvs9gBkrCZdPAFyg4eAyJ7pV002DD4Q
         C9KgZbgPRX0pXfCb+mtYoqlaSum9wjfOXdj3ItRTuZZCTKDp+wCJnRU6VsWOFaTgQGdr
         46EoduGzjVME6kmIZGNTwI2UsYwNVPuuqkCvDVCElEfu8vYBx9KZiB5BOKyPBw6lwlwB
         XyHbkVLgZnny6ru9CjduLT9hdX2maPpSZTK5knt0Nzaxq9IL2EhAdQLd6f7nnMesLL95
         BsEw==
X-Gm-Message-State: AOAM533nxM2XxtJCnuOPeUCkk1Iby8vLh4iZOJVJSBcYohq7h5Yq8q4R
        JWQxbzuibkkJ1pXax3yFbUntROK1EAZWIICRcT/MEaTQ4j+gNkV/O7HrRAc2gUReifZVGfxRq9K
        yh6wulqTZrnDWU/Z4lJ9U+DKBq9Y=
X-Received: by 2002:adf:81c5:: with SMTP id 63mr12748567wra.185.1596809498218;
        Fri, 07 Aug 2020 07:11:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvEkand5vtybeLw6SUi+cwMVVl7XbxNslOqTgZI0RMJgnMHG9r2j1ZQJPEaSceKtI6AHDGog==
X-Received: by 2002:adf:81c5:: with SMTP id 63mr12748548wra.185.1596809497939;
        Fri, 07 Aug 2020 07:11:37 -0700 (PDT)
Received: from localhost.localdomain ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id o124sm10775755wmb.2.2020.08.07.07.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 07:11:37 -0700 (PDT)
Date:   Fri, 7 Aug 2020 16:11:35 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
Message-ID: <20200807141135.GT42956@localhost.localdomain>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200807095604.GO42956@localhost.localdomain>
 <20200807152832.591f462e@nowhere>
 <20200807134353.GR42956@localhost.localdomain>
 <20200807155510.2b380f49@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807155510.2b380f49@nowhere>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 07/08/20 15:55, luca abeni wrote:
> On Fri, 7 Aug 2020 15:43:53 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > On 07/08/20 15:28, luca abeni wrote:
> > > Hi Juri,
> > > 
> > > On Fri, 7 Aug 2020 11:56:04 +0200
> > > Juri Lelli <juri.lelli@redhat.com> wrote:
> > >   
> > > > Starting deadline server for lower priority classes right away
> > > > when first task is enqueued might break guarantees  
> > > 
> > > Which guarantees are you thinking about, here? Response times of
> > > fixed priority tasks?  
> > 
> > Response time, but also wakeup latency (which, for better or worse, is
> > another important metric).
> > 
> > > If fixed priority tasks are also scheduled through deadline servers,
> > > then you can provide response-time guarantees to them even when
> > > lower-priority/non-real-time tasks are scheduled through deadline
> > > servers.  
> > 
> > Right, but I fear we won't be able to keep current behavior for
> > wakeups: RT with highest prio always gets scheduled right away?
> 
> Uhm... I think this depends on how the servers' parameters are
> designed: assigning "wrong" (or "bad") parameters to the server used to
> schedule RT tasks, this property is broken.
> 
> (however, notice that even with the current patchset the highest
> priority task might be scheduled with some delay --- if the SCHED_OTHER
> deadline server is active because SCHED_OTHER tasks are being starved).

But that's OK I think, because if the server is active it means that
OTHER didn't get a chance to run for some time and if it continues to
hung than worse problems than breaking FIFO assumptions will happen. :-/

