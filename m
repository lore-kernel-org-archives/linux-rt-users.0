From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RT] 2.6.24-rc5-rt1 drivers/dma/ioat_dma.c compile fix
Date: Sat, 15 Dec 2007 09:05:32 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0712150904400.10448@gandalf.stny.rr.com>
References: <BAE9DCEF64577A439B3A37F36F9B691C0371E3E3@orsmsx418.amr.corp.intel.com>
  <Pine.LNX.4.58.0711161214480.24276@gandalf.stny.rr.com>  <47435B31.2070304@yahoo.fr>
 <1197690973.12832.12.camel@sx.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: shannon.nelson@intel.com, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, trem <tremyfr@yahoo.fr>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:44015 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbXLOOFh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 15 Dec 2007 09:05:37 -0500
In-Reply-To: <1197690973.12832.12.camel@sx.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Fri, 14 Dec 2007, Sven-Thorsten Dietrich wrote:

> Hi Steve,
>
> looks like this patch didn't make it into 2.6.23-rc5-rt1.
>
> I refreshed Trem's final version - please review and include in the next
> RT release.
>

Sven,

Thanks,  I'll take a look at it and if I don't find any issues I'll add it
to -rt2 (or rc6-rt1 which ever comes first).

-- Steve
