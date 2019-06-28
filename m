Return-Path: <SRS0=OCyy=U3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B4FC4321A
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 07:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6782133F
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 07:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zhxq6fJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfF1HKk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:10:40 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:39171 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfF1HKk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jun 2019 03:10:40 -0400
Received: by mail-ot1-f44.google.com with SMTP id r21so4324118otq.6
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Jun 2019 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lsv0z0MDq9dVu9ua4/XvJhC0VK8aBny/ki1jufu5cZI=;
        b=Zhxq6fJyTQ9+ZES9F28Iw/QLewFZ/gWdUsRZoSt4jsnaOOCtM4q9g9d+Gtq7cH07od
         lLxwf4Upgir82LtzVQDSb01gI/VRdHiQFJ6s+nx7Y50END9aab9wf9X3BoU0DOR1ZgOz
         oGejYl1sxNqxGfoK1zqlMfqZVyhdrfLRyb5GzeYJ06PlwZ8FKRDXHGinNS8P2AX2dD9u
         PidsnSG52GtZ67/6ujr+EPJGe7q0Owx/UyDOI3Tb4ZWY04dCAV8Xg7bfI8zf6AtSDgrK
         N2riSu8fRtAPZ6x3v2PHNg5RXGXvBf0HI+jTqQJQ13M9aG+curHXcpU172i9OZJ72XIe
         9ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lsv0z0MDq9dVu9ua4/XvJhC0VK8aBny/ki1jufu5cZI=;
        b=BHGFDVlaglHm2F7fqU+/LwrJMGDmmtVjUUCXG4fB2S3/XQHgcUH5pkQB+041/80YWc
         WQJJ6cESHUKdgvJ4Q6FV5ta7QYN6rk8NUzj+vCwbHLYNXWlf/DNYvY4rzS6HzNxDzsZF
         6SxF4mQHKr0NtFoKKfEVdHmEcxrxky/w1f2UtFefgHdz6X+345IN9jJdwKeWo30q2sg4
         Ye+etCuQUBTVMeR37M+bLYClNQcd+PA33aRz4F9xTllyp9zqhFfy9FwA2UA8WfeBCb5h
         7Z9cX7hEjChcCLqKAiT9yEJcSC92om3NX3Jv/Z0b388i0jiBFri+VMmcK0KjzlT4OuaZ
         2X5w==
X-Gm-Message-State: APjAAAV7+i23M7MWptNEIUMEfopAjkoZgYiET1nSB4LFKROE/dKeOh3l
        B+S+JCvSlYwrDIMgxUerYT1qug1dYN1bgJpvV68=
X-Google-Smtp-Source: APXvYqxN2oS6TRFWKHxkGF2laNxz8YZC6nGe397fxVv4VM15/fmAxzFVNp9Bpc0lNDgvFU+XyWPpEDjdO/ovvzyF0+c=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr4370144oti.122.1561705839482;
 Fri, 28 Jun 2019 00:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190626161843.2c6r2dxeoxeyxce7@linutronix.de> <CAJjrzcVMJRya42sZbVsiiHh2dv=Wuy-OouqesfjxUMG9bK1LkQ@mail.gmail.com>
In-Reply-To: <CAJjrzcVMJRya42sZbVsiiHh2dv=Wuy-OouqesfjxUMG9bK1LkQ@mail.gmail.com>
From:   Allen <allen.lkml@gmail.com>
Date:   Fri, 28 Jun 2019 12:40:28 +0530
Message-ID: <CAOMdWSJpN7eewEQUCpL8Me6LXNJxbY-FKxFT+1_OR9u2GX=iQA@mail.gmail.com>
Subject: Re: [ANNOUNCE] v5.0.21-rt14
To:     Arve Barsnes <arve.barsnes@gmail.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> >
> > Known issues
> >      - rcutorture is currently broken on -RT. Reported by Juri Lelli.
>
> This does not boot for me, using the same kernel config as for
> 5.0.21-rt13, which works as normal.
>
> At boot it seems to hang for a while, before throwing an error, so
> this seems to be a timeout problem of some sort.
>
> I don't know if this helps:
>
> Call Trace:
>  d_alloc_parallel+0x1c9/0x410
>  __lookup_slow+0x66/0x150
>  lookup_slow+0x31/0x50
>  walk_component+0x1bf/0x340
>  link_path_walk.part.0+0x2c1/0x540
>  path_openat+0xa4/0x1590
>  do_filp_open+0x8c/0x100
>  ? _cond_resched+0x10/0x20
>  ? _kmalloc_track_caller+0x167/0x200
>  do_open_execat+0x76/0x190
>  __do_execve_file.isra.0+0x6ad/0x890
>  ? kmemdup+0x20/0x30
>  ? umh_complete+0x30/0x30
>  do_execve+0x1c/0x20
>  call_usermodehelper_exec_async+0x17b/0x1a0
>  ret_from_fork+0x35/0x40
>

Boots fine for me. Haven't done anything beyond boot test though.

- Allen
