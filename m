Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA86AC433DF
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 14:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A243D2224D
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 14:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqWTmWEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHGOG6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:06:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48911 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726191AbgHGOEU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 10:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596809058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GXVhD3g6ivnac0fcrazCB91JC9lqn0ES5uvBW9pR7CI=;
        b=TqWTmWElxtZDngVPQZj33LPFcz1PT3ujODGKKvP6gyGcgMRBrqrJ5+cgknG9yvHEzowx6D
        dOShxb7oIm5lmiRU+6UrqKdlQ4o9tWcp/arbM4fsc78L+J9328Zi/gwC8Z7eZIMB87EOTd
        XFq3R9+1Hfm/RSWDuaI8vlqodvKbmkI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-PEZN5786MOObd7SfTsuG2Q-1; Fri, 07 Aug 2020 10:04:16 -0400
X-MC-Unique: PEZN5786MOObd7SfTsuG2Q-1
Received: by mail-wr1-f71.google.com with SMTP id r14so798460wrq.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Aug 2020 07:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GXVhD3g6ivnac0fcrazCB91JC9lqn0ES5uvBW9pR7CI=;
        b=oj0wCaNCChhHxh559uD0iBLf1ynVhHUnye/65RHHjhpkU2HO6HeRtLa/5Y7Fcs7+DL
         mQH/fneWdDoyM9YQqianYMDFrab1LlWWvzHnsWp1Df+F9Q48cowTOBuSE793BtpfmHvj
         twXAe7sLXdMws5HRjCL8SZE0fog4oVcCsOsUrptxM6LmOhmIn0uBh08uk+vg9rCrjQnP
         YXRmkSFC7itawauWhN/r8fQV+ru/sebrSsZnW3PCM/lgZXMwI/9sFIwpSKz598ndUO88
         DCCuuYflff41c2dw3VyBTJqMoBnDRJhXhNd/D+dlchlnhTT/S68Jtl+psKTknswDvu/s
         yguw==
X-Gm-Message-State: AOAM5313jvcw1LpwgIstuw+h3GDd8XWeAyA7/xn+8oIiSYSd3Rgbqugd
        gsVMkPOYCbda+g+uqpUwWhBlO/y2WPTzikFtja6/OyonbkMV8XW0nfONDKq4KxN2NKgqBGXWqay
        7oYpbpEayIfXupVcJ8psjqCD+egw=
X-Received: by 2002:adf:ee8e:: with SMTP id b14mr13349623wro.213.1596809055473;
        Fri, 07 Aug 2020 07:04:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFnme6nB5sjnqXnT/i5KaKdqR/HrTEH/rsAWb6xNgVZbU3AgpzaUOvBS2QBrgwH91EUDWCyw==
X-Received: by 2002:adf:ee8e:: with SMTP id b14mr13349593wro.213.1596809055215;
        Fri, 07 Aug 2020 07:04:15 -0700 (PDT)
Received: from localhost.localdomain ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id h14sm10114783wml.30.2020.08.07.07.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 07:04:14 -0700 (PDT)
Date:   Fri, 7 Aug 2020 16:04:11 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 0/6] SCHED_DEADLINE server infrastructure
Message-ID: <20200807140411.GS42956@localhost.localdomain>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200807151632.36dc6200@nowhere>
 <20200807133041.GQ42956@localhost.localdomain>
 <20200807154120.5dc9599c@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807154120.5dc9599c@nowhere>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 07/08/20 15:41, luca abeni wrote:
> Hi Juri,
> 
> On Fri, 7 Aug 2020 15:30:41 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> [...]
> > > In the meanwhile, I have some questions/comments after a first quick
> > > look.
> > > 
> > > If I understand well, the patchset does not apply deadline servers
> > > to FIFO and RR tasks, right? How does this patchset interact with RT
> > > throttling?  
> > 
> > Well, it's something like the dual of it, in that RT Throttling
> > directly throttles RT tasks to make spare CPU cycles available to
> > fair tasks while this patchset introduces deadline servers to
> > schedule fair tasks, thus still reserving CPU time for those (when
> > needed).
> 
> Ah, OK... I was thinking about using deadline servers for both RT and
> non-RT tasks. And to use them not only to throttle, but also to provide
> some kind of performance guarantees (to all the scheduling classes).
> Think about what can be done when combining this mechanism with
> cgroups/containers :)
> 
> [...]
> > > I understand this is because you do not
> > > want to delay RT tasks if they are not starving other tasks. But
> > > then, maybe what you want is not deadline-based scheduling. Maybe a
> > > reservation-based scheduler based on fixed priorities is what you
> > > want? (with SCHED_DEADLINE, you could provide exact performance
> > > guarantees to SCHED_OTHER tasks, but I suspect patch 6/6 breaks
> > > these guarantees?)  
> > 
> > I agree that we are not interested in exact guarantees in this case,
> > but why not using something that it's already there and would give us
> > the functionality we need (fix starvation for fair)?
> 
> Ok, if performance guarantees to non-RT tasks are not the goal, then I
> agree. I was thinking that since the patchset provides a mechanism to
> schedule various classes of tasks through deadline servers, then
> using these servers to provide some kinds of guarantees could be
> interesting ;-)

Not saying that the wider scope approach is not worth pursuing, you know
I would be very much interested into that as well :-), but I'd leave it
for a later time. This proposal looks reasonably achieaveble in somewhat
short times and it should provide provable benefits to production today.
Plus, you are again right, foundations would be there already when we'll
be ready for the wider solution.

