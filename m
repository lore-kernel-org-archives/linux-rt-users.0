From: Bernhard Landauer <oberon@manjaro.org>
Subject: Re: [ANNOUNCE] v4.9.30-rt20
Date: Sun, 28 May 2017 00:32:15 +0200
Message-ID: <9119cc4d-aa76-0ad1-a740-ba18bf83cd3f@manjaro.org>
References: <20170527163230.b7qcfbmwsmbyo7k2@linutronix.de>
 <fccee2a1-e0d3-4591-8ecc-6a1da4934219@manjaro.org>
 <20170527173318.ed2v6ipmrnnq4iv5@linutronix.de>
 <17b591e8-1e28-5dad-2388-3a397d02c0d9@manjaro.org>
 <20170527235534.1d068819@archlinux.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
        linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.manjaro.org ([176.9.38.148]:40501 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbdE0WcU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 May 2017 18:32:20 -0400
In-Reply-To: <20170527235534.1d068819@archlinux.localdomain>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Ralf,
sure, it's not a problem to receive a new key.
But the whole point in signing archives at all is that I want to know 
who's key it is before accepting it.
It doesn't make much sense to just blindly accept an unknown key, especially
when you regularly build a package from the same source.
When the signature suddenly changes, you should at least inquire why, 
don't you think? ;)

regards
Bernhard


On 27/05/17 23:55, Ralf Mardorf wrote:
> On Sat, 27 May 2017 19:36:11 +0200, Bernhard Landauer wrote:
>> Yes, meanwhile I have looked it up and found that it belongs to
>> 7B96E8162A8CF5D1
>>
>> Sorry. All good!
> Earlier today I build
>
> [rocketmouse@archlinux ~]$ uname -a
> Linux archlinux 4.9.30-rt19-1-rt-pussytoes #1 SMP PREEMPT RT Sat May 27 12:44:27 CEST 2017 x86_64 GNU/Linux
>
> it already required to refresh the key. For cases like this I added an
> alias...
>
> [rocketmouse@archlinux ~]$ grep "alias gkey=" .bashrc
> alias gkey='gpg --keyserver hkp://pgp.uni-mainz.de --recv-keys'
>
> ...so just running
>
> [rocketmouse@archlinux ~]$ gkey 4FE5E3262872E4CC
>
> ...did the trick. When building from upstream and verifying against a
> signature, this happens all the times ;).
>
> Regards,
> Ralf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

