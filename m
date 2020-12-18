Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127ABC3526B
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E014923B70
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgLRQDa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgLRQDa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 11:03:30 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A779C0617B0
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Dec 2020 08:02:50 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id j18so1104845qvu.3
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Dec 2020 08:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=QtQnZiyDB2NhYyrnAbFNENsmzegDOcnM4GT5PzEnRfg=;
        b=GYdg1XDAgw3qbgDJhOhT8UgB+E3zX8MStZnLQAqrZ13t3yADbio8cXSs5I0Z04BFar
         nY3C1Ye5X4Z+PSIfFenOkzmZfizVehqlEgc+C4OtO9zU6SFIj2LGYaUca4hapsKFxSau
         ym5zcoK8ml6FEEhdGnr0BKGjeEBiTUmhWRUKCnima38/XvWaOAcoTLyUbN5GviqT97Sc
         Xx9hR1VsY2YpVG1y5eR+QbnNK2wwHa2cum+u3PC5reN8wdmpadvSry7wTYTny75v7x9e
         4GggXM6wQB2UoUyK0L4H+vjbStemNWSseVraxLnRCAFdzrobTmYHEI1S++bbG0i0M1D3
         YNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=QtQnZiyDB2NhYyrnAbFNENsmzegDOcnM4GT5PzEnRfg=;
        b=BsoUVel4hufMMmI5XxalC8/uEe28nS7Y0zMcNPvo2xur3AW86Q01n0JnO9Jj6ShQmJ
         mygo6v5UAo6BkII3/dVv28FJFi1hq6SQoHwA7Y/uJlVgNx4o6Y6Dr2L+pOZ7WOQ/ugBN
         FM7yQTj+H5RXES5ExTxezZUTpoNbSXKq2X2EHw0gyaCMIyDcMGoiO/c63yLUezVLy3cJ
         KN6ivEtjs6SAISMl6k42inwBtcT0JoJjF2SMc7YpjBIxEUFACQqKJAznFQR1fBapWNxT
         7glOq9Auqbzp5ck+tEqzYZjL5tfLg8aSqmwA10LUiwVrJZtAgZJeYDTzBZ7fFp7LsEUX
         7USw==
X-Gm-Message-State: AOAM532X3xgVf2DF2YC31WNTXIbpe37YuwLbBSa2HmJ3RRt5Gx8uW9l4
        H9dqFYgSBrqr6noYnsDbFyQ=
X-Google-Smtp-Source: ABdhPJyU9gQOQTp0SGVqHNwZGDGJ+iL4O268v/6ZpycCAJn/e5PLBUD8TeqDQxkGJ8+IUmqa0pu63w==
X-Received: by 2002:a0c:f850:: with SMTP id g16mr5144907qvo.14.1608307367978;
        Fri, 18 Dec 2020 08:02:47 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id i68sm5947062qkc.82.2020.12.18.08.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 08:02:47 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 18 Dec 2020 11:02:45 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <wagi@monom.org>
cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 0/6] libnuma cleanups for cyclictest
In-Reply-To: <f252ba74-46de-ced1-5e77-a64ec51510ba@monom.org>
Message-ID: <6b1dcc20-9e68-e07-2892-60bcf2a0fdac@redhat.com>
References: <20201218141935.24151-1-dwagner@suse.de> <f252ba74-46de-ced1-5e77-a64ec51510ba@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 18 Dec 2020, Daniel Wagner wrote:

> On 18.12.20 15:19, Daniel Wagner wrote:
> > As we have a hard dependency on libnuma we can simplify the code in
> > cyclictest. This allows remove all the small helpers in rt_numa.h. And
> > with this we can remove the header and reduce the confusion with
> > rt-numa.h
> > 
> > While at it, I simplified the --smp vs --affinity vs --threads
> > logic. There is no need for additional variables to keep state. With
> > this we also make --affinity to behave as with the rest of
> > rt-tests. That is a plan -a will be the same as with -S. There is no
> > need for -S anymore but I think we should leave it in place for
> > backwards compatibility. I suspect, there must be a lot of muscle
> > memory out there :)
> 
> I just realized there are some programs which need the same treatment. Wait
> for v2...
> 
> 

For the future, I'm okay with things evolving in steps, as long as what 
you sent me works correctly, you can then add support to do the same kind of things
in other programs in the suite later, as long as it gets done and not 
neglected.

Since you told me to wait this time though, I will wait for v2

John
