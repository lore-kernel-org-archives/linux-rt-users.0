Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA619C77B7A
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 May 2023 16:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjESQPf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 May 2023 12:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjESQPY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 May 2023 12:15:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E5D1739
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 09:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3997C65918
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 16:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC7AC433A7
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684512891;
        bh=988teLj5W0j+8ljOROZpxXdrHWFLmSBJbPvaUIZMBVA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wp0IghWgM8/ldoJyW4W8QhLYvyVXHawvz9ArAJ3ZEYGzHZdvpJMIXzR5tYtMzCceE
         aPTZbV80mEsaEbQX2xf59mNgA23cjRuSXBL9DdbJgNdfPRA0CbPchONJj2vgKANsAV
         nci8Ho4tBZqXNQx623OWmz0M82s2YKql9fIQROvUi4Lz0U1YpwkZzGezafdqcdBtSY
         lTGKolZfUT6jQ6Z9lHKIv0jVjN1FMh22zobKAxH7kS74Mh+emzcIueuxcrf2F9L/8C
         3u3AGZTIvPwY5GSg6UeuWvkwwm1kkJkDjltfEr0b61VhCf/daRT6kYlEy/oxfINI+3
         +EEt3YCO75ZtQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f3b337e842so342744e87.3
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 09:14:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDx3on5D5B4HtA6rUDu4wza6sYdme13Aiaqq9vPyGHH9QtyFX79H
        uinpUbwQio0CXLSk1ayYm/2ZN5fhTNqYLyyCblI=
X-Google-Smtp-Source: ACHHUZ6qYBWlD2Jt7D55zF+56AadifRS58yYSdHpTrXnjuPVQUJY/vWMAZxdkcudfYIzcjyFd1jzMKDk8CbYfyd8bwQ=
X-Received: by 2002:ac2:5331:0:b0:4ef:d573:c8a9 with SMTP id
 f17-20020ac25331000000b004efd573c8a9mr897245lfh.4.1684512889611; Fri, 19 May
 2023 09:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXFVutgNLYWpsM1QvrLBWsoNoSSEAK-oJKGL6bEqrh=nDg@mail.gmail.com>
 <20230519145731.574867-1-bigeasy@linutronix.de>
In-Reply-To: <20230519145731.574867-1-bigeasy@linutronix.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 19 May 2023 18:14:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFGfmCNJGgCV+St7B--08moBF=QzbH=qELE6XKaKdA0RQ@mail.gmail.com>
Message-ID: <CAMj1kXFGfmCNJGgCV+St7B--08moBF=QzbH=qELE6XKaKdA0RQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: vfp: Fixes for PREEMP_RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 19 May 2023 at 16:57, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Hi Ard,
>
> On 2023-05-18 00:05:33 [+0200], Ard Biesheuvel wrote:
> > Don't let me stop you :-)
>
> made a small series. It seems to address everything and with your
> assembly rework it is not a big mess.
>
> What do you think?
>

This looks reasonable to me - thanks for taking the time.

However, I was about to hit send on my PR to Russell for the following series:

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm-vfp-softirq-fixes

which moves all of the VFP processing to C, and so this is going to
conflict at the very least, but also provide a cleaner base for patch
#2 in this series.

Also, aren't there a few other places in the VFP code where BH are
disabled and enabled again? Do those need the same treatment?

Thanks,
Ard.
