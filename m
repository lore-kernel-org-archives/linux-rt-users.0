Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435BCC49EA5
	for <linux-rt-users@archiver.kernel.org>; Sat, 26 Jun 2021 12:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC3761C2E
	for <linux-rt-users@archiver.kernel.org>; Sat, 26 Jun 2021 12:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFZMrz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 26 Jun 2021 08:47:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:41569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhFZMrz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 26 Jun 2021 08:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624711527;
        bh=8LHWMyoaHjAiRhzE3/yHqA0zS5lJDmkMRsc5koSzjMM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=fYz3Q/eLeUC3C6SkafFZ6Jh8EuDLMtW3fVh+WMt2s5X8OGG1TsOZfkDyQBKiWJA95
         /xEdYVETAnceienIQ+0Qo/TzZAUrUzgR4fEAQL93HfVgECkkfBzLpETR5/QuuZJ0s7
         A621/NM+b2SHICqdpeTdyBq3efiiXWJNlDT9lRiU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.49]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvLB-1lmzBK331p-00RtuJ; Sat, 26
 Jun 2021 14:45:27 +0200
Message-ID: <3d6a6c593eed6f5d59209ba2d8db29fadcc72ad7.camel@gmx.de>
Subject: Re: [ANNOUNCE] rt-tests-2.0
From:   Mike Galbraith <efault@gmx.de>
To:     John Kacur <jkacur@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Johnathan Schwender <schwenderjonathan@gmail.com>,
        Peter Xu <peterx@redhat.com>
Date:   Sat, 26 Jun 2021 14:45:27 +0200
In-Reply-To: <1c1966dd51ae6f8ddcd892cba485c332281fbd37.camel@gmx.de>
References: <20210625160801.9283-1-jkacur@redhat.com>
         <549a4a5579068b9b1ca7741cb0f4aafbd04f4389.camel@gmx.de>
         <1c1966dd51ae6f8ddcd892cba485c332281fbd37.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6ny9VOzVEszgmFQ5/XsnJLZ1cx0eiaLQBUNqZ4Eq5b+kUxxTULS
 WZgzFbgb4pJvfOICNlCz3uZrrQ4COSAo9BeC8Rtyatuff3wXIiHOEV4HLuBdu1Rpi6S+R2c
 K+ztKjy3T4AwYeRbqO7Tf9Z7/jZGnOoE4eJXWXr5z6St9fD4T8LSNfmu6SBxJvuP4s80k7Z
 0PKqOypvXrPG4rJQoESHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DEzdbTuDez0=:BAIFzIS7OSY961nBwSbxK6
 nX0YwG8cg62WPjzgdMkCvP0xkPLVQBobwcfxaG8i7iutb468VLbhkTqwwyQUCLeDddFN2+soW
 3abdHtll0o1RsFT51bWZLqGjkk/rn4xTcdIcHwILxIRJkfJaW5iatGpzG2HRlnom76DJHl/Dr
 PySFpnefiVlI3WI9vBA8Dw36j4rcBVAaNBF1u0SgyNUxaxkEiLj6nRdMOK7asfKjOnMo2cnnk
 4q3QD04/+Bi79H4KlRcwGdqRypHPuKo4jtL1RIRwi0LWR86S+2O/+T3NGEcJwU9e0JsWHnSyE
 JhOvekNg9htDyQoC3UDbxfmA1XRf3Y8EMgy8d6hS78Ukbt5I/2qmJG1K+y1fFcSRaIlec4VzV
 K8HZ8w0s7OSIxJKB9YaQwabgMGh+CHU2NjB+WqcQl4Nkl4kkZjyfAj0ES+6OsajjRUwQiSSKy
 PlXDimL35k1bo21L0GCjlT/IE76BAtlw4/Z9mahZsQByvzncb2xhZO00RdllvlAzU0EviCS4J
 LH6ZoYjBgdwnaq9VLSMtEYE8DP2roTmkSvCIu7m8k+NunSqplKqyTU74LMfwbtDWIfAHph3KG
 3QNGGZEpJXWcGIJXiHaakHO6UwDqe1N73OrNA4octGGCgSCXcOAsLcgnaon0cF2axNNWL7toH
 yKU/UjT6/QBtiX83Gic95SxaxtZvMHcw1pQ0B9m3oJHAlxqHOANpITG4H9GeKJkmujoYu3LUC
 Kc6N2HbSeXF1QCJ4dyh1GsieEYG6lJexV8uWHxYVx6vnEf8CZt0I4zgVTxjzoYSVUYb340MMs
 QmCvcMYEYa6ZjAOsKZC+jEmKtHKr09PjKxoNkVFrV6z6ZQhcyYGSKCgR9ecqJ0EgGr31i1g7K
 fBe66n8iGKXMg56aHvtt/kjKP+LOSnLY0+CugaUGxQIYs3b6gZXMGk5e3icgUfWKAqB+kpKP7
 9foR9vhQhZPIQEfrjSHsSWJ86vy+lriBpKG+fzkRhry4jsJKTT3JnR7AGNbyjbFvHZ65JQ72A
 7a1BmYXddkhxDRM9/zdec50SNBfR0Bt7lvAL+4Q9hQ1rQ8xVxP8jU+iXzc7/czQNJFSXFnpXF
 IJMXaaxe+iJ+A2xWQhw6LNIqJI2sFHdWpGH
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 2021-06-26 at 13:47 +0200, Mike Galbraith wrote:
> On Sat, 2021-06-26 at 08:55 +0200, Mike Galbraith wrote:
> > On Fri, 2021-06-25 at 12:08 -0400, John Kacur wrote:
> > > I'm pleased to announce rt-tests-2.0
> >
> > Greetings,
> >
> > cyclictest seems to have grown an mlock related regression.
>
> Ok, chores done, I did a quick bisect/confirm.  I didn't go stare
> at rt_test_start() to ponder what the mlockall connection may be.

Moving the call above "Get current time" stops it mucking things up.

	-Mike

