Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3560DC4361B
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E142395C
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgLRQlx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:41:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:52310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgLRQlx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 11:41:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9EA7BAE12;
        Fri, 18 Dec 2020 16:41:11 +0000 (UTC)
Date:   Fri, 18 Dec 2020 17:41:11 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 0/6] libnuma cleanups for cyclictest
Message-ID: <20201218164111.i4v55ld5vyyj2uzb@beryllium.lan>
References: <20201218141935.24151-1-dwagner@suse.de>
 <68c0b159-9460-4041-ba65-9cbc28b6a842@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c0b159-9460-4041-ba65-9cbc28b6a842@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

On Fri, Dec 18, 2020 at 10:57:22AM -0500, John Kacur wrote:
> On Fri, 18 Dec 2020, Daniel Wagner wrote:
> 
> > As we have a hard dependency on libnuma we can simplify the code in
> > cyclictest. This allows remove all the small helpers in rt_numa.h. And
> > with this we can remove the header and reduce the confusion with
> > rt-numa.h
> 
> This is why I asked you to keep numa functions separate from any common
> library. The reason the file exists, is in the past I had two versions
> of each numa function, one for architectures that supported libnuma, and
> empty wrapper versions for ones that didn't.

This is what I figured as well. So with the decission to have the
dependency on libnuma a lot of things can be simplified.

> There are two buts. The first one, is that I see the other programs in
> the test suite that mimic cyclictest behaviour are getting more attention,
> so I could imagine as we try to strengthen their behaviour that we could
> add numa support to these programs as well.

Indeed, this is what I hand in mind too. Parsing the --affinity string
should be done with the libnuma. One thing we could try to achieve is to
common parser options so that we only have one function for it. Not sure
if this would be possible though.

> The other but, is that I'm
> seeing the need recently to add support for a lot of architectures that
> we didn't care so much about in the past, and not all of them have libnuma
> so we might want to do the same trick as in the past, add wrapper versions
> in a header file.

I am sure with rt getting closer to mainline there will be more interest
in the tests. I'd say we should rather get libnuma supported on those
architectures instead of trying to work around here. Debian says
libnuma is available on

 - alpha
 - amd64
 - arm64
 - armel
 - armhf
 - hppa
 - i386
 - m68k
 - mips64el
 - mipsel
 - ppc64
 - ppc64el
 - riscv64
 - s390x
 - sh4
 - sparc64
 - x32

Which architectures is missing?

> So I propose, we take your patches to get rid of the file, because it will
> clean things up a lot, but then we may have to go back to creating 
> something like the rt_numa.h file anew. Removing rt_numa.h first is good 
> though, because if we don't have to create it anew the code has been 
> cleaned-up, and if we do recreate it from scratch, it will be better for 
> having cleaned-up how numa works in cyclictest

Yes, that was my whole indent of this series. First to cleanup the
current rt-numa.h code as much as possible before we adding new stuff.

> This is also an example of something that was evoling in exactly this
> direction. When Thomas wrote cyclictest, it made sense to have smp, but if
> I were to rewrite everything from scratch I wouldn't have it there.

That's why I opted to make '-a' a bit more powerful :)

> Note also that smp isn't just a kind of hardware for cyclictest, you
> can still see this is the help - it gathered up the -a and -t options
> and put all threads at the same prio.

This hasn't changed. So you can place N threads evenly placed on the
provided cpumask. Not sure why I want to have more threads on the CPU,
but well, it's supported.

> So, thanks again for doing this. A word of warning I spent a long
> time fiddling with affinity to make it finally work correctly, so
> I'm going to test the sh*t out of your changes to make sure they don't 
> break anything before I accept them.

Please test it carefully. I tried not to breaks it but I wouldn't be
surprised you find something.

> A final comment, the idea of an "unstable" devel branch,
> the "unstable" refers not to the code being iffy, but to the fact
> that I wanted developers to feel free to break the old API, and not be
> constrained with backwards compatability, so as you clean this stuff-up
> if you want to remove -S, it's fine with me. Hopefully if we take away
> anything that users want they'll yell at us, but I think we're pretty
> careful about necessary functionality. Maybe after things are cleaned-up
> we will have to add a new flag to specify the same prio for all
> threads?

IIRC, Debian was not particular happy with the option getting dropped
within a major version. So it's not just rtval using it. Also there is
LAVA's test-definitions (which I use) but this shouldn't be a real
problem as it's easy to update.

Though as said, distros are not happy if we change the existing
options. Given that it's not a real burden to keep -S around I would
just cary around until we have a real need for it to go.

> I think I'll spin off a new version of rt-tests before accepting this
> set of patches.

Good idea!

Thanks,
Daniel
