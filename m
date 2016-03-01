From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Numbering system
Date: Tue, 1 Mar 2016 21:06:23 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603012102150.3638@nanos>
References: <56D5C521.2050700@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: DIXLOR <dixlor@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47482 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbcCAUHq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Mar 2016 15:07:46 -0500
In-Reply-To: <56D5C521.2050700@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 1 Mar 2016, DIXLOR wrote:
> Make numbering system with reference to the version of the kernel.
> 
> linux-4.4.2-rt1 First -RT in 4.4.2
> ....
> linux-4.4.2-rt6 Last -RT in 4.4.2
> linux-4.4.3-rt1 First -RT in 4.4.3
> linux-4.4.3-rt2
> ....
> linux-4.4.4-rt1 First -RT in 4.4.4
> ...

We've done the consecutive numbering scheme since rt started, so why should we
change that?

> Where is diff beetween 4.4.3-rt6, 4.4.3-rt7, 4.4.3-rt8?

You mean 4.4.1-rt6 4.4.2-rt7 and 4.4.3-rt8, right?

git diff v4.4.1-rt6..4.4.2-rt7
git diff v4.4.2-rt7..4.4.3-rt8

We simply don't upload diffs for the stable kernel updates which are not
changing the RT code.

Thanks,

	tglx
