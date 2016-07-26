From: Bernhard Landauer <oberon@manjaro.org>
Subject: Re: rt8 and virtualbox-dkms
Date: Tue, 26 Jul 2016 15:53:54 +0200
Message-ID: <cb3206d6-3967-a775-edc4-ea1fe0e5653a@manjaro.org>
References: <1e93878d-4357-16fc-009e-b01c0efacfc5@manjaro.org>
 <6b0724e6-de34-9c8c-53d2-c36396c7f237@manjaro.org>
 <20160726134438.GA24262@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from manjaro.org ([176.9.38.148]:34378 "EHLO manjaro.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbcGZNyE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Jul 2016 09:54:04 -0400
In-Reply-To: <20160726134438.GA24262@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Ok. Thank you for the information.

regards
Bernhard


On 26/07/16 15:44, Sebastian Andrzej Siewior wrote:
> * Bernhard Landauer | 2016-07-23 02:02:52 [+0200]:
>
>> $ grep -re "mod_timer_pinned"
>> src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:# define
>> mod_timer_pinned               mod_timer
>> src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:
>> mod_timer_pinned(&pSubTimer->u.Std.LnxTimer,
>> pSubTimer->u.Std.ulNextJiffies);
>> src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:
>> mod_timer_pinned(&pSubTimer->u.Std.LnxTimer,
>> pSubTimer->u.Std.ulNextJiffies);
>> src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:
>> mod_timer_pinned(&pSubTimer->u.Std.LnxTimer,
>> pSubTimer->u.Std.ulNextJiffies);
>>
>> So does that mean the rt-kernel will no longer run VirtualBox??
> This change will be part of v4.8. If virtualbox wants to work with v4.8+
> they need to update their code. Once this happens, it will work with
> -RT.
>
>> Regards
>> Bernhard Landauer
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

