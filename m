Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8092C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Mar 2022 18:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbiCISX1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbiCISX0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Mar 2022 13:23:26 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C422574B5
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Mar 2022 10:22:27 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id c11so2646320pgu.11
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Mar 2022 10:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=y2GMrSFWjX8zwjQO8mqaFsTCAy39LnOsJAbSpdJbfyw=;
        b=TzK4xf5a2832vs1doKmVzvpR8wdLbUfwJ1HKFv3u1OlYZbPdhEHgzqqjAol6iMtyod
         x/EvCHexxTKI/41qEnLe9UflPFTCXhj15+iNkCvTK7u9REe26KWeFNL+RCmWTRNcZKlS
         kvBMjl8cZFI1yOk/nfz7UfWkxcpEeFoYkm3XUfjxYvh72EDJA6si9nw25OwPO/KINBB5
         MgrfAvJpESYxqOBdphD64sNAvPgKQ0G79ezrv6cy28KVxpYq67R8qsz9Nv3oz1JLFJSG
         Sx+6qoEIIU2LErcWIv3IKrcpjVL+77Xod4506FVCC2enU00fsRHC3SS/Y6VEQ/lesovr
         eG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=y2GMrSFWjX8zwjQO8mqaFsTCAy39LnOsJAbSpdJbfyw=;
        b=XE5OI2TuPD+JEFQpluS+hSGSmtTgSHYssbL/hrEKiU6dt00FMCwSdjDgENoGroZ8hN
         6y3uDIE9ERpLJx9XLrmOH7auT5Y0U/R284LVx++/gbZ1J1bxnd2wUWfcTCpvRsHhXa2B
         OYpe6IjDoadrj8NoF0v9enrH7WnFvs2dWLw+JLq+ndAQezX4unUaxXsII0RS1Xt/6TlK
         l6mC/Ft4C0UpDa1jmLVm4zQJTS8+ZGzPcPWC7kpovPjTjt6tDi0fFIjNePSgY3WLUy/v
         OBNBrqEBRJoFmGYF9SReQHPdCHRFmx/0D/6UsU8lJ8NTfOnf1has7nwIG36MWEWsg9rc
         aM9g==
X-Gm-Message-State: AOAM533HR/DxhQyOHbTWy5aCrUMqqA9yBxPCDmwR4xVoraMtDX3rGg+h
        RLJ4uu7GvX+snpobiEKBjQXzHyoqd7XVKsVw55KLge4d
X-Google-Smtp-Source: ABdhPJzCi0uIhgeD0vKotyiRcHiJ4Omt0hOPGaUWa4O6BIGCSLqYlqXuoVuopWz+7MjCb0vGHgFvecuEr/2nk4T3dys=
X-Received: by 2002:a05:6a00:a23:b0:4f6:72a8:20c7 with SMTP id
 p35-20020a056a000a2300b004f672a820c7mr831977pfh.12.1646850147097; Wed, 09 Mar
 2022 10:22:27 -0800 (PST)
MIME-Version: 1.0
References: <2658635.4HAHC1xCac@coyote>
In-Reply-To: <2658635.4HAHC1xCac@coyote>
From:   Arve Barsnes <arve.barsnes@gmail.com>
Date:   Wed, 9 Mar 2022 19:22:15 +0100
Message-ID: <CAJjrzcUo_30mZAuWVN4W2WK=WcoFC_55_Lq5y7YxdjD37US_YA@mail.gmail.com>
Subject: Re: dirty-pipe ?
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 9 Mar 2022 at 19:16, gene heskett <gheskett@shentel.net> wrote:
>
> Greetings all;
>
> Is this kernel vulnerable?
> 4.19.71-rt24-v7l+ #1 SMP PREEMPT RT Thu Feb 6 07:09:18 EST 2020 armv7l
> GNU/Linux

No, the vulnerability was introduced in kernel 5.8

Regards,
Arve
