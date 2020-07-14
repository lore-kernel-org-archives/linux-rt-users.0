Return-Path: <SRS0=fwOa=AZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CD9C433E5
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jul 2020 12:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA222068F
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jul 2020 12:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojEnQzbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgGNMSP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbgGNMSN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Jul 2020 08:18:13 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4569C061755
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jul 2020 05:18:13 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id e10so3606580vkm.10
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jul 2020 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nhO4pN0VQm37mxyqg6qJ1J9Od+3uICHcD5bkQ02VD9Q=;
        b=ojEnQzbe2VPlMSf6NMtyrExczfSuMsPx+8fdIaNRh+9j4rXFNjyye/tzBcMpJSRFBB
         eG2eBbbc0be5e6myYcde+5MmvdIZfV2pGc+ufTBh4MZI/avoEwsNHbWXhkQ+wy6CvVyB
         wDyP0RD6bm/0Njt8tkHj8hKyDsDBebNbDaSkKkQQsAYtUfGEd1AcekRmZE/DSWR/UJZv
         x09/cqkJzDiKYzIhxNoYYPcvFLqiyuwkV0gJTgd6PltfzXR2lrwOF/ZJDsTaKED3BomM
         AQSAaEX3oDrDgXtQvANaQCjJ5nHyUIW29gPmWXOICdv4Kysk+j9+RUkkcQysIyHcLzGL
         B6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nhO4pN0VQm37mxyqg6qJ1J9Od+3uICHcD5bkQ02VD9Q=;
        b=n7NwDQZetSV53VpPG2tsKoJY8vJQh5/NDhKAJ25/mZOoN2QOIQCNe4BOXZjaczcet8
         ACbzRxry3SneGrB49vXtHTYe98m1d2Ey6YUFbzir4ofL2GtMnNsKmdtEe1mJChAZDb7E
         JqNiJRdtihWBNDD7RxP7Dy5odzepEvQZp7THsuCM8dtcv5rMZzk4hVgDhBAzj3TlhHuC
         CuBW7maBYQfgFCpzhpLOq5t1NR/VFVjiTkzget8fNPEWz+VgAVpzV6WLXJBirW9sCDT/
         xCC6bCm2mB681phBBIx6v/hRBmNIRaFXin05PlWSN3OuC5URqsBStP701e86L8fFT8LP
         Ix/w==
X-Gm-Message-State: AOAM533zDgZGkYLIie+KfFgUq8Uk0sndAsbeXs2sAYZ2UKl3TK3RxeUN
        XGkQAnK3c2KQ8rGQSB2OnG8LeQfZfeZq7h+sRot762ZV
X-Google-Smtp-Source: ABdhPJz5Yu1lzHHx69E9gzWY4OwRzUomMekb/fFOynFN7qG9XZ8d+fgEo5UqPcaQtJ4S6LkQKKGNZgH5C3zCVfNjRZU=
X-Received: by 2002:a1f:4312:: with SMTP id q18mr3351105vka.84.1594729092818;
 Tue, 14 Jul 2020 05:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAFpOueS0rvys4Q81D3HEYX2U1vM808qQ4w+z6QxCWi1KJBGXXQ@mail.gmail.com>
 <20200713212054.2e675557@oasis.local.home>
In-Reply-To: <20200713212054.2e675557@oasis.local.home>
From:   Itai Handler <itai.handler@gmail.com>
Date:   Tue, 14 Jul 2020 15:18:01 +0300
Message-ID: <CAFpOueRmBfzhPFb-q_pB1xpCQq4Cuo7rCCsc2eUPsGdaei-+3A@mail.gmail.com>
Subject: Re: aarch64 boot time increases with rt
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steven,

On Tue, Jul 14, 2020 at 4:20 AM Steven Rostedt <rostedt@goodmis.org> wrote:

> You mean compared to non PREEMPT_RT_FULL of the same kernel?

Yes.

> I'd suggest trying 5.4 or even 5.6-rt.

I tried 5.4.47-rt28, and the problem still persists.

> Well, you could try: ftrace=function_graph ftrace_graph_filter workqueue_prepare_cpu
>
> If workqueue_prepare_cpu is a traceable function (not inlined nor notrace set).

I tried "ftrace=function_graph ftrace_graph_filter=workqueue_prepare_cpu",
however, the trace appears to be empty.
The function workqueue_prepare_cpu is not defined inline nor notrace.

Please see log below:
# mount -t debugfs none /sys/kernel/debug
# cd /sys/kernel/debug/tracing/
# cat trace
# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
# cat set_graph_function
workqueue_prepare_cpu
# cat tracing_on
1

Do you have any idea why it's empty?

Thank you,
Itai Handler
