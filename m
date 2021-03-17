Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316CFC4332D
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Mar 2021 12:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFFB964F67
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Mar 2021 12:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhCQMwP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Mar 2021 08:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229460AbhCQMvw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Mar 2021 08:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615985512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JFCqVw/Bnh39xL+6qMrjBQZdq8GZAVsRMv39uYKymdc=;
        b=cWr4/8ymKZq/pxn+WTD0fpw6xTYs5+/TLfnu/i7l6th8U9HVOBC6x90PdqNuVX/v2UmOUk
        ZZMAD2YyBVkUrOfrLcfl0YBSbS/VzI5sdXUZlJAZa+CdBXSXdJNu3+Humvo5eRU+ppOKtr
        BdAT/9RTK0sRhfy1gi+CqC4lCQLa3fk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-jBghUeHLN62u-DQEgxmrrA-1; Wed, 17 Mar 2021 08:51:50 -0400
X-MC-Unique: jBghUeHLN62u-DQEgxmrrA-1
Received: by mail-qt1-f200.google.com with SMTP id a16so9299065qtw.1
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Mar 2021 05:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JFCqVw/Bnh39xL+6qMrjBQZdq8GZAVsRMv39uYKymdc=;
        b=euyCE5rXx6insGKdoLTCnOJ61Mg/04ZsV3Wzq11MWhNqCyV+1t0I4xJmxwDWtrqKFl
         kDD8vxvIYO7xn9nhKuCyCf7UOZJ55k+Bk9/BuY3fz1c/tsLkIR7pHKU6RADACYrXisTx
         +pHHlkqUjvQaekRTcHGaPYPv2jDzQSJrQMN5lhrinXZps1MocZWoSdgO0kGihqUEwBWK
         kd0jsm65Pah/kqU4NFceLl21xDgPIFOzh4pCrZEH2aGmku+3RZCKjaCNgOFOOcZ7Q2nb
         sSZSxCIksSNMeS2hX8xMlW4O3ucsOqCQOvBU0+FPm4E+oLBOcO4x0vx9kHsuwUNUik6n
         HVTw==
X-Gm-Message-State: AOAM532vcXrOCIjFOZZIGHne6NRKGdZyQ+4pDPyiQD6BWWuUEC/qdJ6d
        eoBVFArwfKCpphT3BB+KMwa1pKQH+juXjMo5mutAx1MtjlZeqc5FLUCjQAaZAKKa5va1Pu+zvsD
        DvOqnAoEbvybFqdtt7FxLabSYrfE=
X-Received: by 2002:ac8:44aa:: with SMTP id a10mr4014979qto.146.1615985509644;
        Wed, 17 Mar 2021 05:51:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjqRTvoCsN1i304riA8x6h0hmBBZlzasVHhUSH0QjVKjWIAllIZFcNmv7xRt0EBYP5OhAIZA==
X-Received: by 2002:ac8:44aa:: with SMTP id a10mr4014963qto.146.1615985509377;
        Wed, 17 Mar 2021 05:51:49 -0700 (PDT)
Received: from xz-x1 ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id q65sm17169682qkb.51.2021.03.17.05.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 05:51:48 -0700 (PDT)
Date:   Wed, 17 Mar 2021 08:51:47 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Wagner <wagi@monom.org>
Cc:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] rt-tests: Drop use_current_cpuset() check
Message-ID: <20210317125147.GH395976@xz-x1>
References: <20210315193707.359702-1-peterx@redhat.com>
 <20210316081826.bthxqja6shbcp36j@beryllium.lan>
 <20210316200705.GC395976@xz-x1>
 <20210317074903.5lskayjwylnvuhks@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210317074903.5lskayjwylnvuhks@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi, Daniel,

On Wed, Mar 17, 2021 at 08:49:03AM +0100, Daniel Wagner wrote:
> On Tue, Mar 16, 2021 at 04:07:05PM -0400, Peter Xu wrote:
> > I think what I'm missing is why we had such a restriction.  Quotting from the
> > commit ID:
> 
> IIRC, the current behavior allows the process to be placed into a cgroup
> with a subset of CPUs and you just can do 'cyclictest -a -t'. Process
> should not ignore external configuration. That's my whole point here.

In that case again I think a sane solution is not to check the cpu list in
every single tool we use, because even if we do that for all tools in rt-teets
repo, we can't guarantee to have this check for the rest tools to not ignore
this restriction.

A simple example is: what if the user specified "taskset -c $CPU cyclictest -a
$CPU -t 1 ..." where $CPU is not in the allowed list of current bash?  As long
as the taskset would work the so-called "environment" will be changed before
even loading cyclictest.

If you see that's the point I said we should fail at the same check point of
sched_setaffinity() rather than checking it explicitly in the tool, because
if we want a real-world restriction that's the only place I think it's possible..

But I'm not a cgroup/container guy, please correct me if I understood.

-- 
Peter Xu

