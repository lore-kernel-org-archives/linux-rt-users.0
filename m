From: Tim Sander <tim@krieglstein.org>
Subject: Re: 3.4.28-rt40 arm freescale imx35 pcm43 - patch 86236252d2449313bdbac790023cbc957bf6e426 is cause
Date: Thu, 07 Feb 2013 09:57:48 +0100
Message-ID: <1525614.TvuV6qqnEF@dabox>
References: <6003615.pRQnIgKCSn@dabox> <5977343.5KpmQXLB4x@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lvps176-28-13-145.dedicated.hosteurope.de ([176.28.13.145]:38868
	"EHLO lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752528Ab3BGI5w (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Feb 2013 03:57:52 -0500
Received: from dabox.localnet (unknown [213.157.30.20])
	by lvps176-28-13-145.dedicated.hosteurope.de (Postfix) with ESMTPSA id CD0F4A8A407B
	for <linux-rt-users@vger.kernel.org>; Thu,  7 Feb 2013 09:57:48 +0100 (CET)
In-Reply-To: <5977343.5KpmQXLB4x@dabox>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

Just another update on this stuff. I noticed that there has been a patch added* 
with spinlocks to the imx.c serial driver. I reverted this patch and now my 
serialfuz programm "only" kills the serial port with a not so nice oom 
condition. But at least it does not show the runaway interrupt problem.

Best regards
Tim

* its 86236252d2449313bdbac790023cbc957bf6e426
    commit 9ec1882df244c4ee1baa692676fef5e8b0f5487d upstream.
