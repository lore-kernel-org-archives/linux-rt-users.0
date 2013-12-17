From: Glenn Elliott <gelliott@cs.unc.edu>
Subject: Re: Solving Nvidia (blob) latency spikes + convert (nvidia's) semaphores into mutexes patches for 331.20 [patches and links provided]
Date: Tue, 17 Dec 2013 18:10:46 +0000 (UTC)
Message-ID: <loom.20131217T190223-662@post.gmane.org>
References: <CAOcfFMzTXoSBJm8Rss6XKugc5knfDfdNaYT34bV=N2qcqeKkeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56613 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755254Ab3LQSLJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Dec 2013 13:11:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1Vsz6q-0008SX-GN
	for linux-rt-users@vger.kernel.org; Tue, 17 Dec 2013 19:11:08 +0100
Received: from gelliott-lt.cs.unc.edu ([152.2.142.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2013 19:11:08 +0100
Received: from gelliott by gelliott-lt.cs.unc.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2013 19:11:08 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

jordan <triplesquarednine <at> gmail.com> writes:

> 
> Hey list,
> 
> I have been experimenting with the nvidia blob, monitoring behavior /
> latencies, etc. Through some experimentation, googling/research and
> looking over previous nvidia-rt/compat patches from all over the
> interwebs; I've put together a few patches for the latest
> nvidia-331.20 driver. (probably portable to older 3xx.xx series too).
> You can obtain the patches from my Archlinux package (Arch User Repo)
> - download the package and extract the patches from the tarball.
> 
> https://aur.archlinux.org/packages/nvidia-l-pa/
> 
> the PKGBUILD file, (which is a build script (for Arch/ABS pakcages)
> much like bsd/ports, gentoo /portage for those unfamiliar) shows how I
> patch/install the driver For Archlinux - although, obviously different
> distros do this different - so; DISCLAIMER: I'm not the person to ask
> for help :)
> 
> cheerz
> 
> Jordan
> 

Have you taken at the SteamOS beta release?  Apparently it's built on
top of PREEMPT_RT.

Link: http://www.phoronix.com/scan.php?page=news_item&px=MTU0MzY.

I believe NVIDIA has been involved in its development.  Hopefully this will
mean NVIDIA will actively develop/test their driver on PREEMPT_RT.

Anyway, I was wondering if you had taken a peak at any NVIDIA GPL'ed code
in SteamOS to see if they include  similar changes.  (The official driver version
number is 331.20.

Link: http://www.phoronix.com/scan.php? 
page=article&item=steamos_linux_benchmarks&num=1

