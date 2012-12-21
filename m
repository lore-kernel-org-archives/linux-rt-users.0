From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.11-rt24 (apocalypse release)c
Date: Fri, 21 Dec 2012 16:39:44 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1212211636460.3148@ionos>
References: <alpine.LFD.2.02.1212211413200.3148@ionos> <20121221092651.55b44bfb@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53089 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab2LUPjq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Dec 2012 10:39:46 -0500
In-Reply-To: <20121221092651.55b44bfb@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 21 Dec 2012, Clark Williams wrote:
> I had to add this to get -rt24 to compile:
> +#include <linux/delay.h>

Carp. I should have run it through the full tests again after adding
that last minute fix yesterday night. But it was sooo obvious and of
course compiled with my config which magically pulls in that header.

I silently uploaded -rt25

Thanks,

	tglx
