Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35ACC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jan 2022 17:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244383AbiAXRvI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:51:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241600AbiAXRvH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jan 2022 12:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643046666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8hEnZEaAOydntLSybTwZEEiQgm+0yArkcn3z0awzbw=;
        b=iqOgxlVArB536I7WjLPNIUZLmZnn6/ziFSSWqHKcGKgCFQJcdNI/9a87MWHfqSrbRaLScw
        ziF1zDQk1iArq5QOJWDsso0sYYHEY+EusvemQBJzufrgBofVCM1YzpijXi7hrvuGlxheSU
        Z64MyeFX03cvMZ6zAO1eQqOcsphwA2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-rSQIxxJrOSSFJEZAGt0Ilg-1; Mon, 24 Jan 2022 12:51:04 -0500
X-MC-Unique: rSQIxxJrOSSFJEZAGt0Ilg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E78141054F91;
        Mon, 24 Jan 2022 17:51:02 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFC2A84FF7;
        Mon, 24 Jan 2022 17:51:02 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 9F5924188583; Mon, 24 Jan 2022 14:50:39 -0300 (-03)
Date:   Mon, 24 Jan 2022 14:50:39 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rt-numa: optionally ignore runtime cpumask
Message-ID: <Ye7m71SHlJ+ZdJeQ@fuller.cnet>
References: <YerAW90QwEg9yXAb@fuller.cnet>
 <Yer4kB0fmR41u19Y@linutronix.de>
 <Ye6id4lSKMcqAZ65@fuller.cnet>
 <Ye7TMlx3mJkTxCsI@linutronix.de>
 <Ye7WkRKz9Ha/ROP1@fuller.cnet>
 <Ye7c2cWSNJvdegmq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye7c2cWSNJvdegmq@linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Jan 24, 2022 at 06:07:37PM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-01-24 13:40:49 [-0300], Marcelo Tosatti wrote:
> > > Uses the $CPU (mask) specified. If $CPU is not part of the current CPU
> > > mask, why shouldn't it work?
> > 
> >        -a, --affinity[=PROC-SET]
> >               Run threads on the set of processors given by PROC-SET.  If PROC-SET is not specified, all processors will be used.  Threads will be assigned to processors
> >               in the set in numeric order, in a round-robin fashion.
> >               The set of processors can be specified as A,B,C, or A-C, or A-B,D-F, and so on*.  The ! character can be used to negate a set.  For example, !B-D means to
> >               use all available CPUs except B through D.  The cpu numbers are the same as shown in the processor field in /proc/cpuinfo.  See numa(3) for more
> >               information on specifying CPU sets.  * Support for CPU sets requires libnuma version >= 2.  For libnuma v1, PROC-SET, if specified, must be a single CPU
> >               number.
> > 
> > 
> > /*
> >  * After this function is called, affinity_mask is the intersection of
> >  * the user supplied affinity mask and the affinity mask from the run
> >  * time environment
> >  */
> > static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
> > {
> >         struct bitmask *curmask;
> >         int i;
> > 
> >         curmask = numa_allocate_cpumask();
> >         numa_sched_getaffinity(getpid(), curmask);
> > 
> >         /*
> >          * Clear bits that are not set in both the cpuset from the
> >          * environment, and in the user specified affinity.
> >          */
> >         for (i = 0; i < max_cpus; i++) {
> >                 if ((!numa_bitmask_isbitset(cpumask, i)) ||
> >                     (!numa_bitmask_isbitset(curmask, i)))
> >                         numa_bitmask_clearbit(cpumask, i);
> >         }
> > 
> >         numa_bitmask_free(curmask);
> > }
> > 
> > Consider 8 CPU system booted with isolcpus=3-7, and execution of 
> > "cyclictest -a 3-7".
> > 
> > sched_getaffinity() returns mask with bits set for CPUs 0 and 1.
> > The user supplied mask has bits 3-7 set.
> > 
> > The intersection between the user supplied mask and the affinity mask
> > from the run time environment has no bits set.
> 
> Okay. But does this make to keep? I understand that the current CPU-mask
> needs to be kept for masks like !B or !B-D. But is there a need to use
> the current CPU-mask when a specific mask has been specified by the user?

Ok, then:

1) If user specifies -a CPULIST, ignore sched_getaffinity().

2) If user specifies -a, or -a !CPULIST, use sched_getaffinity().

Will send a patch.

