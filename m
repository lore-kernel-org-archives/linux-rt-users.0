Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06B2C2B9F4
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Jun 2021 12:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D054A610CA
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Jun 2021 12:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhFQMqK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 17 Jun 2021 08:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230473AbhFQMqK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Jun 2021 08:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623933842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NL/98dZYymNwg+M8MlKGX4XT1OCEx1r/iE6aOyRCbk0=;
        b=LsfnzLJ3Ywr8wyP4L2xU1WyFX5ptyzLuGotyXUobRzXi9jzu/LTmDB33dQEBvkOHp6WPLf
        gC2btg26XiNIJPDVb+wEo2xV7doq012ndl+bPzPGFa3stckkZgz8Lg0kCDzNB07FOXqFIi
        OFGi5d0gIZKZkMJSBNywaCxNSKFrTUA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-noTXVa9DM4OH_cw4bHD9hw-1; Thu, 17 Jun 2021 08:44:01 -0400
X-MC-Unique: noTXVa9DM4OH_cw4bHD9hw-1
Received: by mail-qk1-f198.google.com with SMTP id r190-20020a375dc70000b02903acea04c19fso1980143qkb.8
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Jun 2021 05:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=NL/98dZYymNwg+M8MlKGX4XT1OCEx1r/iE6aOyRCbk0=;
        b=OJjW0180vBv3P+Z3mNWwwiNOWjEwEbKunP/BSjd9pm9+sd6IzP+RLdh+7fcNJ5LR5K
         Y/1uATDfnXoFfV1aqqMCI3GIrqgtbGExeIRBU62dJ2dhdnAs7D3+PQT7jBPyZQcVXF3u
         k4Cbu0LA8spVnS97exRVgeF9UlnidfnvxLZZdNE63ztPLFnY2OCbxQ+Pom38z8Lj20gg
         WwMAhonra1e6oaN0195/ayGgdtGomQqOf36N9DXoFDBdow7pOPM1l2HrqnXTFkGFMskV
         S7oHjwUtPH6Xez26UxwzWyNUTv/UreoAPtmqVztzSgFASE5HVVvdeAdEIYv3VEYi+vaP
         ce9Q==
X-Gm-Message-State: AOAM530lrpxu6xfkT1EFNRbofIZYD3ZwRyYCCE9WNzRhStttWNqm2siz
        aUqrZRggUfYJf4iRxB+ZETEbYZaXizxgNPWXGMv3shU9HxtWPDqp95SFeMsdLtjzZxHnq1lITyl
        8rqWM+eyomSLQx8JRiKTcDX1QX/w=
X-Received: by 2002:a05:620a:10ab:: with SMTP id h11mr3573999qkk.89.1623933840710;
        Thu, 17 Jun 2021 05:44:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym/D2REQzbb+tHLGScF9oqWrORUOTn4s3i5ugF+10QlTZsPenRM+h/o4pwUrPHOiSwR4wevQ==
X-Received: by 2002:a05:620a:10ab:: with SMTP id h11mr3573982qkk.89.1623933840532;
        Thu, 17 Jun 2021 05:44:00 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-18.dsl.bell.ca. [184.147.142.18])
        by smtp.gmail.com with ESMTPSA id 6sm1623644qky.27.2021.06.17.05.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 05:44:00 -0700 (PDT)
Date:   Thu, 17 Jun 2021 08:43:11 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Jonathan Schwender <schwenderjonathan@gmail.com>
Subject: Re: [PATCH 3/3] rt-tests: cyclictest: Add entry for mainaffinity in
 the manpage
In-Reply-To: <20210617064047.glshmt3r6phsrfjm@beryllium.lan>
Message-ID: <dee6e0-846c-fd40-f78a-ed3b196dac1c@redhat.com>
References: <20210616231800.19228-1-jkacur@redhat.com> <20210616231800.19228-3-jkacur@redhat.com> <20210617064047.glshmt3r6phsrfjm@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 17 Jun 2021, Daniel Wagner wrote:

> Hi John,
> 
> On Wed, Jun 16, 2021 at 07:18:00PM -0400, John Kacur wrote:
> > Add an entry for mainaffinity in the manpage.
> > Tweek the output in cyclictest for mainaffinity as well.
> > 
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> > ---
> >  src/cyclictest/cyclictest.8 | 3 +++
> >  src/cyclictest/cyclictest.c | 3 ++-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> > index 4fe42e502535..abc56e8e4970 100644
> > --- a/src/cyclictest/cyclictest.8
> > +++ b/src/cyclictest/cyclictest.8
> > @@ -94,6 +94,9 @@ Set the number of loops. The default is 0 (endless). This option is useful for a
> >  .B \-\-laptop
> >  Save battery when running cyclictest. This will give you poorer realtime results, but will not drain your battery so quickly.
> >  .TP
> > +.B \-\-mainaffinity=CPUSET
> > +Run the main thread on CPU #N. This only affects the main thread and not the measurement threads
> 
> Nitpick: the .RI section is missing the --mainaffinity.

The Synopsis section doesn't have to be exhaustive, it just has to show 
typical usage. However, that section is crufty and could use some love.
For example, while we have the long version --policy, the short version -y
no longer exists but is mentioned there. Have a go at it if you're bored.

John

> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> 

