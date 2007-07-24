From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [patch 00/15] fixes for rt-test build system
Date: Tue, 24 Jul 2007 09:52:49 -0700
Message-ID: <200707240952.49296.dvhltc@us.ibm.com>
References: <20070724092517.390730736@metis.extern.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:52989 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351AbXGXQw6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 12:52:58 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l6OFl1vc016297
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 11:47:01 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6OGqrxV229132
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 10:52:54 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6OGqob3012311
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 10:52:50 -0600
In-Reply-To: <20070724092517.390730736@metis.extern.pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 24 July 2007 02:25:17 Robert Schwebel wrote:
> Hi Darren,
>
> This is a patch queue which fixes up the remaining issues with your
> recently released rt-test packet. The focus of this series was on

Very much appreciated.  I am no autotools expert, so please be patient with my 
questions :-)

>
> - fixing all GNUmakefile.am files do do the right thing; there have been
>   bogus Makefiles which somehow leaked into your tree

An artifact of the migration to autotools - we caught it after the release.  
Apologies for the mess.

>
> - fix 'make dist-check', which should be your preferred distribution
>   tarball building mechanism in the future. Please don't do that
>   manually, as the autotools make sure you don't forget half of the
>   files if you use their mechanism :-)

Cool.

More comments with the patches...

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
