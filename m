From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: 2.6.26.6-rt11 nanosleep() does have accurate behavior
Date: Fri, 7 Nov 2008 20:17:09 +0100
Message-ID: <c384c5ea0811071117y33a5a5fdq107037e7b2c56140@mail.gmail.com>
References: <49146512.4020107@atl.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Gautam Thaker" <gautam.h.thaker@lmco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:3806 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbYKGTRL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Nov 2008 14:17:11 -0500
Received: by qw-out-2122.google.com with SMTP id 3so851944qwe.37
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2008 11:17:10 -0800 (PST)
In-Reply-To: <49146512.4020107@atl.lmco.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Gautam,

On Fri, Nov 7, 2008 at 4:56 PM, Gautam Thaker <gautam.h.thaker@lmco.com> wrote:
> I recently started to study how nanosleep() behaves under 2.6.26.6-rt11
> compiled in in FULL PREEMPT, uniprocessor mode.  I find that between
> 2.6.20-rt8 and this new kernel something has changed and nanosleep() is back
> to its old behavior or sleeping for next higher number of msec rather than
> carefully following the "y=x" line.
>
> I don't follow the RT world closely enough, but is this a regression or an
> expected change in behavior? The link below show the results very clearly.
>
> http://www.atl.external.lmco.com/projects/QoS/documents/nanosleep_1.png
>
This suggests (to me) that you probably did not enable HRTIMERS?

Regards,
-- 
Leon
