Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D29C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Dec 2021 15:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhLHQDM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:03:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236460AbhLHQDL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Dec 2021 11:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638979179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=blImjLIH40etsmQCxsLg2rJwTgRbiMt7P1cUUC6DdSE=;
        b=SRqFXFl93oLD66jdeTN3ixsmvjOlgtrEPRExNDy7LbNbq9z3+MPuP7ojPt26L/xBGlAOmM
        GW6TEhfvzJO5M+tV1Gif0DDiuPjt8WnWR3cGpM5hOhym1simrANrmjm3t01PFUNgcrFMnb
        TQ5VzoGuL3okKx2SCNyJyuR4SbxMjIc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-KcP2bWnrPvC3JMrx2MMsMA-1; Wed, 08 Dec 2021 10:59:37 -0500
X-MC-Unique: KcP2bWnrPvC3JMrx2MMsMA-1
Received: by mail-lf1-f72.google.com with SMTP id i6-20020a0565123e0600b00417d29eede4so1257289lfv.12
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Dec 2021 07:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=blImjLIH40etsmQCxsLg2rJwTgRbiMt7P1cUUC6DdSE=;
        b=mCaEMUCpj8TTX+w5gVCKzgwOsTixL9stWRnsuMRKpiYT8i0bPo+jfYCYEQyjRcqXBe
         j7pEd5lvVLfwXMtsojgGerVmqwS4VwgoRn7G1iSIaPZuEmHNgmRUUJMTeSsGtaxEJq7r
         wg9S8T6S4rK+MS/2dANAei32ql8drpuOdxWa5v2+dqVNspcQrLqZetipyIqWco2vs//2
         KC12XYkvtbYI9dGRKWvMb8G52lpGUmqHeX7ThqXT9qvVxC9MkeUiPJZDawtJYdZbkqua
         B+CafAGNhupDzXKGMyEDr2/JThyWVm09vdLvwCIzxJqUbF7miMYjNvPlmhRGMskAaNpK
         eWYA==
X-Gm-Message-State: AOAM532HQZ2ZeZWhh7v7pzc2pS4/+PH6PeBbH2MRj95dmpuOFxksbdDc
        mT/kpBOS0suB/sznNdz1EfoRpyo6r6tOVqC8GPHBfzr+J8/GOd6VdagwPCMf9tM04aLckFCwnxr
        qjM/DbUCpC3hX9Il9J39yUbLic+01SCcBOIXhBZG9qJA=
X-Received: by 2002:ac2:5dcd:: with SMTP id x13mr318052lfq.602.1638979176357;
        Wed, 08 Dec 2021 07:59:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbBsivbGjoBjo48n/FbYj3y3cTb3Aqlt/PlEgQ0bEwczRRK0YZsqiFfRi8oSpTiT2Q4AB3S/xIwTlFDvICMqc=
X-Received: by 2002:ac2:5dcd:: with SMTP id x13mr318031lfq.602.1638979176171;
 Wed, 08 Dec 2021 07:59:36 -0800 (PST)
MIME-Version: 1.0
References: <YalDQe/lyXqAxB0K@uudg.org> <20211208144231.GA323@amd>
In-Reply-To: <20211208144231.GA323@amd>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Wed, 8 Dec 2021 12:59:24 -0300
Message-ID: <CAD8J--8kORPik0q_L3+D0WStMh5oVfo8fVau3z5uJrU6v+hPyw@mail.gmail.com>
Subject: Re: [ANNOUNCE] 5.10.83-rt58
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Dec 8, 2021 at 11:42 AM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
> >
> > I'm pleased to announce the 5.10.83-rt58 stable release.
> >
> > This release is just an update to the new stable 5.10.83
> > version and no RT specific changes have been made.
>
> Thank you. CIP project started doing 5.10.X based releases, and we
> include -rt tree, too. To make my job tiny bit easier, would it be
> possible to CC: pavel@denx.de on release announcemnts?

I am adding you to the list of default recipients for the announce
emails. Would you like to receive notifications for the (RT-specific)
RC releases too? We use the RC release as a staging area to review
RT-only patches, either backported from newer RT kernels or fixing
bugs specific to that version.

Anybody else interested in receiving such notifications, please let me know!

Best regards,
Luis

> Tree is available at
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt
> .
>
> What may be more interesting is that we are running tests over at
> gitlab:
>
> https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/linux-5.10.y-cip-rt
>
> Thanks and best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

