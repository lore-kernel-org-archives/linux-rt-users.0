Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECD9C2BBD5
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 15:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768D423B74
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 15:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgLRP6O (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 10:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgLRP6N (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 10:58:13 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87286C0617A7
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Dec 2020 07:57:33 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id i67so2348425qkf.11
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Dec 2020 07:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=HBxf9PKqkK+It1gDYh3z+SAdCdClUJG4VnyLSsXzXeg=;
        b=Ns5vR/xuEXNMs4xFbKN8gst4VA3k/j0w/fPHrxnej40T6Ncg8ltXraRL4efzHSOKNw
         SHBgI0FhREVk+jpkItEay+eHb51aeV8SAaOWmu7hkRhstC1WhU70ffQ4GRZ68BpkfCKv
         Lo8tvs6ln1eURT1E4Jkar9UvL8wkJvSpIx478BrxQOmukzCLrDQclAKb924lMxc50Wqb
         lWoqXyTcYhfGqdswEpn6dw+8DGhdO9VoR1ViA1NiNJZjCA9pM1XUEXJPIfEgzQZdP9PM
         IpTB5X9S8GDbCpjQ+W7/1fxjTgfxedsandAJSFjVCJT7R9danWb+hvjHkFuve3hqwqCB
         clCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=HBxf9PKqkK+It1gDYh3z+SAdCdClUJG4VnyLSsXzXeg=;
        b=USHRWMkQ7ueu6xP47wNSQedDTU/5LFdZekg5OEpBHPu21xyQKa0imVuWPIUewsvXbA
         +eG148Ar887Xy10vcoxPzN05lUMelFjYMI89TVqCu5nhDicfdN+hOWe4J0kSBEIi9MnA
         JIHXIsW461Rlo0ayTg9le2z+q/dKEaRLu9vmHdNIMfSJmwbZCl0FDRqdGBWW2YaDhVfg
         UhWi+AMBcy8m+hslkDx+dKwonLCQpGa+MfBFUL8BCrJM8CpgTSQLXQP6gbFf/l9mN5vf
         i9rnMnqX3uVeg4mLmbqnCmzaQkPRF8mLkvLc59DAc/LS9jkxUwv4lhZYIMSea3iDsixx
         Xt/g==
X-Gm-Message-State: AOAM531nc6iN3sxwSTp3fO71ouIWvEfA9+FecNSvNBkpfdWYSdrhqWTM
        SHE8EIcW9S8p/Jw+Dc4IK+U=
X-Google-Smtp-Source: ABdhPJzACpIua+MSjHMrbwWAoTyW33+8JzqHqm8Q976B+BhQKZZQDVfWdqncP1PIaBMaatSX08WJnw==
X-Received: by 2002:a37:a7d0:: with SMTP id q199mr5443802qke.217.1608307052693;
        Fri, 18 Dec 2020 07:57:32 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id o4sm5213034qkc.93.2020.12.18.07.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 07:57:32 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 18 Dec 2020 10:57:22 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 0/6] libnuma cleanups for cyclictest
In-Reply-To: <20201218141935.24151-1-dwagner@suse.de>
Message-ID: <68c0b159-9460-4041-ba65-9cbc28b6a842@redhat.com>
References: <20201218141935.24151-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 18 Dec 2020, Daniel Wagner wrote:

> As we have a hard dependency on libnuma we can simplify the code in
> cyclictest. This allows remove all the small helpers in rt_numa.h. And
> with this we can remove the header and reduce the confusion with
> rt-numa.h

This is why I asked you to keep numa functions separate from any common
library. The reason the file exists, is in the past I had two versions
of each numa function, one for architectures that supported libnuma, and
empty wrapper versions for ones that didn't. This implementation detail
was pushed up into that header file, to make the code cleaner. Then all the 
architectures that we cared about seemed to support to libnuma so I 
removed the versions of the functions that were empty, so we were at the
point that the header file could just be removed, but I never got around
to that and things just worked fine. So thank you for doing this, but, 
there is always a but right?

There are two buts. The first one, is that I see the other programs in
the test suite that mimic cyclictest behaviour are getting more attention,
so I could imagine as we try to strengthen their behaviour that we could
add numa support to these programs as well. The other but, is that I'm 
seeing the need recently to add support for a lot of architectures that
we didn't care so much about in the past, and not all of them have libnuma
so we might want to do the same trick as in the past, add wrapper versions
in a header file.

So I propose, we take your patches to get rid of the file, because it will
clean things up a lot, but then we may have to go back to creating 
something like the rt_numa.h file anew. Removing rt_numa.h first is good 
though, because if we don't have to create it anew the code has been 
cleaned-up, and if we do recreate it from scratch, it will be better for 
having cleaned-up how numa works in cyclictest

> 
> While at it, I simplified the --smp vs --affinity vs --threads
> logic. There is no need for additional variables to keep state. With
> this we also make --affinity to behave as with the rest of
> rt-tests. That is a plan -a will be the same as with -S. There is no
> need for -S anymore but I think we should leave it in place for
> backwards compatibility. I suspect, there must be a lot of muscle
> memory out there :)

This is also an example of something that was evoling in exactly this
direction. When Thomas wrote cyclictest, it made sense to have smp, but if
I were to rewrite everything from scratch I wouldn't have it there.

Some more background, we used to have to specify numa, but we changed it
so that numa was detected automatically, but you could still specify
smp if you wanted to test that behaviour. This also helped
simplify the alphabet soup of options by removing --numa.

Note also that smp isn't just a kind of hardware for cyclictest, you 
can still see this is the help - it gathered up the -a and -t options
and put all threads at the same prio.

So, thanks again for doing this. A word of warning I spent a long
time fiddling with affinity to make it finally work correctly, so
I'm going to test the sh*t out of your changes to make sure they don't 
break anything before I accept them.

A final comment, the idea of an "unstable" devel branch,
the "unstable" refers not to the code being iffy, but to the fact
that I wanted developers to feel free to break the old API, and not be
constrained with backwards compatability, so as you clean this stuff-up
if you want to remove -S, it's fine with me. Hopefully if we take away
anything that users want they'll yell at us, but I think we're pretty
careful about necessary functionality. Maybe after things are cleaned-up
we will have to add a new flag to specify the same prio for all threads?

I also maintain the rteval program which uses cyclictest for measuring
performance while running loads, changes to the cyclictest API sometimes 
require me to tweak how rteval works. Nobody has ever told me about any 
other programs that use cyclictest. Anyway, changes to the cyclictest api
have to be synced with rteval. rteval has develped in the background to 
this community and not received much attention here before, but, well, 
thinking about how that might change.

I think I'll spin off a new version of rt-tests before accepting this
set of patches.

John


> 
> Daniel Wagner (6):
>   cyclictest: Always use libnuma
>   cyclictest: Use numa API directly
>   cyclictest: Use affinity_mask for stearing thread placement
>   cyclictest: Mimik --smp behavior with --affinity
>   cyclictest: Simplify --smp vs --affinity vs --threads argument logic
>   cyclictest: Move verbose message into main
> 
>  src/cyclictest/cyclictest.c | 154 ++++++++++++++----------------------
>  src/cyclictest/rt_numa.h    |  98 -----------------------
>  2 files changed, 58 insertions(+), 194 deletions(-)
>  delete mode 100644 src/cyclictest/rt_numa.h
> 
> -- 
> 2.29.2
> 
> 
