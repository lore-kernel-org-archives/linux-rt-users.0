From: Joshua Hernstrom <joshua.hernstrom@ni.com>
Subject: Requesting suggestions on ARM based test platforms
Date: Wed, 17 Dec 2014 16:30:01 -0600
Message-ID: <20141217163001.6c22f5ba@tyr.amer.corp.natinst.com>
References: <S1751095AbaLQVaK/20141217213010Z+547@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:52899 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751189AbaLQWaQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Dec 2014 17:30:16 -0500
Received: from us-aus-mgwout2.amer.corp.natinst.com (nb-chan1-1338.natinst.com [130.164.19.134])
	by us-aus-skprod3.natinst.com (8.14.5/8.14.5) with ESMTP id sBHMUFCe026327
	for <linux-rt-users@vger.kernel.org>; Wed, 17 Dec 2014 16:30:15 -0600
In-Reply-To: <S1751095AbaLQVaK/20141217213010Z+547@vger.kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am investigating an increase in baseline jitter on my ARMv7 platform after moving from a 3.2 to 3.14 kernel and want to gather data on similar platforms. Can anyone recommend ARM boards (ideally v7 family, but all suggestions welcome) that you think would make a good candidate for me to test upon?  The main criteria being that it has support as far back as 3.2, and that more recent kernels (roughly, 3.10 and later) still show good baseline jitter (<100us).

I have been trying to use an OMAP3505-based Gumstix Overo but having trouble getting reasonable looking numbers with more recent kernels, and before spending any more time digging on that front, I'd like to compare some other boards.

Poking around on the OSADL site, the Beaglebone-Black looks like a good candidate; any other suggestions that the wisdom of the crowd can throw my way?

Thank you,
Josh
