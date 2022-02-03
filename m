Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA57C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Feb 2022 11:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiBCLte (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Feb 2022 06:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiBCLte (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Feb 2022 06:49:34 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19013C061714
        for <linux-rt-users@vger.kernel.org>; Thu,  3 Feb 2022 03:49:34 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 124so7448133ybw.6
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Feb 2022 03:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bik78RjsZLAmzDZiN6WUbHyOyEn06UrCc9meP5snEAw=;
        b=AcOa0CQ2u7dpFK+nmK7cvYUHJs0S9Kp3/csTzDeecczSlBP6Dj22EnRZUB1Ask8GB5
         hrnJKe8P+UffiZ1C3XxoBCV1FJd0fIfTKYsWdHejL8QmZrBEW3smLZK4lQD1K5JDBdNu
         bJ9DNm7Yl9oHbbY4RKLAnb7/mMKMOpriKC/tCDqRrK2pQXaEW0221g6i1EACkmnBPnuD
         zrx9XyalNVJMMhnNxn9hprzBugxcIUDEEnZ+taycjGT4KCOEXM7r6d1r0qk8u8j9tbX1
         iMrk9n3q0s6VfPReolUx4yrHDkw54425KT5IQrxAg3nCIhDuYz3e36xe4ucSu4oevhQO
         mwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bik78RjsZLAmzDZiN6WUbHyOyEn06UrCc9meP5snEAw=;
        b=MAswrPMAjCcYsezZoM2bEKPlFQsSu/jdU6CTKD6EhbaQ961Y80HHwfhbthiqVirskS
         N62iwZo9nTQM79tQnsA9ECymW5V/lvmhMa6fhXMpUT2D9N9q6PQxBCWsqksKrUlGHU1O
         lqombfmP7KG5w9CJN68mmh21Ag9HG4ghOaGdqUnKg0UoWNldz2y7ytAiqzWMmmTTrCWI
         nKeSibStmHPZ31L7w/C+Xh0XUxJ1IweqZ4YkpRDwaQNt3T5VQCWuKfHwdzmuR+nWahhc
         L+lSmnvEArNRSz6vJO67nkcVqMQMuLgOGqKJnhCVMy24g4dgKedtqOp9CwuUrNOF0k6d
         vlXw==
X-Gm-Message-State: AOAM533100mGGoCIR4JIGKl2Y+uwUB9RSjGNx4yW0qfqU7bDMoSrL3BA
        c1Tih5IO6a4dK03U8M9f0+WX6U4Zi8d0ahtq42eCwdQrjcBmjA==
X-Google-Smtp-Source: ABdhPJw/GMI7uf37ihVreLaAZxCtNquqDRFo5jkIuogz+d5xOf5tBxsJYzKHd7KxD38Xjvq3x05xiLyjl+94WPc7TcM=
X-Received: by 2002:a25:a89:: with SMTP id 131mr45424725ybk.234.1643888972067;
 Thu, 03 Feb 2022 03:49:32 -0800 (PST)
MIME-Version: 1.0
References: <10b1995b392e490aaa2db645f219015e@dji.com> <dd9673737c354eb898fc22ee466efbda@dji.com>
In-Reply-To: <dd9673737c354eb898fc22ee466efbda@dji.com>
From:   Daniel Vacek <neelx.g@gmail.com>
Date:   Thu, 3 Feb 2022 12:49:20 +0100
Message-ID: <CAA7rmPGCZ35NSzuEpWapT0cH=XFXaKcUGds3fvxgvCQSM+Noeg@mail.gmail.com>
Subject: Re:
To:     Caine Chen <caine.chen@dji.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Caine,

On Tue, Jan 18, 2022 at 4:44 AM Caine Chen <caine.chen@dji.com> wrote:
>
> Hi guys:
> We found that some IRQ threads will block in local_bh_disable( ) for
> long time in some situation and we hope to get your valuable suggestions.
> My kernel version is 5.4 and the irq-delay is caused by the use of
> write_lock_bh().
> It can be described in the following figure:
> (1) Thread_1 which is a SCHED_NORMAL thread runs on CPU1,
>     and it uses read_lock_bh() to protect some data.
> (2) Thread_2 which is a SCHED_RR thread runs on CPU1 and it preempts thre=
ad_1
>     after thread_1 invoked read_lock_bh(). Thread_2 may run 60 ms in my s=
ystem.
> (3) Thread_3 which is a SCHED_NORMAL thread runs on CPU0. This thread acq=
uires
>     writer's lock by invoking write_lock_bh(). This function will disable
>     button-half firstly by invoking local_bh_disable( ). But it will bloc=
k in
>     rt_write_lock() , because read lock is held by thread_1.
> (4) At this time, if irq thread without IRQF_NO_THREAD flag on CPU0 trys =
to
>     acquire bh_lock(it has been renamed as softirq_ctrl.lock now), irq
>     thread will block because this lock is held by thread_3.
>
> -------------------------------------------------------------------------=
-----------------------------------------------------------
> CPU1                                                                     =
       CPU0
> -------------------------------------------------                    ----=
-----------------------------------------------------------
> thread_2                       thread_1                           thread_=
3                               irq_thread
> --------------                  -----------                           ---=
--------                            --------------
>                                  read_lock_bh()
>
> ......
>                                                                      writ=
e_lock_bh()
> /*do work*/                                                              =
                                 /* irq thread block here*/
>                                                                          =
                                     local_bh_disable()
> ......
>                                  read_unlock_bh()
>                                                                      ....=
..
>                                                                      /* d=
o work */
>                                                                      ....=
..
>                                                                      writ=
e_unlock_bh()
>                                                                          =
                                     irq_thread_fn()
> -------------------------------------------------------------------------=
---------------------------------------------------------
>
> In this case, if SCHED_RR thread_2 preempts thread_1 and runs too much ti=
me, all
> irq threads on CPU0 will be blocked.
> It looks like a priority reverse problem of real-time thread preempt.

Not really. I guess there's one misunderstanding in your description.
Disabling the bottom half is local to running thread and not to the
CPU which executes that thread. As an effect, preemption practically
enables the bottom half again (as long as the new thread did not have
it already disabled before, of course...).

That said, the irq_thread will _not_ be blocked as bottom half is not
disabled in it's context. From your chart, it's disabled only in
thread_3 context and thread_1 context. But these two are independent
(due to the different thread contexts and not the different CPU
contexts as you misassumed) and they do not block each other either,
it's the rw_lock serializing these threads, right?

You should be able to see this with tracing. There should be no issue
or the issue is different than you think it is and different than you
described here.

Hopefully the above helps you,
Daniel

> How can I avoid this problem?  I have a few thoughts:
> (1) The key point, I think, is that write_lock_bh()/read_lock_bh() will d=
isable
>     buttom half which will disable some irq threads too. Could I use
>     write_lock_irq()/read_lock_irq() instead?
> (2) If my irq handler wants to get better performance, I should request a
>     threaded handler for the IRQ as Sebastian suggested in LKML
>     <RE: irq thread latency caused by softirq_ctrl.lock contention>.
>     Is threaded handler designed for low irq delay?
> (3) Thread_2 takes too long time for running. So it is not suitable to se=
t this
>     thread with high rt-priority. Should I reduce this thread's priority =
to
>     solve this problem?
>
> Are there better ways to avoid this problem? We hope to get your valuable
> suggestions. Thanks!
>
> Best regards,
> Caine.chen
> This email and any attachments thereto may contain private, confidential,=
 and privileged material for the sole use of the intended recipient. Any re=
view, copying, or distribution of this email (or any attachments thereto) b=
y others is strictly prohibited. If you are not the intended recipient, ple=
ase contact the sender immediately and permanently delete the original and =
any copies of this email and any attachments thereto.
>
> =E6=AD=A4=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E9=99=84=E4=BB=B6=
=E6=89=80=E5=8C=85=E5=90=AB=E5=86=85=E5=AE=B9=E5=85=B7=E6=9C=89=E6=9C=BA=E5=
=AF=86=E6=80=A7=EF=BC=8C=E4=B8=94=E4=BB=85=E9=99=90=E4=BA=8E=E6=8E=A5=E6=94=
=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=E3=80=82=E6=9C=AA=E7=BB=8F=E5=85=81=E8=AE=B8=
=EF=BC=8C=E7=A6=81=E6=AD=A2=E7=AC=AC=E4=B8=89=E4=BA=BA=E9=98=85=E8=AF=BB=E3=
=80=81=E5=A4=8D=E5=88=B6=E6=88=96=E4=BC=A0=E6=92=AD=E8=AF=A5=E7=94=B5=E5=AD=
=90=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BB=BB=E4=BD=95=E4=BF=A1=E6=81=AF=
=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E4=B8=8D=E5=B1=9E=E4=BA=8E=E4=BB=A5=E4=
=B8=8A=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E7=9A=84=E7=9B=AE=E6=A0=87=E6=8E=
=A5=E6=94=B6=E8=80=85=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E9=80=9A=
=E7=9F=A5=E5=8F=91=E9=80=81=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E5=8E=9F=E7=
=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E7=9B=B8=E5=85=B3=E7=9A=
=84=E9=99=84=E4=BB=B6=E3=80=82
