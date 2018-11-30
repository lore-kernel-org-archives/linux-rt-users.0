Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from barracuda2.shentel.net ([204.111.1.145]:17310 "EHLO
        barracuda1.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725749AbeLAKea (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 1 Dec 2018 05:34:30 -0500
Received: from smtp2.edbg.cloud.shentel.net (smtp2.edbg.cloud.shentel.net [204.111.2.25]) by barracuda1.shentel.net with ESMTP id nrltTJ0QqsNVKDID for <linux-rt-users@vger.kernel.org>; Fri, 30 Nov 2018 18:23:33 -0500 (EST)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp2.edbg.cloud.shentel.net (Postfix) with ESMTPSA id 82C5921B5B
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Nov 2018 18:23:33 -0500 (EST)
From: Gene Heskett <gheskett@shentel.net>
Subject: Re: git clone of v4.19.1-rt3 fails, unk compression mode, fatal exit twice
Date: Fri, 30 Nov 2018 18:23:32 -0500
References: <201811260830.58983.gheskett@shentel.net> <201811301303.34229.gheskett@shentel.net> <20181130181219.iciugbrtsopyhmx3@linutronix.de>
In-Reply-To: <20181130181219.iciugbrtsopyhmx3@linutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201811301823.33000.gheskett@shentel.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

On Friday 30 November 2018 13:12:19 Sebastian Andrzej Siewior wrote:

> On 2018-11-30 13:03:34 [-0500], Gene Heskett wrote:
> > Now, a progress report, making me think there is more than one bug,
> > the other is that I've tried 3 of these realtime kernels, and found
> > that all of them are quite good at throwing away keyboard/mouse
> > events from their own consoles and its boot sensitive in that if I
> > reboot, I can eventually reach a configuration that does work, and
> > will work till the next power bump.
>
> The keyboard/mouse is attached via USB, right? So this might be again
> a problem related to the USB controller.
>
> > So I've now found that using the full UUID in my fstab generates a
> > drive not found error buried in the logs, but that if a fresh
> > mkswap -c /dev/sda3(takes about half an hour for a 10GB swap) is
> > done, and the fstab uses PARTUUID="yadda-yadda", that error goes
> > away.
>
> This shouldn't take that long. If I remember correctly, it writes the
> swap header and not much more.
>
Note the -c, ack the man page it verify's the memory is good, and it will 
take a pi a while to scan 10GB.
> > So then I stopped the swapfile, leaving htop showing 9999 megs of
> > swap and empty, then from another console login, watched the git
> > clone run with htop.  It took most of an hour, got 72 megs into
> > swap, then died from a bad index  compression, just like before but
> > this time complained about the partition mounted as /media/slash. So
> > I umounted it and ran e2fsck /dev/sda3, quiet for several minutes,
> > and gave it a clean condition, no errors IOW.
>
> For testing I strongly recommend a local git server and not use
> kernel.org resources for this.
>
> Sebastian

This is the middle of West Virginia, and I've no clue where the nearest 
one might be. I'm sure you have mirrors in the eastern US, but googling 
for them only turned up the commercial offerings, often priced at 
$129.50 a month to host /my/ project.  So thats way above my paygrade on 
S.S., and TBT, I host what I want to serve from this machine. And I 
still use maybe 20% of the bandwidth I am allowed per $60 month on a 
10megabyte connection.

URL? For eastern US?

Many Thanks for your time, Sebastian Andrzej Siewior.

-- 
Cheers, Gene Heskett
--
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
