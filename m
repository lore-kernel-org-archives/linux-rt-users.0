Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF68C433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Oct 2022 20:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJMUK1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Oct 2022 16:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJMUK0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Oct 2022 16:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA5F50BA1
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Oct 2022 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665691821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=op72hS3Ys8t1IUsgKyD0qf5X1nsTlU5KnM03smK0Xyg=;
        b=EWcTCs1AjlBULh4NCB15Hh1KXP+kEthG9VvamfGq8odThiv2mz7TYTHjbCo/SCInNEvJHB
        WzgXeMum/hpb2FgZmEIelDdgI4rTRDv5GPswuDs+o20j6uDAKJCn9cOr48hZ+nXRvZeUd4
        OdXv2ZJ0esWOkDSc1pbYj2NQ+Q0DssI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-_ITTKxBPOmmHVBuWS357Qw-1; Thu, 13 Oct 2022 16:10:19 -0400
X-MC-Unique: _ITTKxBPOmmHVBuWS357Qw-1
Received: by mail-lj1-f198.google.com with SMTP id bn39-20020a05651c17a700b0026309143eeeso1267487ljb.4
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Oct 2022 13:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=op72hS3Ys8t1IUsgKyD0qf5X1nsTlU5KnM03smK0Xyg=;
        b=psVQJyayO+xcTGBW4eKj1RmthY83ChZOwBBnnx2tt1AhUytBtanRbRLsBeYzBLFiRH
         jjdq72TGC6jOr1JATBx6rPohVbC4MksC6Srf1Dvk7A/wWGJrWxMRqG3A1cWuJ+DU4FxQ
         DE2cn5PI2r+meIUvJcRCKwdhRnOHrEKRdMvQF+bWomOsJ1FdzMmzLjQB5dvaCxIpMiQa
         Uk7qkAL6SVplb4ApqD4Q9+1tVljdDqbvy5CSSenlSg8qcQ64b5VDP9dVeLb/ZMx5v2aJ
         856TFNUE9zpYPAw/c8l+JL37cyeLOsk5SkKFUxKWOYMUHfSJFUT5Whva9oS7sdo8HROI
         WWHg==
X-Gm-Message-State: ACrzQf0+EMQwFpDQHOIrfSiaXBdA/ItsGnLt/oAdIpm+UQDo0vyuuaBP
        8/ftVWnWl+jsnx9ysKlK42SDh1fLKCrUP7dQ2d5rT1aR9+bToZma6lfBwW2/5Q1YhwQuLsfGOqZ
        Rn6MYQ11l7PpM93A7Rz2ngH4gmMVAmjf6XLJfMVDmdyw=
X-Received: by 2002:a05:651c:903:b0:26d:d930:e3cf with SMTP id e3-20020a05651c090300b0026dd930e3cfmr649190ljq.232.1665691818342;
        Thu, 13 Oct 2022 13:10:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6zkcIrAn/T3AwYAaHYzAvnvOOuS2YYuG2NSHxwsj6DjN8Yq4PTLJuxDE45Fh3kJfG1yFqBNnKiiVs8ok/Jbmw=
X-Received: by 2002:a05:651c:903:b0:26d:d930:e3cf with SMTP id
 e3-20020a05651c090300b0026dd930e3cfmr649183ljq.232.1665691818125; Thu, 13 Oct
 2022 13:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <ea166a37-09c2-04ab-fda8-98a6b29608ab@highlab.com>
 <CAMLffL-Zr6aj6LojpbKfHEHjV=y=P3dRhBL4=Fh0+X-SKFg-UQ@mail.gmail.com>
 <adfcede2-0da1-233d-09d7-004688e39178@highlab.com> <c1ac2662-07b7-36e6-eca5-992ac6e5452e@logilin.fr>
 <f87020ae-916f-06a9-2cba-fe4854724cd4@highlab.com>
In-Reply-To: <f87020ae-916f-06a9-2cba-fe4854724cd4@highlab.com>
From:   Clark Williams <williams@redhat.com>
Date:   Thu, 13 Oct 2022 20:10:06 +0000
Message-ID: <CAMLffL_w-cGfoTYd_KrMExSzHNXyzQmNCoJB8XfVXTFVuS6C6Q@mail.gmail.com>
Subject: Re: SCHED_OTHER > SCHED_FIFO?
To:     Sebastian Kuzminsky <seb@highlab.com>
Cc:     Christophe Blaess <mailist@logilin.fr>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Yeah, Christophe had the magic touch; that turns off RT throttling.

On Thu, Oct 13, 2022 at 4:14 PM Sebastian Kuzminsky <seb@highlab.com> wrote:
>
> On 10/13/22 00:07, Christophe Blaess wrote:
> > Hi
> >
> > On 13/10/2022 01:25, Sebastian Kuzminsky wrote:
> >> Thanks for the suggestion, but it gives results that are only slightly
> >> better:
> >
> >
> > It will probably make no difference as you run your task on an isolcpu
> > but did you set  `sysctl  kernel.sched_rt_runtime_us=-1`
>
> Wow, this plus Clark's suggestion to run with SCHED_FIFO priority 2
> fixed it, thank you!!
>
> With those two changes I now get identical, awesome results with
> SCHED_OTHER:0 and SCHED_FIFO:2 (running on an isolcpu):
>
> > $ sudo sysctl kernel.sched_rt_runtime_us=-1
> > kernel.sched_rt_runtime_us = -1
> > $ sudo ./busy
> > using PTHREAD_EXPLICT_SCHED to set SCHED_FIFO (with highest priority)
> > scheduling policy: SCHED_FIFO
> > scheduling parameter priority: 2 (min=1, max=99)
> > cpu affinity: 3
> > after 10000 iterations:
> >     min=54001 cycles (1000.019 us, 1.000 ms)
> >     avg=54002.001 cycles (1000.037 us, 1.000 ms)
> >     max=54004 cycles (1000.074 us, 1.000 ms)
> > OK: worst latency < 2 ms
> >
> > using PTHREAD_INHERIT_SCHED to keep SCHED_OTHER (with default priority)
> > scheduling policy: SCHED_OTHER
> > scheduling parameter priority: 0 (min=0, max=0)
> > cpu affinity: 3
> > after 10000 iterations:
> >     min=54001 cycles (1000.019 us, 1.000 ms)
> >     avg=54002.001 cycles (1000.037 us, 1.000 ms)
> >     max=54004 cycles (1000.074 us, 1.000 ms)
> > OK: worst latency < 2 ms
>
> Thank you Christophe and Clark!
>
>
> --
> Sebastian Kuzminsky
>

