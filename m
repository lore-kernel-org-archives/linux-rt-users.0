Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:47148 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeKJAdp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Nov 2018 19:33:45 -0500
Date: Fri, 9 Nov 2018 15:52:49 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Hang at suspend with 4.18.0-2 rt
Message-ID: <20181109145249.cc7ylixewrefo27d@linutronix.de>
References: <b02df6ecde63bbdaafaeb7b3aa672ddbb2634f8b.camel@lebib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b02df6ecde63bbdaafaeb7b3aa672ddbb2634f8b.camel@lebib.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: wargreen <wargreen@lebib.org>
Cc: linux-rt-users@vger.kernel.org

On 2018-11-09 02:17:34 [+0100], wargreen wrote:
> Hello rt list,
Hi,

> Since the 4.18.0-2 upgrade from debian repo, i have a full system hang
> when my thinkpad x230 go to suspend. No problem with 4.17 or 4.18.0-2
> no-rt.
> 
> I havn't anything in the logs. The only visible thing is the fast
> blinking power led, as when the computer go to or resume from suspend.
> 
> I can do some tests if needed.

So I just tried v4.19-RT in kvm and both (suspend to disk and memory)
appear to work.
Would you mind trying v4.19-RT?

> Cheers,
> wargreen

Sebastian
