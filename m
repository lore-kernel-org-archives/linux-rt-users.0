From: Nathan Grennan <edgan@okcforum.org>
Subject: Re: [ANNOUNCE] RT for v2.6.34.8 now available.
Date: Mon, 07 Mar 2011 16:06:39 -0800
Message-ID: <4D75730F.1080905@okcforum.org>
References: <4D71668F.9050201@windriver.com>	<4D748070.1030502@localhost> <AANLkTikkGA6MUUm6yzHPcc7xktsyJzGmimQ0mbNQJ9vK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Paul Gortmaker <paul.gortmaker@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from okcforum.org ([173.8.189.10]:52838 "EHLO mail.okcforum.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab1CHAQN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2011 19:16:13 -0500
In-Reply-To: <AANLkTikkGA6MUUm6yzHPcc7xktsyJzGmimQ0mbNQJ9vK@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/07/2011 06:44 AM, Paul Gortmaker wrote:
> On Mon, Mar 7, 2011 at 1:51 AM, Fernando Lopez-Lezcano
> <nando@ccrma.stanford.edu>  wrote:
>> On 03/04/2011 02:24 PM, Paul Gortmaker wrote:
>>> As a value add to the 2.6.34 long term release, I'm happy to also
>>> announce the availability of 2.6.34-RT.
>>>
>>> You can find it in the v2.6.34-rt branch at:
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/paulg/rt-patches.git
>> Great! Many thanks... Actually, impressive work.
>>
>> I'm trying to integrate/build it into my Fedora based rt packages for Planet
>> CCRMA. Warning: I'm doing this on top of the 2.6.34.8-68 fc13 koji build, so
>> rt is patched on top of the additional Fedora patches for that build (with a
>> few trivial tweaks to patch cleanly). So I don't know if the following
>> issues are due to that - I will investigate:
> Thanks - I'm not surprised to see some fallout in new/updated drivers,
> since they change so much per release and I didn't attempt to build every
> driver under the sun - my core focus was on getting it stable with the main
> defconfigs I could easily test.   I'll have a look and integrate accordingly.
>
> P.

drivers/net/bnx2x_main.c
drivers/staging/comedi/drivers/quatech_daqp_cs.c

These drivers didn't compile for me. bnx2x_main was an easy fix, but I 
didn't bother with quatech_daqp_cs.
