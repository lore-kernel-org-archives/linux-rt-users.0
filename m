Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E615C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jan 2022 01:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbiAXBO3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 23 Jan 2022 20:14:29 -0500
Received: from mout.gmx.net ([212.227.17.22]:54465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235226AbiAXBO2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 23 Jan 2022 20:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642986859;
        bh=NJlapxgK/qn5GhYRFOBCR+9jWwoj0EJZrXOSAsu72vg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=jyg0lL/eXhgYoC94Y8+Uocnd64Lw0gkj+ncTNRlTGnPEtF9p/v99/wH7r5Kq6Q7E9
         FDJ3K4zlbCJudqb7TbuIM9EVhOPRAe4JyHlZwOD863Xvk21aDB1n80reqD17QybLqt
         tyirvOmdDcux5RBHF9k73oAO7J7WQliELQvfKfW8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.50]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsUC-1n2yEN0944-008qri; Mon, 24
 Jan 2022 02:14:19 +0100
Message-ID: <b34a560ceeb3bf29f20169f6201b941c64f3d20a.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.16-rc6-rt12
From:   Mike Galbraith <efault@gmx.de>
To:     gene heskett <gheskett@shentel.net>
Cc:     linux-rt-users@vger.kernel.org
Date:   Mon, 24 Jan 2022 02:14:13 +0100
In-Reply-To: <8448352.jqPtiG1ysD@coyote>
References: <YcSgQY8lzb6MkQPx@linutronix.de>
         <64294bf40ace6be86a295099b895a7d1f6a5c49f.camel@gmx.de>
         <8448352.jqPtiG1ysD@coyote>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fuY0fbhp1w4F/8kKWtQY/Bxh5O9CoiNBg5zseL/5N75ZMR8KdRT
 UdAf6aNo8RgMzKsSAPUvHuhFsMQJtiotEhJtFbAUlD2Zus62XU4VIfvHuzPUWhRtKOYS/3Q
 vvXS43My5YhZ9tTQhrXyqKHjxYOUdVhQ22kx8x5NUkvNzf6iTx/ChBTWf7CSbZpfalxDXeJ
 umErgcN85GanC1O7QxTDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dn+Z8ZX3CPo=:N9s7ZInvyA8xnfEcT3z7Ns
 6ORG9sqO7zjujAEaJINNdYiOlg0p+RK7WW+i0guXiauKluB2N6ci+QEl7U55G79oRZmJJ0DUh
 uWNCiPcv6gEOLwtTPvABiKndeq3n3vElTuxGzarYppS8brjaj4zJpdMJLWZufCvLVPn/9DiDt
 SE0/j3vGmEocMWYm02nuL3Q2GJwzoLPZOX6tIyxz9fLO6G5oYwIh9sgcimtj/h9Rm9JU8YOKW
 8bzUjGoyC4N2lvfF8kAGwSZrw1myECuv8LJ1JqF9DnkX28dl+xpirveaaSFhIPAJ1uyM+nLI8
 iLAYH+FgJZ0V9+nk+SmyFJXrJKUDJb+tSOZ2SMo0/1769JpLAcR/84++k+vR1HAF2vodieHXN
 5qKt0hJHnNLYJ4YOTSph2r4hYUm3X6lMrZUHaL+oI4vzHmzldRKQSYJ/3xjraaDdjzxIHihl7
 apEKSOcyE0G589wvpTaScjG8P9KVnD0JKMt9TCdobjB2G9QH11JIJUzLoHqpGgcCOxu2WWuxh
 BpHdRUAcU8yBYD0lWss0DKEiLtXgfigO2PC91M+qLhS2s4vJudTvssyKuoAzHyqbjgyWU7IjO
 zAfgMAj0JF1JWKeQibl9d7pNr3RmBlAglpem8LDBSKtnNFLxHxsqwV8we8d60XJETpcwsJoy8
 iKA5q6etmVpkSElE+XU3pJE2UV8HQInHxZP0VYPHYM0+eGnFpNu1S2Sl6//wcPoQpJ1Z9VJKP
 JNxGR/8X+FfHYAsS26EZhgytaSnsjinxEqCgEM66YxJgjLBiD9OqrADicQrEmV4ToUJwPzZxH
 VXmRCTUp41BMro0znFCO/ZhyIRhn30+03334k2xEq9ap+vX5BV8Rfxtv+8x4pNiLqDx1RSJdk
 2jCegm/gmTr1kheifiwBI+IdzgHeI6WrwMusk+d+voe3wwblf+PzkKjaBIkgqBKC5dRSGYPcs
 XBaFZcAeQZCo0HijaACnGJujjuNgoDbyzJ4mYydbKq8NuDJk8wc/WtPAXUKi5efWFbU3lFR6g
 rRWI6uGSaUiU00NrglpL5H7ZU5tA9AMY5zWtfRoxeg4nVDNtkBDYQOnoDhgZxdsgxHsZ5/6Ji
 r1Y1ApsXHz5EOw=
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 2022-01-23 at 09:40 -0500, gene heskett wrote:
> On Friday, December 24, 2021 9:16:57 PM EST you wrote:
> > On Thu, 2021-12-23 at 17:13 +0100, Sebastian Andrzej Siewior wrote:
> > > Dear RT folks!
> > >
> > > I'm pleased to announce the v5.16-rc6-rt12 patch set.
> >
> > > Changes since v5.16-rc6-rt11:
> > ...
> >
> > > =C2=A0 - The "Memory controller" (CONFIG_MEMCG) can be enabled again=
.
> >
> > FWIW, LTP testcases pass on rpi4 and x86_64 boxen with no gripeage.
> > Full LTP with maximally bloated config was as uninteresting as one can
> > hope for.
> > .
>
> Unforch and after many try's, I can't get it to reboot when installed,
> sorta, on an rpi4b.
>
> I say sorta, because no matter how many times I rebuild it, the build
> does not generate an arch/arm/boot/dts/overlays directory.=C2=A0 The bui=
ld
> itself is error free.
>
> The raspi kernel build instructions from their somewhat dated wiki also
> say to use the bcm2711_defconfig, but it does not now exist in a git
> clone. And a hwinfo of the rpi4b says I should use the bcm2835_defconfig
> for a starter .config.
>
> Is there any hope of making this work?

Sure.  Given bcm2711_defconfig is missing, sounds like you're trying to
build patched up kernel.org source.  You can do that, works fine for
me, and I know jack diddly spit about cute little arm gizmos ;-) but
you're better off patching up source from...=C2=A0

	git clone https://github.com/raspberrypi/linux.git

...instead, which has a large pile of not yet upstreamed rpi patches.
Just checkout the rpi-5.16.y branch and apply the 5.16-rt patch set.
There you'll find that bcm2711_defconfig you were looking for.

I build on my desktop box, rpi4 being every bit as fast as you'd expect
something that dinky to be, then nfs mount from rpi4 and sudo make
modules_install dtbs_install install.  Edit /boot/config.txt, reboot,
and presto, you too will be ready to have any unrealistic x86_64 based
expectations you may have thoroughly dashed by cyclictest numbers :)

	-Mike
