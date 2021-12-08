Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0D5C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Dec 2021 13:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhLHNS2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Dec 2021 08:18:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230001AbhLHNS1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Dec 2021 08:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638969295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BefnaS2nSDTkIemFZysrfU8x7ykoBKhJ8nWicX2wdE=;
        b=GlphEjHgQHiB614q0Q0IoYlQA0m5sLIXuJMgL0tQYLazZ6MD+t6u0TlTtQJ8L+G0AL7QZR
        vRMpuHzmK/kkX5zltzIxVPA4HUzyDjBFCLxV9lk+S+oIO5agYGs9rYtzG9Q3wRbM0jDjCx
        tcb6rS8sUfuir4FMeieTOCo6sISzEEg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-na-BH1nBNCauUk8VVMFGFw-1; Wed, 08 Dec 2021 08:14:54 -0500
X-MC-Unique: na-BH1nBNCauUk8VVMFGFw-1
Received: by mail-lf1-f71.google.com with SMTP id d2-20020a0565123d0200b0040370d0d2fbso1085187lfv.23
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Dec 2021 05:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5BefnaS2nSDTkIemFZysrfU8x7ykoBKhJ8nWicX2wdE=;
        b=vhpw9CQrLXXeMQMVhrFzok1GLnc4irJhinfenq9WA61cxOXEXnBegtI1Els9cnGJ/m
         Zh7181OXc6oiSES70G0yvKe+aqsm6MNljImy2UomB0U7hsWZWyh3rcxTIF1MNy5Ij6n4
         yQv9y+B4jkPkcsNH8dXuNeTfsnQQNHZ4QEY17DGJcsa8fwo0d5hWuhtvRSrGL41euhKi
         vOyOhfn55acDLWv+zY2rTAHa3fXDPxBqVGr6+P02OFoJvLMmTtX8TYP5H02cuX65N/Mn
         kS8P++NdkeC4ajp9A4IW0HpLGRL/j0iHSwwAeXBUW+Z78yE+rzQWQJkFF792gFA+yBb/
         oAOg==
X-Gm-Message-State: AOAM530gXV6H5CRIlqYdFR6E4O1x9mEZJvEB8FyX2br6yechKaBAL3Uj
        oY+kTisQZDWM46WjMcCLlCmm1PvFKcvJ77z2VigMEq6QHZoe4n/ekyDu3h6N3LnM04bda3wCRWc
        X8G1vrcf2idXJol8M2dzeY1KA+9dKh5VbMOwPRzyGH2k=
X-Received: by 2002:a2e:5c04:: with SMTP id q4mr49841300ljb.334.1638969292981;
        Wed, 08 Dec 2021 05:14:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyugEfiRIOQkZEu7BUBsd8M6hitOdeGayCxRluKGR8B8A3YP8b6MQw3ScrlOwtpOiNshZ/qIoRHIb0CnvshZ2c=
X-Received: by 2002:a2e:5c04:: with SMTP id q4mr49841281ljb.334.1638969292775;
 Wed, 08 Dec 2021 05:14:52 -0800 (PST)
MIME-Version: 1.0
References: <YalDQe/lyXqAxB0K@uudg.org> <20211207201712.7yqbksbba3zgu7u3@linutronix.de>
 <20211207152049.1013e1ce@gandalf.local.home> <20211207205628.auc54rwl4duuisah@linutronix.de>
 <20211207160203.30206456@gandalf.local.home>
In-Reply-To: <20211207160203.30206456@gandalf.local.home>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Wed, 8 Dec 2021 10:14:41 -0300
Message-ID: <CAD8J--9V7KxJrT==vnoawWXpp9Ur_-o2Fhm_ebNd4-hH8ncfPg@mail.gmail.com>
Subject: Re: [ANNOUNCE] 5.10.83-rt58
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>, carnil@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Dec 7, 2021 at 6:02 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 7 Dec 2021 21:56:28 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>
> > On 2021-12-07 15:20:49 [-0500], Steven Rostedt wrote:
> > > On Tue, 7 Dec 2021 21:17:12 +0100
> > > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > >
> > > > On 2021-12-02 19:05:53 [-0300], Luis Claudio R. Goncalves wrote:
> > > > > I'm pleased to announce the 5.10.83-rt58 stable release.
> > > > =E2=80=A6
> > > > >   https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-=
5.10.83-rt58.patch.xz
> > > >
> > > > Any particular reason why every patch has "v4.9-rt" in the Subject =
line?
> > >
> > > I'm guessing because he just took over 5.10-rt and did not update his
> > > scripts ;-)
> >
> > It seems to confuse ppl. Is there a reason to have it?
> >
>
> It shouldn't. The point I'm making is that this is Luis's first release o=
f
> 5.10-rt, and it sounds like it had some issues.
>
> Luis, you may want to see what happened and fix it.

Yes, I am really sorry that escaped my review. I focused on testing
the code and missed something that obvious.

Sorry for the confusion I caused.

Steven, Sebastian, would it be worth a v5.10.83-rt59 with the patch
subjects fixed?

Thanks for spotting that,
Luis

>
> Thanks,
>
> -- Steve
>

