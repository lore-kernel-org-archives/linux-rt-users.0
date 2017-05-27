From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: [ANNOUNCE] v4.9.30-rt20
Date: Sat, 27 May 2017 23:55:34 +0200
Message-ID: <20170527235534.1d068819@archlinux.localdomain>
References: <20170527163230.b7qcfbmwsmbyo7k2@linutronix.de>
        <fccee2a1-e0d3-4591-8ecc-6a1da4934219@manjaro.org>
        <20170527173318.ed2v6ipmrnnq4iv5@linutronix.de>
        <17b591e8-1e28-5dad-2388-3a397d02c0d9@manjaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail80c50.megamailservers.eu ([91.136.10.90]:57958 "EHLO
        mail70c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750746AbdE0WKH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 May 2017 18:10:07 -0400
Received: from archlinux.localdomain (x4e3216e9.dyn.telefonica.de [78.50.22.233])
        (authenticated bits=0)
        by mail70c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id v4RLtWOY015327
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Sat, 27 May 2017 21:55:34 +0000
In-Reply-To: <17b591e8-1e28-5dad-2388-3a397d02c0d9@manjaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 27 May 2017 19:36:11 +0200, Bernhard Landauer wrote:
>Yes, meanwhile I have looked it up and found that it belongs to 
>7B96E8162A8CF5D1
>
>Sorry. All good!

Earlier today I build

[rocketmouse@archlinux ~]$ uname -a
Linux archlinux 4.9.30-rt19-1-rt-pussytoes #1 SMP PREEMPT RT Sat May 27 12:44:27 CEST 2017 x86_64 GNU/Linux

it already required to refresh the key. For cases like this I added an
alias...

[rocketmouse@archlinux ~]$ grep "alias gkey=" .bashrc
alias gkey='gpg --keyserver hkp://pgp.uni-mainz.de --recv-keys'

...so just running

[rocketmouse@archlinux ~]$ gkey 4FE5E3262872E4CC

...did the trick. When building from upstream and verifying against a
signature, this happens all the times ;).

Regards,
Ralf
