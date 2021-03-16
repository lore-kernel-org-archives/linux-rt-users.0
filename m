Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9177C433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Mar 2021 20:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8712764F6D
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Mar 2021 20:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbhCPUHq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Mar 2021 16:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240788AbhCPUHL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Mar 2021 16:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615925230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4jHuP/iiJcKMO2in1ixuOU+SQ+wyAFAXhEhmYyiZ2Ak=;
        b=PylTl15KAlmIuje7zj2dLsjH7UazVjeSpf9D/Ig2j4FLepgmUGswXVhCGXsOGJJbMHvxJB
        B5iz8AnOCAFUMw7ZrKSLGUujIMmtD3b4ndZAGITNsh5pIm5zyq93pmyL54AQYOdvfUkX0H
        dSNm0mxyiioE6E1OZok1GGHZUziYxVg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-Mn_-g7ecOsmdCQa4nOteWw-1; Tue, 16 Mar 2021 16:07:08 -0400
X-MC-Unique: Mn_-g7ecOsmdCQa4nOteWw-1
Received: by mail-qk1-f197.google.com with SMTP id 130so27657276qkm.0
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Mar 2021 13:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4jHuP/iiJcKMO2in1ixuOU+SQ+wyAFAXhEhmYyiZ2Ak=;
        b=pVycWyOFSWvZ5y05Xj0UOz4EnqlzRuIIG3GPvIY0zpAED3K9Pbf5ZiPRPl3fQW391J
         QDzPxYEEUlOYgLWx4qxSOfOryQvHOBMQI1CA1NnbTgEksy4xwWaus4M8apfY2kv9kcJ3
         A0sCIVGyGo2peG7XsmdGRiG1T3VfqIAMA+cf7/2Wdu5V+WMkNEm6r4GPJz4jbdBW3RhO
         YE/MulBhafiOWJN/kci7G7bL+ecvcbvZocc9McMGQKoYHZBesj5fZZ3AHO9dvUGLnskA
         yur5SVk90+F2vsV0BYhJksuTBhs9QqaUvDSZZWqqthwl6DeaXN0aHiYydcYbsA99pOaw
         tFZw==
X-Gm-Message-State: AOAM532SNVMUu9YF0BXPqQ5HbkWnCCk8q3UDeZ1yMoFWfI2BPAFOTvVA
        CTB265aXJWmuwGkh7bU4GPGk3VLfJ1Aoo2dUaIrqAfWUtDDUHWVXMM+Pc0whBNOHrxYdm8KKIfC
        W0QgS++TRKsKZFogCKsiYFkPCVro=
X-Received: by 2002:ad4:55ef:: with SMTP id bu15mr1264607qvb.46.1615925227930;
        Tue, 16 Mar 2021 13:07:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZ5aNoHRla2MYPY4YPsQxDPsmmeCTCpsGD3YKS6cfJ1sT9uVCwgDdJDPVGY/vGj6aNsKVC5A==
X-Received: by 2002:ad4:55ef:: with SMTP id bu15mr1264576qvb.46.1615925227658;
        Tue, 16 Mar 2021 13:07:07 -0700 (PDT)
Received: from xz-x1 ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id y1sm15495077qkf.55.2021.03.16.13.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 13:07:07 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:07:05 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Wagner <wagi@monom.org>
Cc:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] rt-tests: Drop use_current_cpuset() check
Message-ID: <20210316200705.GC395976@xz-x1>
References: <20210315193707.359702-1-peterx@redhat.com>
 <20210316081826.bthxqja6shbcp36j@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210316081826.bthxqja6shbcp36j@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Mar 16, 2021 at 09:18:26AM +0100, Daniel Wagner wrote:
> Hi Peter,

Daniel,

> 
> On Mon, Mar 15, 2021 at 03:37:07PM -0400, Peter Xu wrote:
> > CPU list should allow to be any list rather than only the cores that are
> > allowed to schedule for the current process.
> 
> See commit aaa57168dfd3 ("rt-tests: cyclictest: Only run on runtime
> affinity and user supplied affinity")

(Thanks for the commit ID)

> 
> > Before this patch, cyclictest will fail with below condition:
> > 
> > $ taskset -pc $$
> > pid 2316's current affinity list: 0,2,4,6,8
> > $ sudo cyclictest -m -N -p 1 -a 1,3,5,7 -t 4
> > WARN: Couldn't setaffinity in main thread: Invalid argument
> > 
> > After this patch, it'll be allowed to run.
> 
> As John writes in the commit above message I think cyclictest should
> honor to the runtime settings. The warning above could be extended and
> telling you what's the problem is.
> 
> Your commit message should contain the argument why it's better not to
> check the environment settings. So the question is what is the least
> surprise for the user?

I think what I'm missing is why we had such a restriction.  Quotting from the
commit ID:

    Currently if the user passes the affinity to cyclictest, threads are run
    there even if they should be excluded according to the affinity of the
    runtime environment.

So I'm not sure I understand the word "runtime environment".

If it's defined as "the set of cores that this process is allowed to run", I
don't understand why it's not allowed to schedule things outside of this set of
cores, especially if sched_setaffinity() syscall would succeed.  IOW, I'm
afraid we got the idea slightly mixed up on "cores allowed to schedule this
process" with "cores allowed to be set as schedule target by this process", and
IMHO we should simply rely on sched_setaffinity() syscall to decide whether the
affinity setting is legal or not as a single checkpoint.

John and I had some discussion offlist about this last time on oslat, it should
be the same thing here I think. But I'd like John to help confirm too since I
could be missing something.

Thanks,

-- 
Peter Xu

