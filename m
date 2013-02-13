From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 3.4.28-rt40 arm freescale imx35 pcm43 - patch
 86236252d2449313bdbac790023cbc957bf6e426 is cause
Date: Wed, 13 Feb 2013 18:25:27 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302131823420.22263@ionos>
References: <6003615.pRQnIgKCSn@dabox> <1525614.TvuV6qqnEF@dabox> <alpine.LFD.2.02.1302131301580.11905@ionos> <3970144.HqS49ZSYWh@dabox>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim@krieglstein.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60358 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934457Ab3BMRZ3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Feb 2013 12:25:29 -0500
In-Reply-To: <3970144.HqS49ZSYWh@dabox>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 13 Feb 2013, Tim Sander wrote:
> > Find below a completely untested patch which should fix that issue.
> The patch didn't compile cleanly, so i removed the last or statment (albeit 
> without knowing if its important (but it's not defined so it can't be ;-).

Well, at least in my kernel source it's defined in
include/linux/kdb.h. So adding the header file to imx.c might cure
that issue.
