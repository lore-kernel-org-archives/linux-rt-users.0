From: Borislav Petkov <bp@alien8.de>
Subject: Re: EDAC messages about corrected errors affect realtime response
Date: Tue, 30 Apr 2013 11:05:20 +0200
Message-ID: <20130430090520.GA12095@pd.tnic>
References: <20130430010733.GA1404@dvomlehn-z8.spacex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-edac@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Robert Richter <rric@kernel.org>,
	Tony Luck <tony.luck@intel.com>
To: David VomLehn <David.VomLehn@spacex.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:42307 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882Ab3D3JFd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Apr 2013 05:05:33 -0400
Content-Disposition: inline
In-Reply-To: <20130430010733.GA1404@dvomlehn-z8.spacex.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Apr 29, 2013 at 06:07:58PM -0700, David VomLehn wrote:
> Things I'd like feedback on:
> 1.	Is sysfs even a reasonable place for this?
> 2.	Is this a workable interface for this information? Note that, unlike
> 	the console, this is a lossy reporting mechanism.
> 3.	Other suggestions?

Actually, the rough idea is to go a couple steps further and carry
RAS-related events using the perf infrastructure. A userspace daemon
then uses perf tool code to open a tracepoint in userspace and do
whatever it wants with that info. When this is done, you won't need
printk and the sysfs part of edac anymore - edac will only do mainly
DRAM ECC to DIMM decoding.

Robert and I are working on this currently and gladly welcome any help.
Here are some more concrete examples of what we want to do/what we're
working on:

http://lwn.net/Articles/425990/
http://thread.gmane.org/gmane.linux.kernel/1457591

HTH.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
