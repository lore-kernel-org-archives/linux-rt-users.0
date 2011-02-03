From: Nathan Grennan <linux-rt-users@cygnusx-1.org>
Subject: Re: disk thread problem when using RT-kernel
Date: Thu, 03 Feb 2011 13:02:38 -0800
Message-ID: <4D4B17EE.3020309@cygnusx-1.org>
References: <SNT110-W5817A2D3ADD8DC29980D08A8E70@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from okcforum.org ([173.8.189.10]:44015 "EHLO mail.okcforum.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782Ab1BCVLL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Feb 2011 16:11:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.okcforum.org (Postfix) with ESMTP id A4386CE948
	for <linux-rt-users@vger.kernel.org>; Thu,  3 Feb 2011 13:02:38 -0800 (PST)
Received: from mail.okcforum.org ([127.0.0.1])
	by localhost (okcforum.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ENFt1qjgbOSI for <linux-rt-users@vger.kernel.org>;
	Thu,  3 Feb 2011 13:02:38 -0800 (PST)
Received: from higgs.willowgarage.com (unknown [157.22.19.135])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.okcforum.org (Postfix) with ESMTPSA id 83D67CE89D
	for <linux-rt-users@vger.kernel.org>; Thu,  3 Feb 2011 13:02:38 -0800 (PST)
In-Reply-To: <SNT110-W5817A2D3ADD8DC29980D08A8E70@phx.gbl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/03/2011 12:50 PM, Victor henri wrote:
> Hello
>
> I'm back after some testing.... and it is a complete mess; actually there is more than that just problems with linuxsampler.... with every RT kernel greater than 2.6.31.12 (i started seeing it on gentoo), i have total system freeze... after a few minutes.... to the point that i have to force shut down the system without proper shutdown (i hate doing that); i have installed "das-watchdog" and see the pop-up window saying that das watchdog has disabled real-time for 8 seconds... and this pop-up appears every 8 sec... (forever)... everything happen before i have time to play a single note....
> This old problem is coming again... and i've open a new subject  to solve this first
   It sounds like you are running into the same problem I did a while 
back. I never got to the bottom of it. I am waiting for the 2.6.37-rt 
kernel. See my thread below.

http://www.spinics.net/lists/linux-rt-users/msg06248.html
