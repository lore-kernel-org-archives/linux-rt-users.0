Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89E0C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Dec 2021 20:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhLPUVy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Dec 2021 15:21:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232532AbhLPUVx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Dec 2021 15:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639686113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4jNVvkqs0Rpz1daVHHfDUsDlVwoDvruQypySygjyOd8=;
        b=PZrRqMrrRLLKE9wCFTsLEmZaq8G262bV1KP+5vzEtGV0lFR2ZiiqSJc0QZQtPMEJ6timNt
        JI94rq8Uv50ocEWttK2ZthtUyKkP8TGfICor7G2WxZ+Zjy19RYJ7DQ3xsbVZtQtGUvGeDd
        O6pUQFvpWedabl25DviQIIiHXFOBMwo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-_zOB4g4rNrW8s-KkoCLPPA-1; Thu, 16 Dec 2021 15:21:52 -0500
X-MC-Unique: _zOB4g4rNrW8s-KkoCLPPA-1
Received: by mail-ed1-f70.google.com with SMTP id v19-20020a056402349300b003f7eba50675so5543189edc.12
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Dec 2021 12:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4jNVvkqs0Rpz1daVHHfDUsDlVwoDvruQypySygjyOd8=;
        b=pauhro8WveXGHWJCt6GMTx5xXj3buRqW3Jxz6skWGZqAaot9jewunDRKGJ8tsHUHv3
         Ws3JBsipZ/SsYJQ0wJsB9yjMEtRGo4aOZO44asnt7ywScDdC4a031jX0nCXAsLBvWFVw
         C1d61H7wQ+VvT6aBxTYa0Ep148Cf+I5P+nqg7A5A69cX19Cbu6gcaqUbA+/OK+euuuPi
         fRnkF3y2irVageOd5tKwrRQ4f/wbTQphQ2n9FMvFxl4Nqn9Be5TIKjQ+RXE+Ge4/Lptn
         bvpyM0LyUJz4vOaWq+9GuDVSgw2nz6e/sF8655zlq3HiQR4tsBsgY6M0sr+eC/98sYsQ
         z1zw==
X-Gm-Message-State: AOAM5315bGHtdLYOdDz7uLeF4J0yxCq6XZMjP0PO74yT8QEjZwPIld4V
        4FLRBz9Y4iY1snd6DFTc/2jZ/N+dhPjUxdinGT9DHfaSSpPMTXKxSlAebv1KS6VO9AHVCRcpQIM
        b4s2snXvK6LtrWfwR6jz/DfXmJvUEV6qmmEqNFuviH6o=
X-Received: by 2002:a17:906:d54e:: with SMTP id cr14mr4585127ejc.724.1639686110606;
        Thu, 16 Dec 2021 12:21:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5TrBQDhec5S8MpqrzjB+uugBOSGONH0FwNYWw86mCaVHMpLi8Qk2TWqknosMRVZK6sy//lsKyzlgelaA3h2k=
X-Received: by 2002:a17:906:d54e:: with SMTP id cr14mr4585114ejc.724.1639686110406;
 Thu, 16 Dec 2021 12:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20211213123737.9147-1-wander@redhat.com> <20211213123737.9147-3-wander@redhat.com>
 <YbohEio+66fyFo6D@linutronix.de> <20211215123116.622da7ef@gandalf.local.home> <2f3300ba-0879-ad7d-8d44-bb8d8b17d7e2@kernel.dk>
In-Reply-To: <2f3300ba-0879-ad7d-8d44-bb8d8b17d7e2@kernel.dk>
From:   Wander Costa <wcosta@redhat.com>
Date:   Thu, 16 Dec 2021 17:21:39 -0300
Message-ID: <CAAq0SUn=j3bQoDLO6muGs776seGwhugf=OU7rEMRM2vFK6djpw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] blktrace: switch trace spinlock to a raw spinlock
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Dec 15, 2021 at 4:34 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/15/21 10:31 AM, Steven Rostedt wrote:
> > On Wed, 15 Dec 2021 18:08:34 +0100
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >
> >> On 2021-12-13 09:37:37 [-0300], Wander Lairson Costa wrote:
> >> =E2=80=A6
> >>> To avoid this bug, we switch the trace lock to a raw spinlock.
> >>
> >> Steven, do you think this is a good idea?
> >>
> >
> > blktrace is actually maintained by Jens.
>
> Looks like there are two patches, and none were CC'ed linux-block.
> Please resend.
>
Ok, I am going to do it, thanks.

> --
> Jens Axboe
>

