From: pradyumna.sampath@in.abb.com
Subject: Re: Status of -rt for linux-2.6.20/arch/powerpc
Date: Tue, 6 Mar 2007 13:32:26 +0530
Message-ID: <OF77E4A7D3.89DEBB42-ON65257296.002B7648-65257296.002B9862@abbasiapacific.com.sg>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	Boundary="0__=EABBF805DFB8F0D88f9e8a93df938690918cEABBF805DFB8F0D8"
Cc: wg@grandegger.com, r.schwebel@pengutronix.de,
	linux-rt-users@vger.kernel.org
To: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from apisx02.abbasiapacific.com.sg ([210.24.147.18]:3700 "EHLO
	apisx02.abbasiapacific.com.sg" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752201AbXCFILm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2007 03:11:42 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--0__=EABBF805DFB8F0D88f9e8a93df938690918cEABBF805DFB8F0D8
Content-type: text/plain; charset=us-ascii


Hi Everyone,

I came across the errors that Wolfgang Grandegger describes
http://article.gmane.org/gmane.linux.rt.user/224 . I downloaded the latest
patch , -rt8 and I continue to get the same merge errors and the make fail
in arch/powerpc/kernel/time.c .

Is there a patch which has these fixed ? Im trying to get RT-PREEMPT
working on my Lite5200 board.

Thanks in advance.

regards
prady




                                                                                                     
 (Embedded     Thomas Gleixner <tglx@linutronix.de>@vger.kernel.org                                  
 image moved   02/11/2007 10:09 PM                                                                   
 to file:                                                                                            
 pic04031.pcx)                                                                                       
                                                                                                     
                                                                                                     


Sent by:    linux-rt-users-owner@vger.kernel.org


To:    Wolfgang Grandegger <wg@grandegger.com>
cc:    Robert Schwebel <r.schwebel@pengutronix.de>,
       linux-rt-users@vger.kernel.org
Subject:    Re: Status of -rt for linux-2.6.20/arch/powerpc

Security Level:?              Internal

On Sun, 2007-02-11 at 17:37 +0100, Wolfgang Grandegger wrote:
> > Yup, I did not come around to do the fixups. Is top on my todo list
> > though.
>
> Apart from that, I also realized that it's not possible to enable
> HIGH_RES_TIMERS, because GENERIC_CLOCKEVENTS is not selected or
> available for PowerPC.

Yup, the whole bunch is missing. It got dropped at some point.

             tglx


-
To unsubscribe from this list: send the line "unsubscribe linux-rt-users"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html




--0__=EABBF805DFB8F0D88f9e8a93df938690918cEABBF805DFB8F0D8
Content-type: application/octet-stream;
	name="pic04031.pcx"
Content-Disposition: attachment; filename="pic04031.pcx"
Content-transfer-encoding: base64

CgUBCAAAAABBADEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAABQgABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAA=

--0__=EABBF805DFB8F0D88f9e8a93df938690918cEABBF805DFB8F0D8--
