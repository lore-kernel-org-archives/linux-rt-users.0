From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: CLOCK_REALTIME instead of CLOCK_MONOTONIC for PTP coupled
 RT_PREEMPT systems?
Date: Thu, 7 Aug 2014 07:44:27 +0200
Message-ID: <20140807054427.GA4435@netboy>
References: <4c361c69cd0a4b2690542c1a5bc1c2a1@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:43287 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756937AbaHGFoi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Aug 2014 01:44:38 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so10000462wib.3
        for <linux-rt-users@vger.kernel.org>; Wed, 06 Aug 2014 22:44:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4c361c69cd0a4b2690542c1a5bc1c2a1@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jul 24, 2014 at 07:36:06AM +0000, Koehrer Mathias (ETAS/ESW5) wrote:
> What speaks against using CLOCK_REALTIME for the real time application?
> Are there any drawbacks? 

The only drawback is that, in general, someone else might set the
time. This can happen in three ways.

1. local root user calls settime
2. system boots with large time offset, then learns the correct time
   using NTP or PTP, then resets the local clock to match.
3. when using NTP or PTP, the remote root user calls settime

> With our application I can ensure that no manually set of the time occurs.

You also will want to make sure that the application does not start
until case #2 has occurred. Both NTP and PTP provide ways to find out
the synchronization state.

So, if you can control the networked run time environments, then there
is no drawback to using CLOCK_REALTIME.

Thanks,
Richard
