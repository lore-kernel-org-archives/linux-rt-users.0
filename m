Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B12C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jun 2022 09:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiFXJTs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 05:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiFXJTr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 05:19:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5289462C0C
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 02:19:46 -0700 (PDT)
Date:   Fri, 24 Jun 2022 11:19:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656062384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cx+bQTWtoAOD6jl0yOfLYrwaIzxse7M0gbo3RmLJABY=;
        b=Pb+MsIIDqUKkXVNbhOORzma45mFUYiGle+58JysnHTNIKr1chIkeP83z3g4QaIoj/D/A+f
        Xm8qqOMet0Lpmoi2HvYuwC63I1GD4S1pXREEX6LCK9BPYRD9PgFdvX25bA/xEaAwwopdV0
        zHq4VVRtbAdHbkTrOE2rTZxYC3Ty51Juv4YevU1j6lFlHl3+LWY4wHgv82c0lO0Jf6QUKX
        6tud+I8uPMadX1VoPOi7HCrEN89t45Tya3wXhgdpL5/yxJfVgWoF+wCB38BWCVsYlog1Vj
        gvlu4L0tdMtgkGArWwSDXA/Ux0pt05CZ5N5GhSXzInJP3LiN64nzXdW15g36gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656062384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cx+bQTWtoAOD6jl0yOfLYrwaIzxse7M0gbo3RmLJABY=;
        b=hC+SLgl9Cv63kcq/eUHSnjrN065mhODgeeZglfi5EnowcuC9r2AldXh4MP+BhIQ/zfQoc5
        IteyQE5yURun44Ag==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marco Elver <elver@google.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        RT <linux-rt-users@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: v5.19-rc2-rt3: mm/kfence might_sleep() splat
Message-ID: <YrWBr+jiFyZRLufc@linutronix.de>
References: <bf74019da22b3c6a750153cbc74ffe3fcdb0ddf7.camel@gmx.de>
 <YrV+Vu47VDGDQpx8@linutronix.de>
 <CANpmjNO+4uHo8sECw4e+hANQSHP+5UmFrZ2TgeRCsu2iuowYfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNO+4uHo8sECw4e+hANQSHP+5UmFrZ2TgeRCsu2iuowYfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-06-24 11:10:55 [+0200], Marco Elver wrote:
> On Fri, 24 Jun 2022 at 11:05, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2022-06-18 11:34:51 [+0200], Mike Galbraith wrote:
> > > I moved the prandom_u32_max() call in kfence_guarded_alloc() out from
> > > under raw spinlock to shut this one up.
> >
> > Care to send a patch? I don't even why kfence_metadata::lock is a
> > raw_spinlock_t. This is the case since the beginning of the code.
> 
> Because kfence_handle_page_fault() may be called from anywhere, incl.
> other raw_spinlock critical sections. We have this problem with all
> debugging tools where the bug may manifest anywhere.

Oh thank you. I had some vague memory of this but could find anything.

> A patch for it already exists in -mm:
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-hotfixes-stable&id=327b18b7aaed5de3b548212e3ab75133bf323759

Thanks for the pointer.

Sebastian
