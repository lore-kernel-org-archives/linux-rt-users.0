From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Numbering system
Date: Wed, 2 Mar 2016 09:18:37 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603020916390.3638@nanos>
References: <56D5C521.2050700@gmail.com> <alpine.DEB.2.11.1603012102150.3638@nanos> <56D61ECA.2010609@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: DIXLOR <dixlor@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49824 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbcCBIT7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Mar 2016 03:19:59 -0500
In-Reply-To: <56D61ECA.2010609@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2 Mar 2016, DIXLOR wrote:
> # cat Makefile
> 
> VERSION = 4
> PATCHLEVEL = 4
> SUBLEVEL = 3
> EXTRAVERSION = here must be non mainline numbering: -rt1, -rt2, etc.
> ...
> 
> If SUBLEVEL changed, then EXTRAVERSION must be set to zero or one.

RT is not using EXTRAVERSION. It's using localversion and it's not going to
change its numbering scheme after 12 years just because.

Thanks,

	tglx
