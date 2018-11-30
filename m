Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:37996 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLAB4W (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Nov 2018 20:56:22 -0500
Date: Fri, 30 Nov 2018 15:46:47 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: git clone of v4.19.1-rt3 fails, unk compression mode, fatal exit
 twice
Message-ID: <20181130144647.ay5nkt2ejhhbca6v@linutronix.de>
References: <201811260830.58983.gheskett@shentel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201811260830.58983.gheskett@shentel.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Gene Heskett <gheskett@shentel.net>
Cc: linux-rt-users@vger.kernel.org

On 2018-11-26 08:30:58 [-0500], Gene Heskett wrote:
> What am I missing on a rpi3b currently running jessie?
> 
> The error message:
> pi@picnc:/media/slash $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.19.1-rt3
> Cloning into 'v4.19.1-rt3'...
> remote: Counting objects: 6894009, done.
> remote: Compressing objects: 100% (1061586/1061586), done.
> Receiving objects: 100% (6894009/6894009), 1.25 GiB | 1.22 MiB/s, done.
> remote: Total 6894009 (delta 5798755), reused 6870334 (delta 5786550)
> error: inflate: data stream error (unknown compression method)
> fatal: serious inflate inconsistency
> error: inflate: data stream error (unknown compression method)
> fatal: recursion detected in die handler
> fatal: index-pack failed
> 
> And it leaves no evidence that a v4.19.1-rt3 tree ever existed on that
> machines 64GB ssd drive, currently 7% occupied. Weird.

Works here on a Jessie i386 box.
Does dmesg show any problems? What kernel do you run that box?

> Clues will be checked out.
> 
> Thanks
> 

Sebastian
