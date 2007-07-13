From: Stephane Eranian <eranian@hpl.hp.com>
Subject: Re: Counting CPU_CLK_UNHALTED on an idle system
Date: Fri, 13 Jul 2007 06:09:34 -0700
Message-ID: <20070713130934.GD28939@frankl.hpl.hp.com>
References: <46977105.6020604@free.fr> <20070713123712.GC28939@frankl.hpl.hp.com> <469777D4.6060900@free.fr>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, oprofile-list@lists.sourceforge.net
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:40016 "EHLO
	tayrelbas01.tay.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbXGMNRq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 09:17:46 -0400
Content-Disposition: inline
In-Reply-To: <469777D4.6060900@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

John,


On Fri, Jul 13, 2007 at 03:02:12PM +0200, John Sigler wrote:
> Stephane Eranian wrote:
> 
> > On PIII, CPU_CLK_UNHALTED is broken and keeps on counting while in HALT state.
> 
> Stephane,
> 
> Would you have a reference?
> 
No references, just my presonal experience. You'd have to ask Intel for a confirmation
or just file a bug report. I don't know where, unfortunately.

Note that the event works on Pentium M.

> There is no such mention in the latest Specification Update (May 2007).
> 
> http://developer.intel.com/design/intarch/specupdt/244453.htm
> 
> Regards.
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> oprofile-list mailing list
> oprofile-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/oprofile-list

-- 

-Stephane
