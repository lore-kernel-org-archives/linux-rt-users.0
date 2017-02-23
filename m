From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: NO_HZ and ktimersoftd
Date: Thu, 23 Feb 2017 19:01:24 +0100
Message-ID: <20170223180124.ykbhfmkbmf2xa7tk@linutronix.de>
References: <CACKey4zmx_=k6r8BY3B7K9ZuR6x5=11U25-st4oK8WAgo1WgQQ@mail.gmail.com>
 <20170105163210.GJ1335@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Julia Cartwright <julia@ni.com>, linux-rt-users@vger.kernel.org
To: Federico Reghenzani <federico.reghenzani@polimi.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:49550 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbdBWSBe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Feb 2017 13:01:34 -0500
Content-Disposition: inline
In-Reply-To: <20170105163210.GJ1335@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-01-05 10:32:10 [-0600], Julia Cartwright wrote:
> > This works fine, however when I run my RT application, the thread
> > kimersoftd is always in "running" state, thus the scheduling interrupt
> > triggers (because there exists more than 1 task available to run).
> > Consequently, the advantages of NO_HZ_FULL are vanished.
> 
> This sounds like the same problem that Haris (cc'd) has looked into and
> has put together a proposed solution.  See the thread here:
> 
>    http://www.spinics.net/lists/linux-rt-users/msg16113.html

can you please check latest v4.9.11-rt9 if the issue is still there or
gone?

Sebastian
