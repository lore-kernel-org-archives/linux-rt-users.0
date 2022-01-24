Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4381C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jan 2022 16:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241183AbiAXQo0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Jan 2022 11:44:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241172AbiAXQoZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jan 2022 11:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643042664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHxxA0uqmhHzTitqziLoKH7kBkHjZVC4vScGQjqQoiY=;
        b=hUHYfJeC7+OIyb7WUAZpGGOBQciqLNbJY8ldje1BIz71wGGCtNdAve8uAusJtWqm5sw6Qm
        eJTHliKrdqzvT5039xB+cFm5u9YTQiMlu1byfgamfIPNAM3Ptv8FrYL0VsexKCbz/lfG65
        KcRev3Q7wiY92xcwCoIJHdEXqsUcMPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-tdwTvUQYPtup1-l4_a8DwQ-1; Mon, 24 Jan 2022 11:44:22 -0500
X-MC-Unique: tdwTvUQYPtup1-l4_a8DwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F02F583DD20;
        Mon, 24 Jan 2022 16:44:21 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FF982DE6F;
        Mon, 24 Jan 2022 16:44:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 648C14188583; Mon, 24 Jan 2022 13:44:12 -0300 (-03)
Date:   Mon, 24 Jan 2022 13:44:12 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rt-numa: optionally ignore runtime cpumask
Message-ID: <Ye7XXN0Ym4IpCb5N@fuller.cnet>
References: <YerAW90QwEg9yXAb@fuller.cnet>
 <Yer4kB0fmR41u19Y@linutronix.de>
 <Ye6id4lSKMcqAZ65@fuller.cnet>
 <Ye7TMlx3mJkTxCsI@linutronix.de>
 <Ye7WkRKz9Ha/ROP1@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye7WkRKz9Ha/ROP1@fuller.cnet>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Jan 24, 2022 at 01:40:49PM -0300, Marcelo Tosatti wrote:
> On Mon, Jan 24, 2022 at 05:26:26PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2022-01-24 09:58:31 [-0300], Marcelo Tosatti wrote:
> > > You mean "using all CPUs which are part of the current affinity mask by
> > > default" ? (where current affinity mask would mean user specified CPU
> > > mask).
> > > 
> > > > And then either specify the
> > > > requested CPU mask or use explicitly all CPUs.
> > > 
> > > Do you mean to drop 
> > > 
> > >         /*
> > >          * Clear bits that are not set in both the cpuset from the
> > >          * environment, and in the user specified affinity.
> > > 
> > > And just attempt to use the user specified mask? (which will then return
> > > failure to the user in which case he can correct it).
> > > 
> > After reading it again, I don't get it.
> >   cyclictest -a
> > 
> > Uses all CPUs in the system. 
> > 
> >   cyclictest -a $CPU
> > 
> > Uses the $CPU (mask) specified. If $CPU is not part of the current CPU
> > mask, why shouldn't it work?
> 
>        -a, --affinity[=PROC-SET]
>               Run threads on the set of processors given by PROC-SET.  If PROC-SET is not specified, all processors will be used.  Threads will be assigned to processors
>               in the set in numeric order, in a round-robin fashion.
>               The set of processors can be specified as A,B,C, or A-C, or A-B,D-F, and so on*.  The ! character can be used to negate a set.  For example, !B-D means to
>               use all available CPUs except B through D.  The cpu numbers are the same as shown in the processor field in /proc/cpuinfo.  See numa(3) for more
>               information on specifying CPU sets.  * Support for CPU sets requires libnuma version >= 2.  For libnuma v1, PROC-SET, if specified, must be a single CPU
>               number.
> 
> 
> /*
>  * After this function is called, affinity_mask is the intersection of
>  * the user supplied affinity mask and the affinity mask from the run
>  * time environment
>  */
> static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
> {
>         struct bitmask *curmask;
>         int i;
> 
>         curmask = numa_allocate_cpumask();
>         numa_sched_getaffinity(getpid(), curmask);
> 
>         /*
>          * Clear bits that are not set in both the cpuset from the
>          * environment, and in the user specified affinity.
>          */
>         for (i = 0; i < max_cpus; i++) {
>                 if ((!numa_bitmask_isbitset(cpumask, i)) ||
>                     (!numa_bitmask_isbitset(curmask, i)))
>                         numa_bitmask_clearbit(cpumask, i);
>         }
> 
>         numa_bitmask_free(curmask);
> }
> 
> Consider 8 CPU system booted with isolcpus=3-7, and execution of 
> "cyclictest -a 3-7".
> 
> sched_getaffinity() returns mask with bits set for CPUs 0 and 1, 

and 2.

> The user supplied mask has bits 3-7 set.
> 
> The intersection between the user supplied mask and the affinity mask
> from the run time environment has no bits set.
> 
> 
> 

