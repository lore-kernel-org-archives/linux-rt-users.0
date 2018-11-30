Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:38571 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeLAFW2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 1 Dec 2018 00:22:28 -0500
Date: Fri, 30 Nov 2018 19:12:19 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: git clone of v4.19.1-rt3 fails, unk compression mode, fatal exit
 twice
Message-ID: <20181130181219.iciugbrtsopyhmx3@linutronix.de>
References: <201811260830.58983.gheskett@shentel.net>
 <201811301052.03239.gheskett@shentel.net>
 <20181130170532.twosu6gdlqg6k2ja@linutronix.de>
 <201811301303.34229.gheskett@shentel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201811301303.34229.gheskett@shentel.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Gene Heskett <gheskett@shentel.net>
Cc: linux-rt-users@vger.kernel.org

On 2018-11-30 13:03:34 [-0500], Gene Heskett wrote:
> Now, a progress report, making me think there is more than one bug, the 
> other is that I've tried 3 of these realtime kernels, and found that all 
> of them are quite good at throwing away keyboard/mouse events from their 
> own consoles and its boot sensitive in that if I reboot, I can 
> eventually reach a configuration that does work, and will work till the 
> next power bump.

The keyboard/mouse is attached via USB, right? So this might be again a
problem related to the USB controller.

> So I've now found that using the full UUID in my fstab generates a drive 
> not found error buried in the logs, but that if a fresh 
> mkswap -c /dev/sda3(takes about half an hour for a 10GB swap) is done, 
> and the fstab uses PARTUUID="yadda-yadda", that error goes away.

This shouldn't take that long. If I remember correctly, it writes the
swap header and not much more.

> So then I stopped the swapfile, leaving htop showing 9999 megs of swap 
> and empty, then from another console login, watched the git clone run 
> with htop.  It took most of an hour, got 72 megs into swap, then died 
> from a bad index  compression, just like before but this time complained 
> about the partition mounted as /media/slash. So I umounted it and ran 
> e2fsck /dev/sda3, quiet for several minutes, and gave it a clean 
> condition, no errors IOW.

For testing I strongly recommend a local git server and not use
kernel.org resources for this.

Sebastian
