Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3D2C00140
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Aug 2022 14:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbiHEOy3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 10:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbiHEOy1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Aug 2022 10:54:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB5035C34F
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Aug 2022 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659711266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fTeUecmNCKmPASvlUogXElPOq0FazTeDAd7WV+Z0xK8=;
        b=M7vROawTJBRrE5QJHRQ4s2Rmo3NACGmEdBZeVAygdBGars2y5jGlTjBoIiOy6i0L3QxKZ0
        S8vZdpgGGH2AiI2TpRP7IikJIy0WRY0EwaUbsju6294f+IUezWs9uwQP7MjNGQJvAks9Qx
        ELbdj5hsj3CPdO6330H3U3OtankqI6c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-8jB9hdG-NH-kv0DohFE3dQ-1; Fri, 05 Aug 2022 10:54:24 -0400
X-MC-Unique: 8jB9hdG-NH-kv0DohFE3dQ-1
Received: by mail-pj1-f70.google.com with SMTP id o18-20020a17090aac1200b001f3252af009so4558591pjq.7
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Aug 2022 07:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fTeUecmNCKmPASvlUogXElPOq0FazTeDAd7WV+Z0xK8=;
        b=zZiFwXK4/acLTYKIO/0a/qUOrGc48ue0hCSuiGo2zwdRHFAxiAZs6l9IaKq5aOwsI7
         P381FkcIFwVa6JEUBMpIFeLWxQlFxA4y9P6n9wo7TEBcEjQQEuMf9y1qXzIuWbGmNNRO
         AUm4MfbsJbUwb9PuchRsKz3jRsszPHwzCDdhjgNz3x/aZOgTW8qsoc7iQX1yJQcaGJS0
         wxO5yoJbZC1R794G7DnF9fWOMfUlMtwTp/XwGJZjIownv7aL3q7coMaBeNnCTtmEzGRr
         a53uZK6l5Ho/1DGeLFwEInkToxO1zR8gGgYqegW1p9vEuWU7Tm8bP8NYx528Pm6EUyYH
         dXuA==
X-Gm-Message-State: ACgBeo0XtL8EAJ73BGLW/zNv9lmoW4BNJ0FOYdVr/4oMQSFGJOn9trgJ
        o1yD7TB/236AJFNQc5f5VmqM4x0hEjCFoLjhl3rD08Qw47Zn82y5CB1k4PhJMRukCpx4kdK/RIm
        UT99PP3p8gNY4S8ZDiZVa0v3g1OutGNw1zDiAwYTPXzo=
X-Received: by 2002:a17:902:f608:b0:16d:c44:137 with SMTP id n8-20020a170902f60800b0016d0c440137mr7163573plg.173.1659711263793;
        Fri, 05 Aug 2022 07:54:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7rG9vjqslr8jyfcstNh60xA1YYaydAWQVoaTyk0XyP/WJzzN2YFLPhoGYGkFRx3QT2LsocvZ7R94OVUg89c20=
X-Received: by 2002:a17:902:f608:b0:16d:c44:137 with SMTP id
 n8-20020a170902f60800b0016d0c440137mr7163559plg.173.1659711263466; Fri, 05
 Aug 2022 07:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220805134239.1257029-1-vschneid@redhat.com> <xhsmha68ida4r.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmha68ida4r.mognet@vschneid.remote.csb>
From:   Clark Williams <williams@redhat.com>
Date:   Fri, 5 Aug 2022 14:54:12 +0000
Message-ID: <CAMLffL_PEphdnJrsUvCkEzbEFNOtBcZs3YYNEOEDpR0sg_x-qw@mail.gmail.com>
Subject: Re: [PATCH] rteval: Fix loads cpulist restriction
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, jkacur@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I think the recent slew of commit is John trying to clean up the mess
that David and I made, by removing duplicate functions.

I'm not against using a set instead of a list in the cpulist
structure, although at that point we might want to call it a cpuset
:).

On Fri, Aug 5, 2022 at 2:43 PM Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 05/08/22 14:42, Valentin Schneider wrote:
> > A recent batch of commits, one of them being:
> >
> >   39115f0a826d ("rteval: Make use of systopology instead of misc in hackbench")
> >
> > has made the loads modules use CpuList.expand_cpulist() (which produces a
> > list(int)) instead of misc.expand_cpulist() (which produces a list(str)).
> > However, the bits handling restricting CPU affinity based on a user
> > argument still expects to handle a list(str), which results in:
> >
> >   [DEBUG] [kcompile] node 0 has no available cpus, removing
> >   [...]
> >   [DEBUG] [hackbench] node 0 has no available cpus, removing
> >
>
> This is lacking some context, so here's more:
>
> This was triggered on an arm64 system (Ampere eMAG), any sort of affinity
> restriction suffices, e.g.
>
>  $ rteval -O -D -v --loads-cpulist=2-3
>
> I can reproduce that on my x86 laptop:
>
>   $ sudo ./rteval-cmd -O -D -v --loads-cpulist=2-3
>   [DEBUG] [kcompile] systopology: 1 node system (8 cores per node)
>   [DEBUG] [kcompile] node 0 has no available cpus, removing
>   [DEBUG] [kcompile] node 0 has no available cpus, removing
>   [DEBUG] [hackbench] node 0 has no available cpus, removing
>

