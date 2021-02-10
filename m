Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE48C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A7264DAE
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhBJRQ3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:16:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232128AbhBJRQF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 12:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612977280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0EncYDuoApi4csinVOk/V2NMCSD1P9fXWlQVxgjQ7Jo=;
        b=AyqmOsrkmX1BRjjnnDQ4EQ8kwvPruZ5dR6g1VyiFTAK7+W/0ekj9v7UHzYlK+pTzF3/DKB
        D46Rw7N/58YOuJcrk4TQ2q3Eoj2GWsnqhYjqbvkSkxONZywE92LWPedaCd9Je/lESLecRx
        Q3fW33tHcXl6e6l9zLFQIisp/0SwFuY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-FYNozp4qMtu8DHdjILF0xw-1; Wed, 10 Feb 2021 12:14:37 -0500
X-MC-Unique: FYNozp4qMtu8DHdjILF0xw-1
Received: by mail-qv1-f71.google.com with SMTP id d8so1908253qvs.1
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 09:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0EncYDuoApi4csinVOk/V2NMCSD1P9fXWlQVxgjQ7Jo=;
        b=htVLc7AtVJuygunOCKaxdQc8MXakH1K7yS4j1+120b56zxp3+9ODBNiEDy1pUGSyuZ
         kqh5T4WDEsSoIZcFHLQczSIUM5VfqvoFwpb9AOgM7QbyK0JbBlBy9Zwt8fKnF0YXP349
         53K3Fh/eFsnwEjx5J70rfkhK+3aIRBYnhMrvNads4h4SqbtBkNvJHt0sEmJT6GfpxiuA
         tJb3KRGRpAn6yd1YY0H7N3q48CFhLfV2DjHFrb0Jb+wWoHx4H52MRgp9CN7uCfPBF09n
         bKs/C3bk/SdFq38d1a3do0GTCUnTdJ2sBfoJBwPuQoAWZZ6wknFP0Rh9GRAPP1J73r/G
         Crng==
X-Gm-Message-State: AOAM530dO7s/4+kggZtZoJKCv6MNkQSjVIcfB8MgTZLCcylNrfkWpXbz
        syPxL5sEF8Yhph2UDvXkJ3ALZXlJRGGILvCiyM8afk3vaS0s3uk8/zmUXFGvNe4+qg4hwYyD51k
        q6vG220bapvdAicJ2XG6hKB8fXzU=
X-Received: by 2002:a37:2c06:: with SMTP id s6mr4465231qkh.100.1612977277543;
        Wed, 10 Feb 2021 09:14:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuX8FhFfXCfEf7JP+yBHcR06tylX0ftNteLV5abhIrhqzhDNq7FroVmrteEHopJyjmUAbzIA==
X-Received: by 2002:a37:2c06:: with SMTP id s6mr4465211qkh.100.1612977277348;
        Wed, 10 Feb 2021 09:14:37 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id u45sm1697078qte.3.2021.02.10.09.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:14:36 -0800 (PST)
Date:   Wed, 10 Feb 2021 12:14:35 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
        Pradipta Kumar Sahoo <psahoo@redhat.com>
Subject: Re: [PATCH rt-tests 2/2] oslat: Use cpuset size as upper bound
Message-ID: <20210210171435.GN103365@xz-x1>
References: <20210210165407.9770-1-dwagner@suse.de>
 <20210210165407.9770-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210210165407.9770-3-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Feb 10, 2021 at 05:54:07PM +0100, Daniel Wagner wrote:
> To assign the threads to the correct CPU we need to use the cpuset
> size as upper bound for the loop and not the number of threads.
> 
> Fixes: 85b0763dacd9 ("oslat: Use parse_cpumask() from rt-numa.h")
> Reported-by: Peter Xu <peterx@redhat.com>

Please instead add:

Reported-by: Pradipta Kumar Sahoo <psahoo@redhat.com>

Pradipta, would you verify and see whether this patch fixes your issue?

Thanks,

-- 
Peter Xu

