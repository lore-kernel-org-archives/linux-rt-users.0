From: Stanislav Meduna <stano@meduna.org>
Subject: Re: Linux RT newbie question
Date: Mon, 8 Feb 2016 15:44:01 +0100
Message-ID: <56B8A9B1.9010904@meduna.org>
References: <41302A7145AC054FA7A96CFD03835A0A0BA89C7D@EX10MBX02.EU.NEC.COM>
 <56B8A042.5000604@meduna.org>
 <41302A7145AC054FA7A96CFD03835A0A0BA8AD12@EX10MBX02.EU.NEC.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Aldrich <David.Aldrich@EMEA.NEC.COM>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:44031 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119AbcBHOoJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Feb 2016 09:44:09 -0500
In-Reply-To: <41302A7145AC054FA7A96CFD03835A0A0BA8AD12@EX10MBX02.EU.NEC.COM>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2/8/2016 3:28 PM, David Aldrich wrote:

> Well, I was not aware of this until reading your email and I read
> ' HOWTO: Build an RT-application' on rt.wiki.kernel.org.
> The HowTo suggests ways of reducing the impact of SMI interrupts.
> Is this possible?

I don't know - we are using industrial PCs so I don't really have
an experience with how big this problem is in reality on common
desktops. It also depends on what your deadlines are and how hard
they are (i.e. what happens if they are not met once in say
1000 calls).

> Do you build your kernel yourselves?

Yes, including some home-brew drivers and patches (none of them
specifically in the rt area) and stripped of features and drivers
not needed for the platform.

> I'm not sure that the audio community is the most appropriate
> for my application.

The audio community is most probably the largest group needing
realtime on common desktop hardware, so this is indeed a good
place to ask.

Regards
-- 
                                         Stano

