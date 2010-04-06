From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: 2.6.33.1-rt11 BUG: sleeping function called from invalid context
 at kernel/rtmutex.c:684
Date: Tue, 06 Apr 2010 16:01:48 +0200
Message-ID: <4BBB3ECC.107@xs4all.nl>
References: <4BB8587F.40307@xs4all.nl> <alpine.LFD.2.00.1004061005300.32352@localhost.localdomain> <4BBB3865.9070204@xs4all.nl> <20100406134318.GR4234@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pindarots.xs4all.nl ([80.101.128.228]:51961 "EHLO
	pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab0DFOBu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Apr 2010 10:01:50 -0400
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
	by pindarots.xs4all.nl (8.14.3/8.14.3) with ESMTP id o36E1mWN029359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Tue, 6 Apr 2010 16:01:48 +0200
In-Reply-To: <20100406134318.GR4234@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2010-04-06 15:43, Luis Claudio R. Goncalves wrote:
> | After applying, compilign and rebooting the BUG-messages appear to be
> | gone (after a quick test).
> | Thanks!
> | 
> | Only issue remaining is this message:
> | 
> | Apr  6 15:25:02 nawdew rtkit-daemon[3484]: Failed to make ourselves RT:
> | Operation not permitted
> | (repeated a number of times)
> | 
> | Is this also -rt related?
> 
> here's the description of rtkit:
> 
> 	Summary     : Realtime Policy and Watchdog Daemon
(...)

> One famous user of rtkit is pulseaudio. In fact, it is the only user of
> rtkit on my system. And the message reflects that either your pulseaudio
> config is forbidding usage of RT prios or the user running pulseaudio has
> no rights to use higher priorities (check with ulimit)

At the time rtkit-daemon is/was running as the gdm user since no user
was logged in using the gui.
So perhaps I can fix this in /etc/security/limits.conf?
Hmm.
Putting gdm user in pulse-rt group does fix the rtkit-daemon messages
but not the pulseaudio error.

I will seek help for this elsewhere as it is not so on topic here.

Thanks for the patch!

Udo
