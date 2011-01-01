From: Arnout Engelen <arnouten@bzzt.net>
Subject: Tweaking pengutronix' debian packages for rt kernels
Date: Sat, 1 Jan 2011 17:10:00 +0100
Message-ID: <20110101161000.GY32493@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-4.concepts.nl ([213.197.30.111]:57667 "EHLO
	smtp-4.concepts.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab1AAQZG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 1 Jan 2011 11:25:06 -0500
Received: from 5ee5397b.ftth.concepts.nl
	([94.229.57.123] helo=mail.bzzt.net ident=Debian-exim)
	by smtp-4.concepts.nl with esmtp (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1PZ41o-0008Oc-13
	for linux-rt-users@vger.kernel.org; Sat, 01 Jan 2011 17:10:00 +0100
Received: from arnouten by localhost with local (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1PZ41o-0003KW-Rh
	for linux-rt-users@vger.kernel.org; Sat, 01 Jan 2011 17:10:00 +0100
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

http://www.pengutronix.de/software/linux-rt/debian_en.html mentions this 
would be the right place to discuss the Pengutronix Debian packages containing
RT-patched kernels.

Is there any guide that documents how to build tweaked versions of these 
packages? Pengutronix seems to be doing a great job, but for example the 
package for the 2.6.33.7.2-rt30 kernel doesn't contain the 'nouveau' graphics
driver, which I happen to use. 

Some pointers on how to create a version of the packages including the
'nouveau' modules would be very helpful.


Kind regards,

Arnout
