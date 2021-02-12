Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751C7C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Feb 2021 18:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A7264E99
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Feb 2021 18:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBLSPE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Feb 2021 13:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBLSPC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Feb 2021 13:15:02 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8D7C061756
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Feb 2021 10:14:22 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id t62so441824qke.7
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Feb 2021 10:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=PXdWdqPLrbibHaNQ16vA9rwxLqAdzeMnWSpa3RRg9Io=;
        b=lrirbcL/zHS6mm7jOXh05lw8AddVOxCVwN/UXGsXRP1Yv53xFIIRW3d1PxOsr9Adat
         zuoOeo57v/0p+dGaimLjtqe4CxL0r5A7Hon6v3ORVAZAia7yxGwppbjzEdqmDMjXqJHg
         j2JOv05sZyvxvGSaAIEOxHBD6bWv9oET8lBQuVfTG3gmt1QiO7zqgMlH/TGEaTMFnDTm
         z8t0Ct1tWSBA1m6jxl+q/sAU2BRxe8nVvAaWBnknDGFlieUZoBzudPc48qQmfe8jyohH
         BMBzAhOEuWEKmQw6bn+0eECQtal49tUW+wJ+LGVoyH0s9njeB0T0JV3QKpbjUrEH5lT9
         +nvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=PXdWdqPLrbibHaNQ16vA9rwxLqAdzeMnWSpa3RRg9Io=;
        b=iJqXkj+81zZdTEuHdUy15Ru4i7EhPYUcx1ODHNWXPqEa8dG3L6Kzdt6QQbYLJJp8nz
         /w5PVIM8GtKXxAQb4VaaxowlfWXGwzNCmRwv2mWuL3OQgXc1/j3Qmlh8uk93u6kWaKYT
         oBjigkvlZaykBzVDz24qJvMCiUfI95WjPmpzUmQCu8HwOt57S1BVDGBL3lYPcZggRD6m
         MEwhsfH+ThbR3UVqfgzFsv5g5tLX+t30uxrxT+oJYUoIXfoqxmSFQQVhLK++Mg5xFBqU
         UYJsN0tcQ6LK2g6YliMeC4vRISo2iun0uP4kMwZveDfpLUhemxMWFt+byFgwKjMJmW2d
         EXjA==
X-Gm-Message-State: AOAM530HkjRcMhn9DBLi5AZuMjH0WQgHFLp0W9yNcWIOoqyMFbO3ZK73
        OxnTH05xRfwQ1otUTkk1GQw=
X-Google-Smtp-Source: ABdhPJzM7220IJafWGN/nZGIWLFS71ZaYpOWV9zqOuYIe4H2soTp4mCHRRFEXxNYV6NC1pek71cz4A==
X-Received: by 2002:a37:4c48:: with SMTP id z69mr3942249qka.373.1613153662142;
        Fri, 12 Feb 2021 10:14:22 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id 16sm5929518qtp.38.2021.02.12.10.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 10:14:21 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 12 Feb 2021 13:14:14 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>
Subject: Re: [PATCH] rt-tests: oslat: Allocate memory for cpu_set
In-Reply-To: <20210212173302.qpdjoqbf2yklhh3t@beryllium.lan>
Message-ID: <dab4f43f-a6d8-2439-82d5-b25c49586fca@redhat.com>
References: <20210212172913.10843-1-jkacur@redhat.com> <20210212173302.qpdjoqbf2yklhh3t@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 12 Feb 2021, Daniel Wagner wrote:

> On Fri, Feb 12, 2021 at 12:29:13PM -0500, John Kacur wrote:
> > - cpu_set is a pointer to a bitmask struct
> > Memory needs to be allocated for the struct, so call
> > numa_allocate_cpumask()
> > 
> > - use rt-tests fatal to exit on error conditions
> > 
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> 

Thanks. I added your Reviewed-by and pushed the three oslat fixes
