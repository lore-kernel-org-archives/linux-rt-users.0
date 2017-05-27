From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: [ANNOUNCE] v4.9.30-rt20
Date: Sun, 28 May 2017 01:59:49 +0200
Message-ID: <20170528015949.2dc4ae46@archlinux.localdomain>
References: <20170527163230.b7qcfbmwsmbyo7k2@linutronix.de>
        <fccee2a1-e0d3-4591-8ecc-6a1da4934219@manjaro.org>
        <20170527173318.ed2v6ipmrnnq4iv5@linutronix.de>
        <17b591e8-1e28-5dad-2388-3a397d02c0d9@manjaro.org>
        <20170527235534.1d068819@archlinux.localdomain>
        <9119cc4d-aa76-0ad1-a740-ba18bf83cd3f@manjaro.org>
        <20170528014737.01da53e6@archlinux.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Bernhard Landauer <oberon@manjaro.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail221c50.megamailservers.eu ([91.136.10.231]:33044 "EHLO
        mail33c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750757AbdE0X7w (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 May 2017 19:59:52 -0400
In-Reply-To: <20170528014737.01da53e6@archlinux.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 28 May 2017 01:47:37 +0200, Ralf Mardorf wrote:
>On Sun, 28 May 2017 00:32:15 +0200, Bernhard Landauer wrote:
>>the whole point in signing archives at all is that I want to know 
>>who's key it is before accepting it.
>>It doesn't make much sense to just blindly accept an unknown key  
>
>Hi Bernhard,
>
>without doubts this is a valid point. I suspect that most, if not all
>important keys, for me suffer from missing validation. The "web of
>trust" is the weak point of signing. However, a download from a https
>page + a key that perhaps isn't validated by a web of trust, in
>combination with contact to upstream and/or distro communities, e.g. by
>mailing lists, isn't that bad. It's not absolutely secure, but still
>ok, assuming that the kernel is used e.g. for audio productions, that
>don't require hardcore security.
>
>Regards,
>Ralf

PS:

Not that long ago, did a validated key protect anybody from
Heartbleed ;)? In the end you still need to trust upstream.
