Return-Path: <SRS0=Dbld=RP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3D3C43381
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 13:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42705206BA
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 13:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sC1+YP8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfCLN2W (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:28:22 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41843 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfCLN2W (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Mar 2019 09:28:22 -0400
Received: by mail-yw1-f66.google.com with SMTP id q128so2038176ywg.8
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Mar 2019 06:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7X3YMzAz2Izn0rieKSmjo4TjrPCDmTaFu+j8bGoqRQ=;
        b=sC1+YP8EudkThPHCyHohO6Ad1fQnonotdCaBGLhjqxHPB929Oq+BwilwBTZ9fDoqKr
         R4ArYoK71DnX77ICx+YBQEkVT9Z16wIqkHQ07xmU2tBkrx/SfaLlL3DuGw46GIvWDh1N
         Wyep9NyDlAGmL9s7FI5Tl5IyHAOs+ckf2mCU+POguwee/3acWn8wjfYE/rBNEO1rhk9K
         k/Vo+4ioouvibmw6nnqW3RE9LiySVW5yW8Hk9Q8oxPUTd4BWt1JtVh6zn/HW9RZ3bd7k
         pNJjykptdgPtQBsj0SG0TrjSMDVXh1iHxBNMXIGDFbQ7ABm//BxtX4b7szqK7Gb7WJf4
         U6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7X3YMzAz2Izn0rieKSmjo4TjrPCDmTaFu+j8bGoqRQ=;
        b=AvhclWfE+MrTB7H9YuBvb6jNYDKo2CFKOS9MW75FI9Mgh7PcxG7WSPSO/EoJaMjpjB
         2ofLYz+R8EjEMR2fY0GNop6BgbQbytZrFeJpLV4Pif78o4az+RxkKyKIub/mFFPPoqOB
         AdRDTaPVgrQOCa3W05tC3+fysyu3Bti5CPwjLKBYLMoZJubtSkcP3XilNTEiw3soaptH
         luhuAbsC2P7/8TGYrtYOTdMiyqTcrpNylDqz6zFvspuPiC6pDgJlSX5ddaFB5ff9xEsh
         GReY44Ty4pABPnpW8hsT9OZPSRBrhPG5xJkumJjNvfNRDbcTMNdOsuLPtyKTVopicy9t
         gwWQ==
X-Gm-Message-State: APjAAAW8kC1eS/QH6qZ7ysrvpoRQEdyPJn3NyL5XShEJmpTjDwdkF2ja
        ECE8zR83cPNGLGYiPucT+yvItR6NwQoFZaVOFsA=
X-Google-Smtp-Source: APXvYqyiXB3gl1IsUst7Psyzoyje4n4id5IELBRv2YwAQhzS7mLL2qGGhnGwgaE6dHLjXIG4Vmyx+0xyf+Ul4ecpEKM=
X-Received: by 2002:a0d:c6c5:: with SMTP id i188mr29405494ywd.320.1552397301039;
 Tue, 12 Mar 2019 06:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAAh1qtmTVSPfzsGsuxbu3qzAQ9U=3wBCkVFh4DDRjeOA_eqpYA@mail.gmail.com>
 <CAK-9PRBa4H=aTRR6h6B9jmmBW8wf3eXJbAOVipR6ehuYMrYxcQ@mail.gmail.com> <CAAh1qt=fZuSGvAQ_75ppYd4XALqjA6obSGkK2gn=xpjyYhSv9A@mail.gmail.com>
In-Reply-To: <CAAh1qt=fZuSGvAQ_75ppYd4XALqjA6obSGkK2gn=xpjyYhSv9A@mail.gmail.com>
From:   Yimin Deng <yimin11.deng@gmail.com>
Date:   Tue, 12 Mar 2019 21:28:09 +0800
Message-ID: <CAAh1qt==BX2wUpu6yOjpM0R3aHV9qWDTJ_U1Cq9=onx3Ewcm_g@mail.gmail.com>
Subject: Re: Help me: deadlock reported in pthread_mutex_lock
To:     Chinmay V S <cvs268@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi CVS,

No related item found in the latest cpu errata.

It's difficult to reproduce the issue and to debug the glibc which
provided in binary by the third party. According to the coredump, it
should be free after a while. So I do a workaround: modify that
mutex's attribute to be PTHREAD_MUTEX_PI_NORMAL_NP (the mutex is
shared by two cores on SMP) and replace the pthread_mutex_lock with
'do pthread_mutex_timedlock while its return value is ETIMEOUT'. I
hope it will work. But it will take a long time to verify whether it's
OK.

Thanks again for your concern!

B.R.
Yimin

> Hi CVS,
>
> Sincerely appreciate for your effort on this issue!
>
> > > I could not image a scenario that lead to 3 different values on the
> > > same variable mutex->__data.__lock seen in 3 positions.
> > Is there a common pattern to these 3 different values?
> > - Do they look like memory bit-flips (if yes, then misbehaviour /
> > misconfigured HW?)
>
> For example, when ThreadA's tid is 0x1100, then the 'oldval' in the
> stack is 0x11c1 (ThreadB's tid on another cpu). When ThreadA's tid is
> 0x1000, then the 'oldval' is 0x1057. So it seems not bit-flip between
> these 2 different values. Which value do you mean is bit-flipped?
>
> > - Do they always contain the same pattern (if yes, then
> > buffer-overflow? Add "guard-bytes" around the struct and attempt to
> > reproduce the behaviour)
>
> At least on one occurrance, the variable at the address
> (&(mutex->__data.__lock) - 8) (a global variable save the value of
> sysconf(_SC_NPROCESSORS_ONLN)) is correct, i.e. not overwritten.
> (&(mutex->__data.__lock) - 4) is a *fill* (i.e. actually not used) and
> the value in coredump is 0. And according to the coredump, the
> mutex->__data.__kind (its address is behind the
> &(mutex->__data.__lock)) is also correct. I could not add guard-bytes
> in the struct pthread_mutex_t, beause the glibc is included in the
> toolchain provided by third party.
>
>
> > Slightly tangential.
> > Have you checked for any unpatched HW errata in CPU, cache controller,
> > memory controller
> > that can cause writes posted by the CPU to be lost in some rare scenarios?
>
> I'm asking for the latest version of the errata.
>
> I'll update you if there's any progress.
>
> B.R.
> Yimin
