From: Nathan Grennan <linux-rt-users@cygnusx-1.org>
Subject: Re: [ANNOUNCE] RT for v2.6.34.8 now available.
Date: Mon, 07 Mar 2011 13:36:28 -0800
Message-ID: <4D754FDC.5050701@cygnusx-1.org>
References: <4D71668F.9050201@windriver.com>	<4D71A88E.2060608@cygnusx-1.org> <AANLkTim3Bwhp4W2zOcAnNxBzz1hmgvPMjtewt1cW8V0s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from okcforum.org ([173.8.189.10]:57802 "EHLO mail.okcforum.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754055Ab1CGVga (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2011 16:36:30 -0500
In-Reply-To: <AANLkTim3Bwhp4W2zOcAnNxBzz1hmgvPMjtewt1cW8V0s@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> Yes, it is the header cleanup done in the 33-->34 dev cycle, seen
> between the rev list ^9e74e7c b66696e that changes slab.h use.
>
> If you look at 8a2032dba45e24 *in the patch repo* you will see where
> I fixed it for the baseline RT-enabled defconfig.  (Meaning I did a
> make defconfig, then enabled the RT options).  Your config must be
> setting something different/extra.
>
> If you do a git show on the above rev list and on the fix in the patch
> repo, you will probably be able to tell what is going on.  Also please
> send me your config (off list) so I can ensure it compiles properly myself.
>

I found the cause. The patching was incomplete. The correct patch 
command is the one below, removing the comment lines.

cat ../rt-patches/series | grep -v '\#' | xargs -i cat ../rt-patches/{} 
| patch -p1
