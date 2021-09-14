Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E935DC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 12:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEEA660F58
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 12:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhINMwY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232911AbhINMwX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 08:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631623866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nkfQTHjUNvzgTsUIP8qLv+yfhwcslAXIVnyHLqZOeeU=;
        b=be5lBNV4xWDPGpJCSzIT976afmAqM9PfSVHjMdzB3i4zq7LXSrAKJg+LoHYZ4eEQPpyHaS
        OmvOU0tAPKn88HKDlMv6VLa621RVaWbasH34g7ZKn0Zgx1ZoDlyFl+xBuY+HiXvBRHChP1
        9sEtZhU+ntYGNy73MdgCRHw58VJ5U6c=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-heGRyIXQMH-jKOZPBGWOtg-1; Tue, 14 Sep 2021 08:51:04 -0400
X-MC-Unique: heGRyIXQMH-jKOZPBGWOtg-1
Received: by mail-io1-f71.google.com with SMTP id n8-20020a6b7708000000b005bd491bdb6aso16182773iom.5
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2021 05:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=nkfQTHjUNvzgTsUIP8qLv+yfhwcslAXIVnyHLqZOeeU=;
        b=0qNHWBCtNTVj5gQNZHwpkx3Pum41iqByPqFAil11JxcvuSsTzgnQjZ/OiV8ZUh537c
         JVwjPkydcohO7sIyengpNrIJXMSY7hMW4ZaGrAmDuz/ki6nUD/XnGt5VoUWkj/19L7EE
         DZB4ZPI5JqKdO2sqJRgACVgwp1GOi2ujCerOEbRFgUBleQyJOjqF9NW+M88Hm7nJEHXK
         VnF/melJ5hkhgbIx0M/0Xgog8fvMveVB/4HECzgTImYIh/ltd5+s9qD4LVKHUjU5/PM/
         vN67+33E72vLxWD4Jj2mfOG9jZdk2NT7FMXybv8SvS4gnH8lkcpV7T5QC4/ze0LUBEiv
         ie3A==
X-Gm-Message-State: AOAM532rhq84epOQUnHx9NuTkMfa0CWbuK8oSJJchWeAQ3VL+1/Q6NMc
        Qh8VjZ2VWIIqnfQHGkDOGFBcyrFFng6rsUOb4ge1ZGxaysbFTFKL6BztWGC2dpAecDRJmLxUoTW
        c1LXDhipGjL8TiHvdaVt9vAcgHcs=
X-Received: by 2002:a92:cb43:: with SMTP id f3mr7498932ilq.261.1631623863971;
        Tue, 14 Sep 2021 05:51:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQOifWkuc9mL1dcsIl3bKF0aUWScciqnaw6zhzA7m4a5F7kPmR6Ws9AccQ33sm5/UImKFy+g==
X-Received: by 2002:a92:cb43:: with SMTP id f3mr7498915ilq.261.1631623863777;
        Tue, 14 Sep 2021 05:51:03 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id s12sm2482668ilo.70.2021.09.14.05.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:51:03 -0700 (PDT)
Date:   Tue, 14 Sep 2021 08:51:02 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [rteval PATCH] rteval: stressng.py: Fix arguments for Popen
In-Reply-To: <20210914.134546.1926575477327712294.atsushi.nemoto@sord.co.jp>
Message-ID: <9a5f892-2072-7a99-b4c-9867a4dde27@redhat.com>
References: <20210806.174641.1741870399325228428.atsushi.nemoto@sord.co.jp> <20210914.134546.1926575477327712294.atsushi.nemoto@sord.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 14 Sep 2021, Atsushi Nemoto wrote:

> On Fri, 06 Aug 2021 17:46:41 +0900 (JST), Atsushi Nemoto <atsushi.nemoto@sord.co.jp> wrote:
> > Make each element of self.args contains only one argument.
> > 
> > Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
> > ---
> >  rteval/modules/loads/stressng.py | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
> > index 926de38..c259554 100644
> > --- a/rteval/modules/loads/stressng.py
> > +++ b/rteval/modules/loads/stressng.py
> > @@ -50,9 +50,9 @@ class Stressng(CommandLineLoad):
> >          self.args = ['stress-ng']
> >          self.args.append('--%s' % str(self.cfg.option))
> >          if self.cfg.arg is not None:
> > -            self.args.append(self.cfg.arg)
> > +            self.args.extend(self.cfg.arg.split())
> >          if self.cfg.timeout is not None:
> > -            self.args.append('--timeout %s' % str(self.cfg.timeout))
> > +            self.args.extend(['--timeout', str(self.cfg.timeout)])
> >  
> >          systop = SysTopology()
> >          # get the number of nodes
> > @@ -74,7 +74,7 @@ class Stressng(CommandLineLoad):
> >          if self.cpulist:
> >              for node in nodes:
> >                  cpulist = ",".join([str(n) for n in cpus[node]])
> > -                self.args.append('--taskset %s' % cpulist)
> > +                self.args.extend(['--taskset', cpulist])
> >  
> >      def _WorkloadTask(self):
> >          """ Kick of the workload here """
> > -- 
> > 2.11.0
> 
> Any comments?
> 
> There is an another problem in '--taskset' handling (do not work as
> expected on multi-node system) so I want to create a patch on top of
> this fix.
> 
> ---
> Atsushi Nemoto
> 

You haven't convinced me to apply the first patch - yet anyway, so you can 
decide yourself whether to create a version 2 that incorporates your new 
idea or whether they belong in to separate commits.

Thanks

John

