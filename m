From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Old split quilt queues
Date: Wed, 20 Jan 2016 21:59:12 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601202151200.3575@nanos>
References: <569D6AE1.2090301@ramses-pyramidenbau.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33733 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbcATVAM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2016 16:00:12 -0500
In-Reply-To: <569D6AE1.2090301@ramses-pyramidenbau.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Ralf,

On Mon, 18 Jan 2016, Ralf Ramsauer wrote:

> I'm looking for older RT split quilt queues, especially those for kernel
> versions 2.6.31 and 2.6.33.
> Apparently, these are the only two versions without split quilt queues
> available on the FTP server.
>
> Does someone of you know where to get those patch stacks? Or more
> precisely: are split quilt queues actually existing for those versions?

I think that was the time where we actually tried to handle the rt patches in
git and therefor did not release quilt queues. Those git branches are gone
from git.kernel.org AFAICT, but I should have an archive somewhere. Poke me
again in a week if I forget to search for it.

> I'm looking for _all_ available split quilt queues for those versions as
> I'm doing some analysis on the patch stacks.

Out of curiousity. What kind of analysis are you doing?

Archaeological studies? I wouldn't be suprised, given that you are in the
pyramid building business.

Thanks,

	tglx
