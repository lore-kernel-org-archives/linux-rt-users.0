Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672B0C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 15:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224A264DDC
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 15:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhBSP0A (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 10:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhBSPZ6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 10:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613748270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tObDEWJX9jonTf3h2XN+GXRKLKjekviQtqTkMsGog3s=;
        b=TF+dNswoDNywp8fP9IMaoQJNMZJsl8tHDUZo17faAshA9LA/f3py9fBjTi7T8dQ6FYJVu2
        bl22zMsJOH6+Ifr/sIrk5g6I71dXwegNs7gn59PEXlEtreclU8vcNjJ1riCZxDpKanqJJF
        dTKTOEhbx2qeSSdj+2QhT+RiSkHyFuA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-1Uf4X6D2MUuopdSJAwHJyA-1; Fri, 19 Feb 2021 10:24:20 -0500
X-MC-Unique: 1Uf4X6D2MUuopdSJAwHJyA-1
Received: by mail-qv1-f71.google.com with SMTP id v1so3400395qvb.2
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 07:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tObDEWJX9jonTf3h2XN+GXRKLKjekviQtqTkMsGog3s=;
        b=ixrMaqIDJlTFWqU/yFIh0RrgDAn77RQYoBEXgcWzVoiNcnS7xEMSvMHKSFRgzFnfMW
         p8hd4tdI+8VFN07PbVj7Jouo3PRwJokrXAcSp9t+3iaxJBo44xDBj1eHyI7D1k6Ai9aT
         jWLAJvqpXx5/wqK1rIcsbH/4NcJmJLxyef8tPkWZrGLgkymjhhnJFkqeeMxib4rm367F
         Zeyd5BxZTgJnMthKPJ3z3uCbu3DcXe8zPF6/4YaMw5LHggRTtdlYpKo6/MHKVDzCkkeX
         knJAw1Yd3ml/l4d85gJ0Ckwc41Vk4KeMTv2OCJJplA/mnEuT8HKW5ucQ4MH7ugY7HNPc
         eFYg==
X-Gm-Message-State: AOAM533x81MvAQWJPA7ErhWVDzgsLSfmBwBFz8Sh7ZI6nX9MAiG+Oxe6
        b7177nGwG92KyL663TzlZy/2XX6rS+con3djWYkDuHxtpBHHuEGKb0MMsruGIGVH5AV54aGv0oF
        nSE79P9ESXx7nFsS4k6BrJjwAHuI=
X-Received: by 2002:a37:478a:: with SMTP id u132mr9963144qka.135.1613748259443;
        Fri, 19 Feb 2021 07:24:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwp3Cj0O+M0Kbg1XfR8kQfaudHqsJ7FGDcUu3zVxjNxj9u+b2/1FF7GTIT3Z2NFsotXD1+Xg==
X-Received: by 2002:a37:478a:: with SMTP id u132mr9963112qka.135.1613748259110;
        Fri, 19 Feb 2021 07:24:19 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id c9sm6511670qkl.60.2021.02.19.07.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 07:24:18 -0800 (PST)
Date:   Fri, 19 Feb 2021 10:24:17 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
Subject: Re: [PATCH] oslat: Fix --cpu-list won't allow to schedule on all
 possible cores
Message-ID: <20210219152417.GE6669@xz-x1>
References: <20210218192729.116427-1-peterx@redhat.com>
 <20210219081611.xsugonlz7dl4zhvx@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219081611.xsugonlz7dl4zhvx@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Feb 19, 2021 at 09:16:11AM +0100, Daniel Wagner wrote:
> Hi Peter,

Hi, Daniel,

> 
> On Thu, Feb 18, 2021 at 02:27:29PM -0500, Peter Xu wrote:
> > parse_cpumask() is too strict for oslat, in that use_current_cpuset() will
> > filter out all the cores that are not allowed for current process to run.  This
> > seems to be unnecessary at least for oslat.  For example, the bash process that
> > runs the oslat program may have a sched affinity of 0-2, however it's still
> > legal to have it start a oslat thread running on the cores outside 0-2 as long
> > as the follow up sched_setaffinity() will succeed.
> > 
> > numa_parse_cpustring_all() suites exactly for this case, which should already
> > have considered sysconf(_SC_NPROCESSORS_ONLN) limit.  Use that instead.
> > 
> > Since at it, also remove initialization of cpu_set variable otherwise it's
> > leaked in previous parse_cpumask too: numa_parse_cpustring_all() will return a
> > newly allocated buffer already.  Quotting from manual:
> > 
> >     numa_parse_nodestring() parses a character string list of nodes into a bit
> >     mask.  The bit mask is allocated by numa_allocate_nodemask().
> > 
> >     numa_parse_nodestring_all() is similar to numa_parse_nodestring, but can
> >     parse all possible nodes, not only current nodeset.
> 
> My 2 cents: If parse_cpumask() is to strict fix parse_cpumask() so all
> tools do the same thing. Note parse_cpumask() contains a couple
> of bugs:
> 
> "rt-numa: Use mask size for iterator limit"
> "rt-numa: Remove max_cpus argument from parse_cpusmask"

Yes I explicitly avoided touching parse_cpumask because I don't want to change
behavior of other tools if I'm not confident with that.  Would above two
patches fix oslat too (which I didn't check)?  If so, I'll be fine to have this
patch dropped.  Otherwise I tend to prefer fixing oslat first.  We can further
rework the common code, but if existing tools are fine, then I don't think it's
a bugfix, so no need to rush.  While I'll count this patch as a real bugfix, so
I'd hope we could consider merging it earlier.

Thanks,

-- 
Peter Xu

