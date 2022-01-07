Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E32C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Jan 2022 02:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbiAGCT4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Jan 2022 21:19:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345318AbiAGCT4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Jan 2022 21:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641521995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xBY87WLDVEegvIdvOyVB6C7vFrMWm23N9YQpD+toFwo=;
        b=Tu2BFA0/VtNjJ1L+k0s4QzUNGO+gRwPAcFgHifdbtowqoh8Kk2Tb/9JUyVHvVGY2O+DbfK
        jNNTjgFcmax6hd8Z99LhtWXPFbN64pndhMpJ3y8ibpMp4undshdMv7Xf2yoOQ31FB+mCfs
        aMN1B26pDrbOVKjBCBQurt+nwXxGJqk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-4vO9anlAM1Krjc6xZmZ1sw-1; Thu, 06 Jan 2022 21:19:54 -0500
X-MC-Unique: 4vO9anlAM1Krjc6xZmZ1sw-1
Received: by mail-lf1-f70.google.com with SMTP id u4-20020a056512128400b0042abc4f4f9aso1277768lfs.15
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Jan 2022 18:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xBY87WLDVEegvIdvOyVB6C7vFrMWm23N9YQpD+toFwo=;
        b=WQOO/STSvktmkx8OVK/FL4m8LEoEB32hxdMb8WZsvyHzRsloEhVLgeqP9k9oGnu0Y0
         ppybAi7ZtbyXiFYvaFlf9dsD3WLjK6mcuPHTHoFSCJ+JSuwC61LEXbiFpyAK1f8XZxER
         eqwyJxraZNNET9DxZ0qBU0qdbUXo6fgYsqQweO3UYnpqDTymE12ZPTS0c7o4nQuF10XQ
         CmxCgMv9nP/MOHs0dJSFE1xM4mKmCd+R+dr1dLQhGtlC/2h4E9bGnP0dWGpV2zDeWH0R
         ngUjTsG4EwSS0kcD3z2FTlW+B3B8FlQIoXgLctcI54m+bVMQdVZZIbY7KgxcaL8KiJWC
         +N3Q==
X-Gm-Message-State: AOAM531KVjpPptPLSMKOU8ElsEkjJUskg8Y40F15qpSpvtYDZo13F+8Y
        7dm6LfsZ/EzLijLkNatE9YVtkCai4uxD91OKOWCxiJvFwIPfQ4gkHhDWfH6rgNu8jN5NLnM54Kh
        GPeoARhL0P7PUzfFlLatz9LuOjOQiJcOOZjl1bNbmWS8=
X-Received: by 2002:a05:6512:3223:: with SMTP id f3mr54704325lfe.593.1641521991119;
        Thu, 06 Jan 2022 18:19:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7HZbV8X5mv5B+nTa1dGS/8SgEvdTMV1H2/lgG8F/UivDR4QpGRcY60eSLFrRw60Fvd2p0jzS76len2MnZaPE=
X-Received: by 2002:a05:6512:3223:: with SMTP id f3mr54704306lfe.593.1641521990882;
 Thu, 06 Jan 2022 18:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20220107021502.1121597-1-lgoncalv@redhat.com>
In-Reply-To: <20220107021502.1121597-1-lgoncalv@redhat.com>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Thu, 6 Jan 2022 23:19:39 -0300
Message-ID: <CAD8J--_3bw6gw=RDqyZ+OcB97=Y0PzwrONWdujy09QaUe3FOxQ@mail.gmail.com>
Subject: Re: [PATCH RT 0/3] Linux v5.10.90-rt61-rc1
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jan 6, 2022 at 11:15 PM Luis Claudio R. Goncalves
<lgoncalv@redhat.com> wrote:
>
> Dear RT Folks,
>
> This is the RT stable review cycle of patch 5.10.90-rt61-rc1.
>
> Please scream at me if I messed something up. Please test the patches
> too.
>
> The -rc release will be uploaded to kernel.org and will be deleted
> when the final release is out. This is just a review release (or
> release candidate).
>
> The pre-releases will not be pushed to the git repository, only the
> final release is.
>
> If all goes well, this patch will be converted to the next main
> release on 2022-01-13.
>
> Known problem:
>
>   There is a printk build warning that would be fixed by commit 43a17111c2553
>   ("printk: wake up klogd in vprintk_emit"), already present in v4.19-rt. I am
>   trying to decide whether it is justifiable to suggest the backport of this
>   commit to 4.14-stable or if I should write a simple rt-only fix. Comments are
>   welcome.

Please disregard the note above. That was an error in my template message.
There are no known errors in this -rc1 release.

Sorry for any inconvenience.

> To build 5.10.90-rt61-rc1 directly, the following patches should be applied:
>
>   https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz
>
>   https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.90.xz
>
>   https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.90-rt61-rc1.patch.xz
>
>
> You can also build from 5.10.90-rt60 by applying the incremental patch:
>
>   https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.90-rt60-rt61-rc1.patch.xz
>
> Enjoy,
>
> -- Luis
>
>
>
> Luis Claudio R. Goncalves (1):
>   Linux 5.10.90-rt61-rc1
>
> Sebastian Andrzej Siewior (1):
>   stop_machine: Remove this_cpu_ptr() from print_stop_info().
>
> Thomas Gleixner (1):
>   eventfd: Make signal recursion protection a task bit
>
>  fs/aio.c                |  2 +-
>  fs/eventfd.c            | 12 +++++-------
>  include/linux/eventfd.h | 11 +++++------
>  include/linux/sched.h   |  4 ++++
>  kernel/stop_machine.c   |  6 +++++-
>  localversion-rt         |  2 +-
>  6 files changed, 21 insertions(+), 16 deletions(-)
>
> --
> 2.33.1
>

