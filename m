From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: How to merge patch into specific kernel version
Date: Tue, 28 Feb 2017 19:09:01 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702281905410.4732@nanos>
References: <CAJ2oMhLrXcZcS-ZzgOAhfq26jHEpD1GB8hy8rGTkm-jJs547eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36513 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbdB1SJG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Feb 2017 13:09:06 -0500
In-Reply-To: <CAJ2oMhLrXcZcS-ZzgOAhfq26jHEpD1GB8hy8rGTkm-jJs547eQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 17 Feb 2017, Ran Shalit wrote:

> Hello,
> 
> I've noticed that rt-preempt patches comes usually for a specific
> kernel version.
> 
> In case I have some kernel version which does not match the RT patch
> exactly, yet should be applied with the patch:

Depends how you define 'some kernel version'. If the last RT patch is
e.g. 4.9.13-rt10 and you have 4.9.14 then applying -rt10 is usualy just
working.

If you have a base kernel version which was never supported by RT, e.g. 4.7
that's a different story. Neither the 4.6-rt nor the 4.8-rt patch will
apply and you are on your own.

Thanks,

	tglx


