From: Pradyumna Sampath <pradysam@gmail.com>
Subject: Re: Which version of preempt_realtime to use?
Date: Tue, 20 Jan 2009 14:00:55 +0530
Message-ID: <6d09081c0901200030o3eeb9145m4540631a80f442bb@mail.gmail.com>
References: <1232366467.31686.10.camel@localhost.localdomain>
	 <49748567.30201@osadl.org> <4974E686.60105@hedrich-winders.com>
	 <20090120074903.GX29067@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?J=FCrgen_Mell?= <mell@hedrich-winders.com>,
	Carsten Emde <Carsten.Emde@osadl.org>, esn@terma.com,
	linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:63853 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbZATIa4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Jan 2009 03:30:56 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3015924rvb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Jan 2009 00:30:56 -0800 (PST)
In-Reply-To: <20090120074903.GX29067@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Robert, Jurgen,

On Tue, Jan 20, 2009 at 1:19 PM, Robert Schwebel
<r.schwebel@pengutronix.de> wrote:
>
> Can you reproduce these long latencies with cyclictest, or does it only
> happen with your code?
>

A few months ago, I had hit some really long latencies when ptpd (1588
time synch) was trying to synchronize from 1970 to the current time.
After the time change we could observe some really long latencies.
Maybe, your device might also be

Here is the post I made about it.
http://marc.info/?l=linux-rt-users&m=122111918015981&w=4

regards
/prady
-- 
http://prady.in
