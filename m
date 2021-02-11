Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24B3C4332D
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 15:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF76B64E9C
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 15:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhBKPaS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Feb 2021 10:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230027AbhBKP0W (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Feb 2021 10:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613057096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VSWWjtdxhSAfYfxUswD5NQDGP3rDQRjmJatB2pM4EhE=;
        b=OTxliobqva3thvlJl36C00f7JwaKlzotA6DEvN0Ee5r0fy8ApG68iGusQ+IyhtfpxVpt4f
        HuaFa+1ihNse71goLviA90plRF2cVq2a4vAHdrTe4yTKG/+FJn8wF4GmT0ut/h2JvkvJvK
        LenGIgJk9UkAbFNc04UGRUM4bk0SUVM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-uwZAz6PAPFSObnLvKmRpsg-1; Thu, 11 Feb 2021 10:24:54 -0500
X-MC-Unique: uwZAz6PAPFSObnLvKmRpsg-1
Received: by mail-qt1-f200.google.com with SMTP id d11so4409869qth.3
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Feb 2021 07:24:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VSWWjtdxhSAfYfxUswD5NQDGP3rDQRjmJatB2pM4EhE=;
        b=pKTnZ8fgeD2Toi2j7mz785uy+C/7YzPJUEmIsJzBD81ikMUJKqiRgO6ZTYMR+f9vc5
         F8uojAUhRFhL9rdXnInAp1d0bcJ2LEu1HOkSFJsw9AG0H5jwAs1h6cu3++ASBxd/iYKj
         KVMSxfbzFeXErnYy//CIZhZB747k3Kk6Mr8KI0wUKb4XmbWlR4i/c0ipwRByLOj/GQeh
         YdJAkatiHWuCuTb3j7cZqNsZZZD4FZgzCUCsIKGlJxgLGadUiHlDoLeYYgEW2ip8IDbF
         r+zjKJZmVfHgVpcxGiJL4B7ypgz2yVMFHGs8oKd3avkaRzi0O1MCnYCvFqGEKSDEwOGQ
         sUIQ==
X-Gm-Message-State: AOAM531AF7qOVJM7xcQ7KQ9yP0ghwmORwOa2W41fgUtCpKc7ZZO4XvYx
        25ZLv3gAX0mccm+CMQSD9kTMt935KxlyTVtCUNRGcqUncwjV3Y/V247nP7Qd6GfjKOE6gZFa+8q
        6S+O2oAZuLkm8UVW2p/G7RZXPh5Q=
X-Received: by 2002:a05:620a:1477:: with SMTP id j23mr8709291qkl.462.1613057093736;
        Thu, 11 Feb 2021 07:24:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyW3E4xezNabDasjaXdKXo3aNeNLNMr49Sq5T+ZQxYRpWM8U4Zo0eV4fHuNGFZRRUAMy1c+xQ==
X-Received: by 2002:a05:620a:1477:: with SMTP id j23mr8709262qkl.462.1613057093461;
        Thu, 11 Feb 2021 07:24:53 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id h6sm4152227qkf.96.2021.02.11.07.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 07:24:53 -0800 (PST)
Date:   Thu, 11 Feb 2021 10:24:51 -0500
From:   Peter Xu <peterx@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests 2/2] oslat: Use cpuset size as upper bound
Message-ID: <20210211152451.GB142818@xz-x1>
References: <20210210165407.9770-1-dwagner@suse.de>
 <20210210165407.9770-3-dwagner@suse.de>
 <fe39aaf5-57f5-c36a-70ea-af212318ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe39aaf5-57f5-c36a-70ea-af212318ea@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Feb 10, 2021 at 11:28:16PM -0500, John Kacur wrote:
> 
> 
> On Wed, 10 Feb 2021, Daniel Wagner wrote:
> 
> > To assign the threads to the correct CPU we need to use the cpuset
> > size as upper bound for the loop and not the number of threads.
> > 
> > Fixes: 85b0763dacd9 ("oslat: Use parse_cpumask() from rt-numa.h")
> > Reported-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >  src/oslat/oslat.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> > index d3f659b218b0..62b82098419a 100644
> > --- a/src/oslat/oslat.c
> > +++ b/src/oslat/oslat.c
> > @@ -742,9 +742,12 @@ int main(int argc, char *argv[])
> >  	n_cores = numa_bitmask_weight(cpu_set);
> >  
> >  	TEST(threads = calloc(1, n_cores * sizeof(threads[0])));
> > -	for (i = 0; i < n_cores; ++i)
> > -		if (numa_bitmask_isbitset(cpu_set, i) && move_to_core(i) == 0)
> > +	for (i = 0; n_cores && i < cpu_set->size; i++) {
> > +		if (numa_bitmask_isbitset(cpu_set, i) && move_to_core(i) == 0) {
> >  			threads[g.n_threads_total++].core_i = i;
> > +			n_cores--;
> > +		}
> > +	}
> >  
> >  	if (numa_bitmask_isbitset(cpu_set, 0) && g.rtprio)
> >  		printf("WARNING: Running SCHED_FIFO workload on CPU 0 may hang the thread\n");
> > -- 
> > 2.30.0
> > 
> > 
> 
> This looks okay, but we are waiting for Pradipta's testing to confirm 
> before I push it.

After the reporter's confirmation there seems to have two issues.  Daniel's
patch should be a valid fix of at least one of the problem.  The other problem
is still under investigation and I think it's not affecting the upstream
branch.  So I think we don't need to wait for that anymore:

Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

