From: "B, Ravi" <ravibabu@ti.com>
Subject: RE: OHCI issue with RT patch
Date: Mon, 25 Oct 2010 17:00:34 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593023461B02B@dbde02.ent.ti.com>
References: <S1756980Ab0JVN4w/20101022135653Z+208@vger.kernel.org>
	<B85A65D85D7EB246BE421B3FB0FBB593023461A852@dbde02.ent.ti.com>
 <AANLkTi=OFXjCagmj4RgoLV6jNbq4-MCmZ0J+RAzQmXoi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58043 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754893Ab0JYLb1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Oct 2010 07:31:27 -0400
In-Reply-To: <AANLkTi=OFXjCagmj4RgoLV6jNbq4-MCmZ0J+RAzQmXoi@mail.gmail.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

> > I am using Linux 2.6.33.7 stable kernel + 
> patch-2.6.33.7-rt29 to test OHCI interface on TI OMAPL138 platform.
> > We observed that during bootup and OHCI init sequence the kernel 
> > hangs. If we use plane Linux 2.6.33.7 stable kernel Without 
> RT patch then OHCI works fine.
> 
> Just a guess: Are you using the SLAB or SLOB allocator?
> We have seen that SLOB gives all kinds of weird problems in 
> OHCI. SLAB works fine here.

Thanks for the reply. I am using the SLAB allocator. 

> 
> Kind regards,
> 
> Remy
> 