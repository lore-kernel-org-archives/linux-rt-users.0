Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31960C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jan 2021 03:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76B3206B9
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jan 2021 03:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbhA0Dyh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:54:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:39258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388940AbhAZRNu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 12:13:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D83EFAC97;
        Tue, 26 Jan 2021 17:13:08 +0000 (UTC)
Date:   Tue, 26 Jan 2021 18:13:08 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 4/6] cyclictest: Mimik --smp behavior with
 --affinity
Message-ID: <20210126171308.afyjb3x5jngbhm56@beryllium.lan>
References: <20201218141935.24151-1-dwagner@suse.de>
 <20201218141935.24151-5-dwagner@suse.de>
 <f273ca2-e80-7713-7caa-6dff464d388@redhat.com>
 <20210126083722.tpyy4jsv25sqzsnk@beryllium.lan>
 <c834b380-8b7b-9bac-4221-e95d69a0dfd0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c834b380-8b7b-9bac-4221-e95d69a0dfd0@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jan 26, 2021 at 11:32:25AM -0500, John Kacur wrote:
> Not necessarily, but you want to limit where the threads, no matter
> how few or how many run. As I said, it's not an unreasonable default,
> but it is not the current default of 1 unless you specify -t
> I suggest we stick with the current default in this clean-up effort.
> We can discuss if there are some better defaults after this effort is
> complete.

Understood. BTW, you can do '-a 1 -t' which will spawn N threads on CPU
1. So it's still possible to get the same setup.

> I haven't done a git bisect or something of that sort to determine if your
> patches broke it, but here's what I see. (running on non-rt laptop now, so
> ignore numbers), but it looks like at least the -t option requiring an
> argument existed before your changes, but your changes to affinity
> probably could use some more testing.
>
> The following is okay
>
> ./signaltest  -a1-4
> 2.00 1.52 1.14 2/1079 6541
>
> T: 0 ( 6537) P: 0 C:  14896 Min:      3 Act:    4 Avg:   26 Max:     366
>
>
> The following is broken, the default without an argument should be 2
> ./signaltest  -t
> ./signaltest: option requires an argument -- 't'

Right, this shouldn't be too hard to fix. I'll send an update.

> In the following note that threads other than thread 0 didn't appear
> on the screen until after the ctrl-c
>
> ./signaltest -t9 -a1-4
> 1.11 1.14 1.14 2/1075 6864
>
> T: 0 ( 6856) P: 0 C:   1649 Min:     38 Act:  511 Avg:  457 Max:    4911
> ^CT: 0 ( 6856) P: 0 C:   1660 Min:     38 Act:  554 Avg:  457 Max:    4911
> T: 1 ( 6857) P: 0 C:   1660 Min:     38 Act:  490 Avg: 1090 Max:   15024
> T: 2 ( 6858) P: 0 C:   1660 Min:     38 Act:  449 Avg: 1091 Max:   15053
> T: 3 ( 6859) P: 0 C:   1660 Min:     38 Act:  412 Avg: 1091 Max:   15075
> T: 4 ( 6860) P: 0 C:   1660 Min:     38 Act:  378 Avg: 1090 Max:   15081
> T: 5 ( 6861) P: 0 C:   1659 Min:     38 Act:  517 Avg: 1091 Max:   15072
> T: 6 ( 6862) P: 0 C:   1659 Min:     38 Act:  485 Avg: 1091 Max:   15067
> T: 7 ( 6863) P: 0 C:   1659 Min:     38 Act:  522 Avg: 1091 Max:   12832
> T: 8 ( 6864) P: 0 C:   1659 Min:     38 Act:  549 Avg: 1091 Max:   12839
>
>
> etc, it's broken in many ways.

I don't think I broke this. This is since I can remember the output
behavior. You only see the live update from T0, never the from the
helper threads.
