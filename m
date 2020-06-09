Return-Path: <SRS0=w7Cs=7W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CD5C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 16:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEF020737
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 16:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7zMLyWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbgFIQhO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgFIQhO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Jun 2020 12:37:14 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75BAC05BD1E;
        Tue,  9 Jun 2020 09:37:13 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p18so16877847eds.7;
        Tue, 09 Jun 2020 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zdFQXbi2jEnzDpG2Ck8q/HnYKsfdUw2+F8QDngmiKQ=;
        b=F7zMLyWYpJ0qmKz+GeJ8kzlkQLNweXPH3lYQ3OLqYB9IEd6nAHwM93vCkSCT/J2mwy
         CoAbk+b3GcZtPKv6BbLKI7uMDPlJyXeoFnxAtJlf+uF8OBfNtA8yXOJD3X2zZ+gTriLc
         OzXmowP4hnAVOXgtrQjqiqKJaTKDK3nBWYWqYeQaf6VkvwCqNItr1g8fszQLXIKFIlUn
         +SSNNz954OkC8Ygsh51E19fERojpf9iuhRn7DUsDzVksGdKh5x/pYAliLQkmiz9XnEnz
         O+dai0+0Dn/4yVopePQ/OHo8tWZJMqYww3M45BM+at/fuURJQYn12r3lOroLSgh+ra+2
         hQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zdFQXbi2jEnzDpG2Ck8q/HnYKsfdUw2+F8QDngmiKQ=;
        b=f1Nu3sZ+KXh3i9iRTu5+pa07NvETUsbKTdUU5KWWLeqMeKsbaV2AngekaTiAEXwRwx
         zu6tracSEvlJPVXSwpm3PmItHHQ49FC6S/njdlMNnniIRSp9eKcVXFwkQjphTPxtb/Tu
         xQQq2g3At/ozNUcTH/Y/MMm1W6AV2LdbGHntu7E87F9wgrrMIqwvMe0EQ2K39SUMxXeY
         vzYtk2NoRg56eUBiASIhhMGdJQmPirg/WpOtZHAo2BqIQ3MQli4z0f1yyPYqSxvDVnhm
         oIzxYmCJkiruePzD3D5Pzz8SxnPiUG71xzyRW+8fMyln0MTqtciEi3OqBAbXI4Gx3C59
         vq9g==
X-Gm-Message-State: AOAM530x06dqBWiWcLtqGwTERU/p20UMrseoHtM7dvGez+2ifmDjAgV1
        grfWHJzcu8eC/RNOAE0976vtGTVw2vCQQUuvyqZLNw==
X-Google-Smtp-Source: ABdhPJzjhIrhG02sLXKCQeDwvpfszTZfG+GusKIqD8JJbVajGJXm9pQ5UE8RyspvJq7mJWNrACAsTL/ckSKiRRplnn8=
X-Received: by 2002:a50:fb0b:: with SMTP id d11mr28358326edq.118.1591720632648;
 Tue, 09 Jun 2020 09:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <4781d250-9a29-cef3-268d-7d83c98bf16a@gmail.com>
 <87wo4lekm5.fsf@kurt> <CA+h21hqbKasMAuHL+B-2Gb-YQ3QGF+_pWGCxr8LTcusjvuqFeg@mail.gmail.com>
In-Reply-To: <CA+h21hqbKasMAuHL+B-2Gb-YQ3QGF+_pWGCxr8LTcusjvuqFeg@mail.gmail.com>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Tue, 9 Jun 2020 19:37:01 +0300
Message-ID: <CA+h21hp+UsW+Uc-xHyQAMrRVLX9CXZu8B2Svq+9npLtxs0_DWw@mail.gmail.com>
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

On Fri, 5 Jun 2020 at 16:19, Vladimir Oltean <olteanv@gmail.com> wrote:
>
> Hi Kurt,
>
> On Fri, 5 Jun 2020 at 15:57, Kurt Kanzenbach
> <kurt.kanzenbach@linutronix.de> wrote:
> >
> > Hi Vladimir,
> >
> > On Fri Jun 05 2020, Vladimir Oltean wrote:
> > > Hi,
> > >
> > > I was testing stress-ng on an ARM64 box and I found that it can be killed instantaneously with a --hrtimers 1 test:
> > > https://github.com/ColinIanKing/stress-ng/blob/master/stress-hrtimers.c
> > > The console shell locks up immediately after starting the process, and I get this rcu_preempt splat after 21 seconds,
> > > letting me know that the grace-periods kernel thread could not run:
> >
> > interesting. Just tested this on an ARM64 box with v5.6-rt and the
> > stress-ng hrtimer test works fine. No lockups, cyclictest results are
> > looking good. So maybe this is v5.7 related.
> >
> > Thanks,
> > Kurt
>
> This is not actually v5.7 related. I could also reproduce it on a
> downstream 5.4 kernel which is how I originally saw it.
>
> Thanks,
> -Vladimir

Just out of curiosity, what and how many CPU cores does your ARM64 box
have, and what frequency are you running them at?
Mine is a dual-core A72 machine running at 1500 MHz.

Thanks,
-Vladimir
