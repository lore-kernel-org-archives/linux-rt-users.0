From: =?UTF-8?Q?Dominic_Sacr=c3=a9?= <dominic.sacre@gmx.de>
Subject: Re: Changing checksums of RT patches
Date: Mon, 13 Feb 2017 23:56:36 +0100
Message-ID: <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
 <20170210185433.h35nynmmeu5toml6@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:62403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbdBMW7K (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Feb 2017 17:59:10 -0500
In-Reply-To: <20170210185433.h35nynmmeu5toml6@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-02-10 19:54, Sebastian Andrzej Siewior wrote:
> On 2017-02-09 10:09:16 [+0100], Dominic Sacré wrote:
>> I noticed that recently the compressed RT patches (.patch.gz) at
>> https://www.kernel.org/pub/linux/kernel/projects/rt started changing.
>> The actual content of the patches seems to remain unchanged, but it
>> looks like the gzipped files are being regenerated, resulting in
>> different checksums.
> 
> Can you tell me which file in which folder changed?

The files I'm currently concerned with are in the rt/4.1/older directory.

For example, the Bitbake recipe I'm working on
(https://github.com/Freescale/meta-freescale/blob/master/recipes-kernel/linux/linux-fslc-imx-rt_4.1-2.0.x.bb)
used the file rt/4.1/older/patch-4.1.35-rt41.patch.gz. At some point
that file changed, so the recipe would fail to build from scratch (I
don't know when exactly or how often the file changed).

I then updated the recipe to a later kernel version, using
patch-4.1.37-rt43.patch.gz instead. Two days later I noticed builds
starting to fail again, because that file too had changed, *after* I had
updated the recipe.

>> This is a problem for example for OpenEmbedded-based projects, which use
>> MD5 and SHA256 checksums (basically hardcoded into Bitbake recipes) to
>> verify the integrity of files being downloaded.
> 
> I see. You should be able to verify the uncompressed patch against a gpg
> key. However I guess this is not how OpenEmbedded works.

Bitbake/OpenEmbedded uses only SHA256 and MD5 checksums, and I don't
think I can get it to check the hashes after uncompressing the patches.


Thanks,

Dominic
