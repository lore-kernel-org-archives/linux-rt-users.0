From: Bernhard Landauer <oberon@manjaro.org>
Subject: Re: rt8 and virtualbox-dkms
Date: Fri, 19 Aug 2016 13:02:32 +0200
Message-ID: <23418d87-69ec-f223-30a5-8fd03f1b3f95@manjaro.org>
References: <1e93878d-4357-16fc-009e-b01c0efacfc5@manjaro.org>
 <6b0724e6-de34-9c8c-53d2-c36396c7f237@manjaro.org>
 <20160726134438.GA24262@linutronix.de>
 <cb3206d6-3967-a775-edc4-ea1fe0e5653a@manjaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.manjaro.org ([176.9.38.148]:56003 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753969AbcHSLDA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Aug 2016 07:03:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 3E7CC30E08F1
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Aug 2016 13:02:36 +0200 (CEST)
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bJWhS0WaV7sS for <linux-rt-users@vger.kernel.org>;
        Fri, 19 Aug 2016 13:02:34 +0200 (CEST)
In-Reply-To: <cb3206d6-3967-a775-edc4-ea1fe0e5653a@manjaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

For reference, here's how we solved this now for Manjarolinux (Thank's a 
lot, Sebastian, for your advice!)

For 4.6.x_rt series we have added a specific define:

KBUILD_CPPFLAGS := -D__KERNEL__ -DRT_PATCHED

and extended Oracle's pending linux48 patch
(https://www.virtualbox.org/changeset/63341/vbox)
by testing:

# if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 8, 0) || defined(RT_PATCHED)

Against virtualbox-extramodules patched like that we are now able to 
compile regular linux46 and 47 aswell as rt-patched 46.


On 26/07/16 15:53, Bernhard Landauer wrote:
> Ok. Thank you for the information.
>
> regards
> Bernhard
>
>
> On 26/07/16 15:44, Sebastian Andrzej Siewior wrote:
>> * Bernhard Landauer | 2016-07-23 02:02:52 [+0200]:
>>
>>> $ grep -re "mod_timer_pinned"
>>> src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:# define
>>> mod_timer_pinned               mod_timer
>>> src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:
>>> mod_timer_pinned(&pSubTimer->u.Std.LnxTimer,
>>> pSubTimer->u.Std.ulNextJiffies);
>>> src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:
>>> mod_timer_pinned(&pSubTimer->u.Std.LnxTimer,
>>> pSubTimer->u.Std.ulNextJiffies);
>>> src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:
>>> mod_timer_pinned(&pSubTimer->u.Std.LnxTimer,
>>> pSubTimer->u.Std.ulNextJiffies);
>>>
>>> So does that mean the rt-kernel will no longer run VirtualBox??
>> This change will be part of v4.8. If virtualbox wants to work with v4.8+
>> they need to update their code. Once this happens, it will work with
>> -RT.
>>
>>> Regards
>>> Bernhard Landauer
>> Sebastian
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

