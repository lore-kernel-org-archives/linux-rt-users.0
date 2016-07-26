From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: rt8 and virtualbox-dkms
Date: Tue, 26 Jul 2016 15:44:39 +0200
Message-ID: <20160726134438.GA24262@linutronix.de>
References: <1e93878d-4357-16fc-009e-b01c0efacfc5@manjaro.org>
 <6b0724e6-de34-9c8c-53d2-c36396c7f237@manjaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Bernhard Landauer <oberon@manjaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:43482 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756447AbcGZNol (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Jul 2016 09:44:41 -0400
Content-Disposition: inline
In-Reply-To: <6b0724e6-de34-9c8c-53d2-c36396c7f237@manjaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Bernhard Landauer | 2016-07-23 02:02:52 [+0200]:

>$ grep -re "mod_timer_pinned"
>src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:# define
>mod_timer_pinned               mod_timer
>src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:
>mod_timer_pinned(&pSubTimer->u.Std.LnxTimer,
>pSubTimer->u.Std.ulNextJiffies);
>src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:
>mod_timer_pinned(&pSubTimer->u.Std.LnxTimer,
>pSubTimer->u.Std.ulNextJiffies);
>src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:
>mod_timer_pinned(&pSubTimer->u.Std.LnxTimer,
>pSubTimer->u.Std.ulNextJiffies);
>
>So does that mean the rt-kernel will no longer run VirtualBox??

This change will be part of v4.8. If virtualbox wants to work with v4.8+
they need to update their code. Once this happens, it will work with
-RT.

>Regards
>Bernhard Landauer

Sebastian
