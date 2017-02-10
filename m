From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Changing checksums of RT patches
Date: Fri, 10 Feb 2017 19:54:33 +0100
Message-ID: <20170210185433.h35nynmmeu5toml6@linutronix.de>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Dominic =?utf-8?B?U2FjcsOp?= <dominic.sacre@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:33886 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbdBJSyk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Feb 2017 13:54:40 -0500
Content-Disposition: inline
In-Reply-To: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-02-09 10:09:16 [+0100], Dominic Sacré wrote:
> Hi,
Hi,

> I noticed that recently the compressed RT patches (.patch.gz) at
> https://www.kernel.org/pub/linux/kernel/projects/rt started changing.
> The actual content of the patches seems to remain unchanged, but it
> looks like the gzipped files are being regenerated, resulting in
> different checksums.

Can you tell me which file in which folder changed?
Plus I suggest to use
 https://cdn.kernel.org/pub/linux/kernel/projects/rt
which is mostly the same content but should lower the load on the
"origin" servers.

> This is a problem for example for OpenEmbedded-based projects, which use
> MD5 and SHA256 checksums (basically hardcoded into Bitbake recipes) to
> verify the integrity of files being downloaded.

I see. You should be able to verify the uncompressed patch against a gpg
key. However I guess this is not how OpenEmbedded works.

> Does someone know why this is happening?

So if you tell me which file changed I will ask around and let you know.

> Thanks,
> 
> Dominic

Sebastian
