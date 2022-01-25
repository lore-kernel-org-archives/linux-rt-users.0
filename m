Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88367C5DF62
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jan 2022 23:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbiAYXyn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jan 2022 18:54:43 -0500
Received: from mwweb08oc.mail2world.com ([74.202.142.113]:61076 "EHLO
        mwweb08oc.m2wprod.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235023AbiAYXym (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jan 2022 18:54:42 -0500
Received: from mail pickup service by mwweb08oc.m2wprod.com with Microsoft SMTPSVC;
         Tue, 25 Jan 2022 15:56:45 -0800
Received: from mail pickup service by mwweb08oc.mail2world.com with Microsoft SMTPSVC;
         Tue, 25 Jan 2022 15:56:41 -0800
auth-sender: gheskett@shentel.net
Received: from 204.111.64.149 unverified ([204.111.64.149]) by mwweb08oc.mail2world.com with Mail2World SMTP Server; 
        Tue, 25 Jan 2022 15:56:41 -0800
From:   gene heskett <gheskett@shentel.net>
To:     Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v5.16-rc6-rt12
Date:   Tue, 25 Jan 2022 18:54:32 -0500
Message-ID: <3788489.eI0EPVGB43@coyote>
Organization: only accidental
In-Reply-To: <b34a560ceeb3bf29f20169f6201b941c64f3d20a.camel@gmx.de>
References: <YcSgQY8lzb6MkQPx@linutronix.de> <8448352.jqPtiG1ysD@coyote> <b34a560ceeb3bf29f20169f6201b941c64f3d20a.camel@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CTCH-Spam: Unknown
X-CTCH-RefID: str=0001.0A702F24.61F08DB9.0054,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-OriginalArrivalTime: 25 Jan 2022 23:56:41.0405 (UTC) FILETIME=[32F0CED0:01D81247]
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sunday, January 23, 2022 8:14:13 PM EST you wrote:
> On Sun, 2022-01-23 at 09:40 -0500, gene heskett wrote:
> > On Friday, December 24, 2021 9:16:57 PM EST you wrote:
> > > On Thu, 2021-12-23 at 17:13 +0100, Sebastian Andrzej Siewior wrote:
> > > > Dear RT folks!
> > > > 
> > > > I'm pleased to announce the v5.16-rc6-rt12 patch set.
> > > 
> > > > Changes since v5.16-rc6-rt11:
> > > ...
> > > 
> > > >   - The "Memory controller" (CONFIG_MEMCG) can be enabled again.
> > > 
> > > FWIW, LTP testcases pass on rpi4 and x86_64 boxen with no gripeage.
> > > Full LTP with maximally bloated config was as uninteresting as one
> > > can
> > > hope for.
> > > .
> > 
> > Unforch and after many try's, I can't get it to reboot when
> > installed,
> > sorta, on an rpi4b.
> > 
> > I say sorta, because no matter how many times I rebuild it, the build
> > does not generate an arch/arm/boot/dts/overlays directory.  The build
> > itself is error free.
> > 
> > The raspi kernel build instructions from their somewhat dated wiki
> > also say to use the bcm2711_defconfig, but it does not now exist in
> > a git clone. And a hwinfo of the rpi4b says I should use the
> > bcm2835_defconfig for a starter .config.
> > 
> > Is there any hope of making this work?
> 
> Sure.  Given bcm2711_defconfig is missing, sounds like you're trying to
> build patched up kernel.org source.  You can do that, works fine for
> me, and I know jack diddly spit about cute little arm gizmos ;-) but
> you're better off patching up source from...
> 
> 	git clone https://github.com/raspberrypi/linux.git
> 
> ...instead, which has a large pile of not yet upstreamed rpi patches.
> Just checkout the rpi-5.16.y branch and apply the 5.16-rt patch set.
> There you'll find that bcm2711_defconfig you were looking for.
> 
> I build on my desktop box, rpi4 being every bit as fast as you'd expect
> something that dinky to be, then nfs mount from rpi4 and sudo make
> modules_install dtbs_install install.  Edit /boot/config.txt, reboot,
> and presto, you too will be ready to have any unrealistic x86_64 based
> expectations you may have thoroughly dashed by cyclictest numbers :)

And after the reboot, its still running the old kernel, so I must have 
edited config.txt wrong. Or the bare install miss-fired. IDK.

And I can't ssh into it, sshd isn't running, and raspi-config has 
disappeared. That is normally where I start it once and forever. But I 
did find it in the gui menu. Started ssh, rebooted.
ssh -y pi@rpi4, figure out the keys, log in, mkdir /mnt/sdb1
mount it, cp arm.src/apt-stf/linux/arch/arm/boot/zImage to boot/kernel7l-
rt, edit /boot/config.txt to spec that name, reboot.

log back in and a uname -a now says:
Linux rpi4 5.16.2-rt19-rt19-v7l+ #3 SMP PREEMPT_RT Tue Jan 25 01:14:16 
EST 2022 armv7l GNU/Linux

I think I've hit a lick!

So thank you very much Mike.  Now to do it 2x more for Dave Engvall, 3000 
miles west of me, out in the puckerbrush of Wash state.  He has a cinci 
mill he wants to run with a rpi4b.

But first, since this is my card, not his, recover the /home/pi/linuxcnc 
directory and install the 4 debs of master I built earlier this after 
noon and see how linuxcnc runs now. At this point my grin is so wide I'll 
need a bigger brain bucket to go riding...

> 	-Mike
> .


Cheers, Gene Heskett.
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author, 1940)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/gene>



