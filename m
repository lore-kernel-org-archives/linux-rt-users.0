From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: fully bisectable real time series
Date: Mon, 07 Apr 2008 17:41:09 -0700
Message-ID: <1207615269.17662.9.camel@sven.thebigcorporation.com>
References: <1207611243.21308.167.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, mingo@elte.hu
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:55474 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbYDHAlM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Apr 2008 20:41:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1536475wah.23
        for <linux-rt-users@vger.kernel.org>; Mon, 07 Apr 2008 17:41:10 -0700 (PDT)
In-Reply-To: <1207611243.21308.167.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 2008-04-07 at 16:34 -0700, Daniel Walker wrote:
> I've re-worked the -rt series, and some of the core patches to make it
> all bisectable. I've done bisect updates in the past which really only
> scratched the surface.

I had started on a forward-port to .25, but I got completely
side-tracked with a lot of other stuff.

The bi-sectable series is vary valuable for such porting efforts, and
the current series needs major cleanup, since there are a lot of fixes,
and code-backouts (e.g. softirq from hardirq thread context), which
interfere with testing of a back-port at each level.

So this is a valuable effort, and I hope that at least some of what you
have done will make it into .25's RT port.

If I have time to work on the port in the next couple of days, before
Steven gets to it, I will see what if any of your stuff can be used.

Thanks,

Sven

