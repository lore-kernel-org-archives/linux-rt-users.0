Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D52AC433FE
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 Oct 2022 13:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJCNGs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 3 Oct 2022 09:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJCNGr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Oct 2022 09:06:47 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB42A31EC4
        for <linux-rt-users@vger.kernel.org>; Mon,  3 Oct 2022 06:06:46 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id o123so12993068yba.0
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Oct 2022 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/FwfnYsBWW5yupAorqKilHEi/Pz/u6tVRbH9nfKNqL8=;
        b=Ne1nKvjyTIT//Fw7H1jYtZvzyBuIDG9GUZm7du1V88tgJrorxJ70bR7P9rq29bv4Qg
         umY8JAC2dxtfifRb6XyvHn8TEZzg/duqwdjfG8wm5zj8Q2Qokb4BqTMAc+qElyBdttuZ
         91ijyDoEvqMg1ogM6/HzoBhXkJob4UArc7y5mAyZJ8L93aNnLUFjeMS+ArYnynKV902F
         6SIRNuHhB5LLdtML6tdSvhhLej7IADe0M9tr2/WrBmDesfO5giHBl7zDNnbEcx7ctJ7S
         pZb0NV6ryaHgW0s0k5xZevEouEivYbQ62jVR5R40EUnHBgablTY9urxricGWbEILEELD
         bkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/FwfnYsBWW5yupAorqKilHEi/Pz/u6tVRbH9nfKNqL8=;
        b=ase7fYhAskttsH36jmBUtft1q/GsKtUdIzwpwLuSnYcZioTdvfxLA1bIRXFwTR+tIC
         N8h+XcUCHguSbIlrGqxLsy4WzunoFbQ5hN/k3t03b/oS6XRs5l37YNwDyFr2UiItYzEH
         yve+lhkGPJwO6L6C6nVWMkN1Uh1BLeCADt1BWPWH7hwarUszGDK1o4YOU4eiU2ficnGz
         /oG8R3JeiqxblZggpc+CrJ90KOFO/K690HRcXWdG95yGoOJc5RvPAcfTW8OeevRNbopQ
         ei9u4KEqisY1+Ke5zzfiSX7QIB3N+PbbR1cKHgy708toxV+iuijd1UziynCGJIlYeNgl
         wWKg==
X-Gm-Message-State: ACrzQf0GMKF7ymrg5gVjCjRTvUFshW60ZLoCoIihrhAoDelGjlczzi5X
        MO9jUETfi5zkxnUkvOYn4dJeUITTVHgLyLZHL6mYObU3evo=
X-Google-Smtp-Source: AMsMyM6gtIOoucJEAAGtQMN4AnKOSTkxSbRUuI3JLNwxBYrubpQf49cAU/slNSEghtWqVC4tli05b7dCIr608YBYETs=
X-Received: by 2002:a25:b87:0:b0:6bc:f027:e4ac with SMTP id
 129-20020a250b87000000b006bcf027e4acmr14149869ybl.595.1664802406164; Mon, 03
 Oct 2022 06:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAEYdEeSpYW3wS=yXtsa9C0e-LmZDXNZ=AP3z33FYZKsgU7XcxQ@mail.gmail.com>
 <CAMLffL_49B2DEgTiDPg3vwL5gR-Dagvo-OBbymrBapgBJifnkw@mail.gmail.com>
In-Reply-To: <CAMLffL_49B2DEgTiDPg3vwL5gR-Dagvo-OBbymrBapgBJifnkw@mail.gmail.com>
From:   Brian Wrenn <dcbrianw@gmail.com>
Date:   Mon, 3 Oct 2022 09:06:35 -0400
Message-ID: <CAEYdEeSC=trHvAcPjN+35mF+gd_c4Bj9dVK-D9BkLM7U3gUUrg@mail.gmail.com>
Subject: Re: Abort on boot for 5.15.7 patch RT 23
To:     Clark Williams <williams@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Clark,

just to confirm, yes, I'm using 5.15.7-rt23.

Thank you,
Brian

On Fri, Sep 30, 2022 at 9:15 PM Clark Williams <williams@redhat.com> wrote:
>
> First question is, which version of the PREEMPT_RT patch did you use?
> For v5.15.7 you should be using the series released back in December
> of 2021:  v5.15.7-rt23.
>
> It looks like things went bad when booting the RT kernel while
> initializing the cpuidle driver.  I'm suspicious of the nested locking
> done in the genpd_* functions (and how they work with rtmutexes).  If
> I get some time next week I'll see if I can make sense of the locking
> done there.
>
> Clark
>
> On Fri, Sep 30, 2022 at 3:44 PM Brian Wrenn <dcbrianw@gmail.com> wrote:
> >
> > Hi,
> >
> > I am building a kernel from source derived from Linaro 21.12, based on
> > linux kernel 5.15.7.  It runs on a Variscite DART SD410 dev board.
> > When I build that kernel, it will boots successfully.  When I build
> > the same kernel source with the PREEMPT-RT patch, it aborts during
> > boot.  I attached console output for each case.
> >
> > An incompatibility between the Variscite patches and PREEMPT-RT could
> > cause this abort, but just to cover all my bases, I'm try to rule out
> > the PREEMPT-RT patch itself.
> >
> > The call trace includes RT specific routines, so I'm wondering if
> > there are any known problems with routines in this call state, and if
> > any fix for them exists in some way applicable to the v23 patch.
> >
> > Thank you for any information or leads.
> >
> > -Brian
>
