Return-Path: <SRS0=CYeZ=BV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3F1C433DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Aug 2020 19:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A85206DA
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Aug 2020 19:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsYdxWyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgHKTHO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKTHO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Aug 2020 15:07:14 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27036C06174A
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Aug 2020 12:07:14 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w17so2827590edt.8
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Aug 2020 12:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtiSMgH2VYW1gul1xif9uG7BNRec6oCb3k7jlNDMCso=;
        b=QsYdxWytJ+hdeVWKQIMzsBk6u23Wuq69Vk07RncJ5wZoKUpiq2PldjExhQA0kwTpT6
         0qUVax6LyJ3RhWfAUiEY13jS8qU2aC9MmpG0Z21CZNDTB6CXuqcWw31Wxrcn6GNLfurW
         hVojoWF5wK4jhDPL89PzTieb+4swKIelwJu0dPLgCEGS9ZGXCIf9a2ZXyVUOsksOb2D1
         YIqoiPQuEj8OWZP1H27QDQBmIjjMC5XResc3MMCFxoqH1zhFVvDmySaJxxJwPdyr3dzK
         oC4WqG4T9YSoX8c7ec/n/NRH3TWUW9UnFAe4beJaqv2J5zZtRTeSlee2KS536yFwBQTn
         NnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtiSMgH2VYW1gul1xif9uG7BNRec6oCb3k7jlNDMCso=;
        b=Zu5dEKjrmv0+cMY3R044CT2ir+EDuhTex/aHS8vYymysJ9EmIEXNKbWIYAGI3gNB36
         CwolM1Non+X7JiqM8ceEwun4oKO04it8riZZ/CXj8bkZh2Tr9vgPYOVQdsSWNjzdVxbV
         8tXCh3NjpzLlm5WH2w/Au/w0OSn2TjG0j7r5wyE+B9ypRMn0tTK760tejrF5esEQMNHD
         ZcnnTRwj9Zou26TBHURQMA5ryqhPF0BId9sBqKiVorCUyn7JnSPnWg+vk0NAXSiClJg1
         /wX/SsRu/YcUiZRywR023gPHyPx7sXJax8v5kScIXlg5y0ljUi6GhHFsIC7hJ2JVFGvw
         JzFQ==
X-Gm-Message-State: AOAM533/7ZnPapndQO5eQHG1v301A264+OJtVFSDhEFt5CVgUWp17rrT
        B9NUz8s/rqKqNr/WHG/GMXz5IBMpHmMauqG06W31hil/
X-Google-Smtp-Source: ABdhPJyGg6Lh+T/w84XuIlaW3wAvdmROIz3Hu99ksU1zQaF6+IfNDZHhvlpDfCO8YINaTMZsveZllUc1fnQqON9tXbo=
X-Received: by 2002:a05:6402:1b1c:: with SMTP id by28mr28333753edb.89.1597172832353;
 Tue, 11 Aug 2020 12:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkbJ-wBoJUXzhLxsT4xaOgc3RcG7_U_H=WMKb=y=Ebks2cBcw@mail.gmail.com>
 <47AD6512-D260-414D-9727-EE8AB3CF7095@gmail.com> <CAKkbJ-xyCH_RkOaihdN01sFRSznbX-Br7MrG9x0SRwDR6KAmYQ@mail.gmail.com>
In-Reply-To: <CAKkbJ-xyCH_RkOaihdN01sFRSznbX-Br7MrG9x0SRwDR6KAmYQ@mail.gmail.com>
From:   Austin Schuh <austin.linux@gmail.com>
Date:   Tue, 11 Aug 2020 12:07:01 -0700
Message-ID: <CABsbf=Gy+riw2EBuD=6xL1VGJ8WTuFwt4-2kj8T1TFeBH++VwA@mail.gmail.com>
Subject: Re: Serial port driver usage and status
To:     Michel Macena Oliveira <michel@austral-dynamics.com>
Cc:     Itai Handler <itai.handler@gmail.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 11, 2020 at 7:43 AM Michel Macena Oliveira
<michel@austral-dynamics.com> wrote:
>
> Austin thanks for the Idea, those tests will give more reliable results.
> Itai thanks for the idea, I will search more about ftrace.
>
> Another newbie question, when I put a read or write call inside a
> thread with real time priority, I can say that the call is real time
> scheduled or should I code in a different way
> to "make it" real time?  I mean, if just the fact that a function is
> inside the RT thread with high priority  is enough to say it is real
> time. I am asking this because I'm
> still learning how the real time context fits into the Preempt RT
> kernel concept.

In principle, there's nothing special you need to do from the user space side.

In practice, every driver is special in it's own way.  There are
threaded IRQs associated with the critical path from IO to you that
you may want to re-prioritize.  You'll find bugs in other drivers
where there are work-queues in the middle.  The list goes on.

I've found that the best thing to do is exactly what you are doing,
setup a benchmark which actually lets you measure the latency and
jitter, see how well it is performing, and start tracing to figure out
if something is going wrong in the critical path.  I've found tracing
the scheduler, irq, and workqueue events to be quite effective at
figuring what is going on.

Austin
