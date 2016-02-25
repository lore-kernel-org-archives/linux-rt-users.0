From: Tim Sander <tim@krieglstein.org>
Subject: Re: Large latencies with 4.4.1-rt6
Date: Thu, 25 Feb 2016 13:34:22 +0100
Message-ID: <2742233.B1dMNehWr7@dabox>
References: <1A2AF5F768264E479963C4D8C015EB691B692C5C@dlrexmbx03.intra.dlr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-rt-users@vger.kernel.org
To: Martin.Wirth@dlr.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from krieglstein.org ([176.28.13.145]:47738 "EHLO
	lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759644AbcBYMe1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 07:34:27 -0500
In-Reply-To: <1A2AF5F768264E479963C4D8C015EB691B692C5C@dlrexmbx03.intra.dlr.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Martin

Am Freitag, 19. Februar 2016, 17:02:20 schrieb Martin.Wirth@dlr.de:
> I today switched from 4.1.15-rt17 to 4.4.1-rt6.
> Now I'm seeing large latencies of more than 1 ms.
> They occur sporadic ( every few minutes) and show up for example running
It would be interesting to know the platform the rt kernel is running on?

I have also seen a latency increase with 4.4.1-rtX releases. I have the 
impression that some stable kernel updates made it worse. Care to test 4.4-rt3 
or 4.4-rt4? Had not the chance to pin them down by now.

Best regards
Tim
