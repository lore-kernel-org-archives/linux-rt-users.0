Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05811C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 16:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA5361157
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 16:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348635AbhIHQcE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 12:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234225AbhIHQcD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Sep 2021 12:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631118655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FbnjlYMaSLM+PKIhpQ+SMRv7UvBlvYIiKt9yihreJig=;
        b=eyD4hyDBT7VABOzaJf7ExkxfWGFjcjv4CLcIuH92NKEwqkjJZu+Qy85jbne1b7QqImdx4w
        EkMLZ9JR7TLkYLtuK15MYzhAYYac3s18LwEngzKYFCVvPAeh17n6iIynRtE05vDRSAiEz7
        /DOCgfj+d4Qq4203++FHyQmgPIefIFs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-aLPNWCrRMhWC-W84R_00IA-1; Wed, 08 Sep 2021 12:30:54 -0400
X-MC-Unique: aLPNWCrRMhWC-W84R_00IA-1
Received: by mail-wm1-f70.google.com with SMTP id m22-20020a7bcb96000000b002f7b840d9dcso1085173wmi.1
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Sep 2021 09:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FbnjlYMaSLM+PKIhpQ+SMRv7UvBlvYIiKt9yihreJig=;
        b=PA+qM562Qkmlq3c/O9GV6i501KOqHHQmEsPSeq7yAPcwJtb6UrJXWAOY7VOebwqD1/
         1wQQeXZDvpD5hEXM+D4lJu+CLsdIn1fhKy9Vp442Mpg99LahK8N0OGxDT+IZg25joU/k
         jqTeMEIPixwDEjW5mwrmbdMz09DBX5nE4ebyzcXQEckCjOnidjoNTT2sYriuTIHWvmJS
         VJF7ISJH85RLjTgTZPRhFdhz+RHS8rzWorkUuZ5QS9DAqz0553tBVjImPKoTC4gtThmD
         o5nUUGsUIc+KK7HirEeTofrnGVTGdU7FEgbBjEhXPHvYhLq37VtVtc4EziJbiS96HhKN
         fKfw==
X-Gm-Message-State: AOAM530tDY3yTm2YnhyxNgNc5w/SyRs2lrAqoISTz21X430c9WKMrb9H
        GM+8igm9M3LIEqvh92TIoBHSYatTD3o8FH29bSP5OPKY051PUvGGFAiQ6NnMGktYTdVDS06u7VL
        FEX7HOzdu8hQyMluyt12WHIU8GTg=
X-Received: by 2002:adf:e645:: with SMTP id b5mr5187547wrn.34.1631118653060;
        Wed, 08 Sep 2021 09:30:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwy8QCrNh8NxNeXTDnImCvWOB9Ar+LkhIAa3cnViwKLyqrbsS2v/tgTS19pjhKBHuuBZg6N3Q==
X-Received: by 2002:adf:e645:: with SMTP id b5mr5187522wrn.34.1631118652813;
        Wed, 08 Sep 2021 09:30:52 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3811:7600:8004:a383:c7c9:7f11? ([2a0c:5a80:3811:7600:8004:a383:c7c9:7f11])
        by smtp.gmail.com with ESMTPSA id x18sm2939585wmj.36.2021.09.08.09.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 09:30:52 -0700 (PDT)
Message-ID: <dc800f41878a9240cc9b9629ed1a4c1551514fac.camel@redhat.com>
Subject: Re: [PATCH 1/3] oslat: rename cpu_mhz/cpu_hz to timer_mhz/cpu_hz
From:   nsaenzju@redhat.com
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Date:   Wed, 08 Sep 2021 18:30:50 +0200
In-Reply-To: <YTjLaZez4azBeYLI@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
         <YTjLaZez4azBeYLI@t490s>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Peter, thanks for having a look at this! And sorry in advance for the long
documentation dump.

On Wed, 2021-09-08 at 10:40 -0400, Peter Xu wrote:
> Hello, Nicolas,
> 
> On Wed, Sep 08, 2021 at 12:02:07PM +0200, Nicolas Saenz Julienne wrote:
> > 'cpu_mhz' in oslat actually represents the frequency at which the high
> > frequency timer we measure with ticks. There is no need for it to match
> > the CPU frequency, nor will do on all supported architectures. So rename
> > it to 'timer_mhz' in order to better match reality.
> 
> But right now "cpu_mhz" is indeed the cpu frequency per mhz, isn't it?  As I
> believe that's how "time stamp counter" defined on x86. :)

Sadly I don't think this is really the case. In some cases TSC might match
CPU's base frequency, but it depends on the processor family and other
factors[1]. Also, the same applies for PPC64[2].

My reading is that, in general, we are only safe to assume we're getting a
constant monotonically increasing timer unrelated from CPU's actual frequency.

> I don't know what's the corresponding register for aarch64 to read the
> processor clock cycles out, I did a quick google and it tells me PMCCNTR, but
> I've no solid idea.  Or do you mean for some reason we can't read that info out
> from aarch64?

Sadly PMCCNTR isn't available at Exception Level 0 (user-space) and AFAIU we're
stuck with CNTVCT_EL0.

Regards,
Nicolas

[1] Intel TRM Vol 3B, 17.17 Time Stamp Counter

Processor families increment the time-stamp counter differently:

• For Pentium M processors (family [06H], models [09H, 0DH]); for Pentium 4
  processors, Intel Xeon processors (family [0FH], models [00H, 01H, or 02H]);
  and for P6 family processors: the time-stamp counter increments with every
  internal processor clock cycle. The internal processor clock cycle is
  determined by the current core-clock to bus-clock ratio. Intel® SpeedStep®
  technology transitions may also impact the processor clock.

• For Pentium 4 processors, Intel Xeon processors (family [0FH], models [03H
  and higher]); for Intel Core Solo and Intel Core Duo processors (family [06H],
  model [0EH]); for the Intel Xeon processor 5100 series and Intel Core 2 Duo
  processors (family [06H], model [0FH]); for Intel Core 2 and Intel Xeon
  processors (family [06H], DisplayModel [17H]); for Intel Atom processors
  (family [06H], DisplayModel [1CH]): the time-stamp counter increments at a
  constant rate. That rate may be set by the maximum core-clock to bus-clock
  ratio of the processor or may be set by the maximum resolved frequency at which
  the processor is booted. The maximum resolved frequency may differ from the
  processor base frequency, see Section 18.7.2 for more detail. On certain
  processors, the TSC frequency may not be the same as the frequency in the brand
  string. The specific processor configuration determines the behavior. Constant
  TSC behavior ensures that the duration of each clock tick is uniform and
  supports the use of the TSC as a wall clock timer even if the processor core
  changes frequency. This is the architectural behavior moving forward.

The specific processor configuration determines the behavior. Constant TSC
behavior ensures that the duration of each clock tick is uniform and supports
the use of the TSC as a wall clock timer even if the processor core changes
frequency. This is the architectural behavior moving forward.

[2] From __ppc_get_timebase() manpages: The Time Base Register is a 64-bit
register provided by Power Architecture processors. It stores a monotonically
incremented value that is updated at a system-dependent frequency that may be
different from the processor frequency.

Note that glibc's __ppc_get_timebase() and oslat's ppc frc() implementations
are the same:
https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/powerpc/sys/platform/ppc.h;h=8b0a66de1b93a56e3edf56c31a0c1505d7a8fc08;hb=HEAD#l27

