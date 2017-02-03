From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Understanding cyclictest result
Date: Fri, 3 Feb 2017 16:27:19 +0100
Message-ID: <20170203152719.ldomq7rvqtdyoui3@linutronix.de>
References: <CAJ2oMh+e-pH53KOckXcKB-FdRxnrdtTxprGvEifvUeA1=dG6gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44544 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdBCP1W (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Feb 2017 10:27:22 -0500
Content-Disposition: inline
In-Reply-To: <CAJ2oMh+e-pH53KOckXcKB-FdRxnrdtTxprGvEifvUeA1=dG6gw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-02-03 10:13:15 [+0200], Ran Shalit wrote:
> Hello,
Hello,

…
> and got max value of 180usec.
> 
> On comparing my results to resuls examples given in
> https://rt.wiki.kernel.org/index.php/Cyclictest
> it seems like a very large number.
> I know it depends on hardware (I am using Atom, one core only.), yet
> becuase I'm not too experienced with it, I am not sure if my real
> problem is HW or doing wrong testing/RTpatch.
> I also see that it is much better then results before applying RT
> patch (3000usec)

So Carsten has
- Atom Z530 @1600 MHz with 382us [0]
- Atom N2800 @1860 MHz with 43us [1]

[0] https://www.osadl.org/Profile-of-system-in-rack-1-slot-8.qa-profile-r1s8.0.html#hwlats
[1] https://www.osadl.org/Profile-of-system-in-rack-c-slot-4.qa-profile-rcs4.0.html#hwlats

> Best Regards,
> Ran

Sebastian
