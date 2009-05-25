From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: Oops issue with patch-2.6.29.4-rt15
Date: Mon, 25 May 2009 09:44:25 +0200
Message-ID: <4A1A4C59.707@xs4all.nl>
References: <4A1A38AF.4000706@xs4all.nl> <alpine.LFD.2.00.0905250930080.3582@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pindarots.xs4all.nl ([80.101.128.228]:51234 "EHLO
	pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbZEYHob (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 May 2009 03:44:31 -0400
In-Reply-To: <alpine.LFD.2.00.0905250930080.3582@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner wrote:
> On Mon, 25 May 2009, Udo van den Heuvel wrote:
>> After rebooting into the new kernel all was fine except a few exceptions:
>> Programs like `top`, `w` and the Gnome system monitor got Oopsed whenever I
>> tried to start them. The rest of the system was stable.
>> Is this normal?
> 
> No. It would be great if you could provide some more detailed
> information. 

Some dmesg logging below.

> What means "got Oopsed" ? Is there an Ooops in the kernel ? If yes,
> please provide the output from dmesg.

http://pastebin.com/d79dc5cbe
http://pastebin.com/d7a9cc7e9
http://pastebin.com/d50d1a0aa

etc.

Kind regards,
Udo

PS: also on irc now.
