Return-Path: <SRS0=TWee=3D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2FCC33CB1
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jan 2020 08:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3A82084D
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jan 2020 08:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgANIHg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:07:36 -0500
Received: from mail.thorsis.com ([92.198.35.195]:40144 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgANIHg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Jan 2020 03:07:36 -0500
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jan 2020 03:07:36 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 349A8EC2
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2020 09:04:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TZ-ncqfxP6dZ for <linux-rt-users@vger.kernel.org>;
        Tue, 14 Jan 2020 09:04:34 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 1543E4838; Tue, 14 Jan 2020 09:04:33 +0100 (CET)
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Gene Heskett <gheskett@shentel.net>
Subject: Re: [ANNOUNCE] v5.4.10-rt5
Date:   Tue, 14 Jan 2020 09:01:27 +0100
Message-ID: <1896107.FrWXgdeJfy@ada>
In-Reply-To: <202001122122.10938.gheskett@shentel.net>
References: <20200110201430.vl3sxiwntj5o4z74@linutronix.de> <202001122122.10938.gheskett@shentel.net>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello Gene,

Am Sonntag, 12. Januar 2020, 21:22:10 CET schrieb Gene Heskett:
> I grabbed a copy of this, then turned off anything not needed to run
> LinuxCNC on an rpi4 in armhf config.  Then I noted its make had a make
> deb-pkg option.  But it isn't making what I told it to make as I'm
> sitting here watching it ALL go by. Did I miss something in  a make
> menuconfig that triggered a make all? It was supposedly set for armhf.
> But I'm even seeing x86 stuff go by. Obviously I know just enough to
> screw it up. Point me at the right docs for arm builds please.

Building a RT kernel is no different than building any other kernel with=20
patches. Patch your kernel source, configure, compile =E2=80=A6=20

You can use any howto or docs for building the kernel for your platform.=20
Speaking of RPi4, it depends on your Linux distribution and whether you=20
compile on the target or do cross compiling from another machine. But if yo=
u=20
got this sorted out, you just need to apply the RT patch and build again.

However this list is probably not the right place for that sort of question=
s.

HTH & Greets
Alex

