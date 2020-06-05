Return-Path: <SRS0=m88/=7S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AFCC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jun 2020 13:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 212EB206E6
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jun 2020 13:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfuK+UVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgFENUM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgFENUM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Jun 2020 09:20:12 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA49AC08C5C2;
        Fri,  5 Jun 2020 06:20:11 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n24so10099793ejd.0;
        Fri, 05 Jun 2020 06:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v47Il7vhv7sHVs8oOXJuoJtKJwqprhyn7oIEIBkCU74=;
        b=vfuK+UVDgp02YsTy1Z0t1Haq+q1Hb9iQe8Kho+Ga7o+s+tlF+Zpt8165HykwEhhM/H
         8koxSxNTJPHYCxMVGVteX3p2pFGq3wLkmtU1HobyOiB4kbaFEISyilYEVAVNLyo8Vrts
         HVgwcHK8JY42pX21Cw3KdozE7Ql/096/eoncMWbMC3/z+SaTYOGHQdvfdC1SnH7v1lz6
         2R6tUn52hQd4lNpOWyhouSKei9j/cn0SFG2+qRmmpW0iYsznOMap+r6hwaBuI1E3AI2N
         sO1J019qtXoK+I5JqJe9XFPMWHrptUw9CM5kokoB+rmPnpeX2z9hfoPIcSA6+Ylvg3Jn
         IadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v47Il7vhv7sHVs8oOXJuoJtKJwqprhyn7oIEIBkCU74=;
        b=B7LslWIoPqOjeJcyclo/uRhN0M+stQvTN2i2iXoyrCbh3knAarlblr39wmJTRQumVD
         v9OoLVQ641Ru5NESt1+veGq/pEJSx+tPNJT+3GL9w3RFCn9rTW0nIFP0LHQMgIKmLNbY
         +t47yH7KV8vKtwC2Il+pl3IIco+NE7ILhmSWOgDWw0nRvm8sV+ZXKFaG5HBUABvyioEg
         aiO008RfxUBGLxSw4E66ANzfsL5eShsAXiQOWskZ/iQKQIIG39Upby6kuFq3TbSvKnrl
         62ssccsIWVs7rdnyIagiefdUKkTgB4XGTWmCk07u8Si5wmgGhYuRLHSTC75EFcqk/lzc
         nOgQ==
X-Gm-Message-State: AOAM531K3OVcc4/q8G6+TTppXBznaaHAfQwCuTn6ERqgUj1VNP3BK5Lc
        1A+UJZUxMEsNKCGa8SLchPWFtjz8aqPvniBbsPcNNg==
X-Google-Smtp-Source: ABdhPJx0a4RRvx48K6OMYFjpT5V8FKLA/03O6HWnvHyKo+y+5Pqtm4EjQEUvmL9i5Cmk94QgBTiaF5VZkYlW/Hv1PDs=
X-Received: by 2002:a17:906:af84:: with SMTP id mj4mr8339543ejb.473.1591363210450;
 Fri, 05 Jun 2020 06:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <4781d250-9a29-cef3-268d-7d83c98bf16a@gmail.com> <87wo4lekm5.fsf@kurt>
In-Reply-To: <87wo4lekm5.fsf@kurt>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Fri, 5 Jun 2020 16:19:59 +0300
Message-ID: <CA+h21hqbKasMAuHL+B-2Gb-YQ3QGF+_pWGCxr8LTcusjvuqFeg@mail.gmail.com>
Subject: Re: stress-ng --hrtimers hangs system
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Colin King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Kurt,

On Fri, 5 Jun 2020 at 15:57, Kurt Kanzenbach
<kurt.kanzenbach@linutronix.de> wrote:
>
> Hi Vladimir,
>
> On Fri Jun 05 2020, Vladimir Oltean wrote:
> > Hi,
> >
> > I was testing stress-ng on an ARM64 box and I found that it can be killed instantaneously with a --hrtimers 1 test:
> > https://github.com/ColinIanKing/stress-ng/blob/master/stress-hrtimers.c
> > The console shell locks up immediately after starting the process, and I get this rcu_preempt splat after 21 seconds,
> > letting me know that the grace-periods kernel thread could not run:
>
> interesting. Just tested this on an ARM64 box with v5.6-rt and the
> stress-ng hrtimer test works fine. No lockups, cyclictest results are
> looking good. So maybe this is v5.7 related.
>
> Thanks,
> Kurt

This is not actually v5.7 related. I could also reproduce it on a
downstream 5.4 kernel which is how I originally saw it.

Thanks,
-Vladimir
