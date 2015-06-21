From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: problems rt-patch 3.18.13.rt-10
Date: Sun, 21 Jun 2015 17:58:24 +0200
Message-ID: <5586DF20.5060902@osadl.org>
References: <CAObZbXRuziL+L-22yY1oz5fy9b+YjxY2kXuJKdH-Q=Ci+WaUhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Daniel Vidal <danielvidalchornet@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:46497 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbbFUQCL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 21 Jun 2015 12:02:11 -0400
In-Reply-To: <CAObZbXRuziL+L-22yY1oz5fy9b+YjxY2kXuJKdH-Q=Ci+WaUhQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Daniel,

> I have been compile an install a 3.18.13.rt-10.
> My system hangs after a random time.
> I must use SysRq keys to obtain any information.
> The problem seems related with radeon or Xorg.
> Here is the messages of kern.log
> http://pastebin.com/MgQSyXi9
This is a known misbehavior -> 
http://comments.gmane.org/gmane.linux.rt.user/13192.

Please go back to 3.12 to run Radeon graphics with RT.

Thanks,
	-Carsten.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
