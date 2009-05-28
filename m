From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Missing hunk from rt-mutex-core.patch
Date: Thu, 28 May 2009 09:46:24 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0905280945570.3397@localhost.localdomain>
References: <20090526201100.GO23793@bolzano.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Jan Blunck <jblunck@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:34361 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410AbZE1Hqh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 May 2009 03:46:37 -0400
In-Reply-To: <20090526201100.GO23793@bolzano.suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 26 May 2009, Jan Blunck wrote:

> Somehow the following hunk was lost during the port to 2.6.29. Without it
> calling sysrq-t or similar gives you very strange results ;)

Good catch.

Thanks,

	tglx
