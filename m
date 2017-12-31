From: Gene Heskett <gheskett@shentel.net>
Subject: Re: Current Best Practices for accessing PWM devices in real-time
Date: Sun, 31 Dec 2017 00:57:08 -0500
Message-ID: <201712310057.08417.gheskett@shentel.net>
References: <CAF_dkJBVERqULLKZxA4BqoTsUotrvZyoRwvh-+JJC6mPG08euw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from barracuda1.shentel.net ([204.111.1.144]:33515 "EHLO
        barracuda1.shentel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdLaGJN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 31 Dec 2017 01:09:13 -0500
Received: from smtp1.edbg.cloud.shentel.net (smtp1.edbg.cloud.shentel.net [204.111.2.17]) by barracuda1.shentel.net with ESMTP id OUpMwHKpMpDGlqmI for <linux-rt-users@vger.kernel.org>; Sun, 31 Dec 2017 00:57:14 -0500 (EST)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp1.edbg.cloud.shentel.net (Postfix) with ESMTPSA id 716DB2033D
        for <linux-rt-users@vger.kernel.org>; Sun, 31 Dec 2017 00:57:14 -0500 (EST)
In-Reply-To: <CAF_dkJBVERqULLKZxA4BqoTsUotrvZyoRwvh-+JJC6mPG08euw@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Saturday 30 December 2017 17:52:32 Patrick Doyle wrote:

> (I had so much luck with my previous "CBP" query, that I think I'm
> going to keep this up).
>
> Many SoC's have general purpose PWM controllers built into the device.
>
> What are the current best practices for accessing PWM controlled
> external peripherals (such as motor drivers) from within a real-time
> Linux thread?
>
> Do folks primarily access the PWM peripheral via the /sys/class/pwm
> interface as described at
> https://www.kernel.org/doc/Documentation/pwm.txt?  Doesn't that seem
> terribly inefficient?
>
> Do folks write their own "motor control" driver and run them in kernel
> context?  Although RT-Linux patches will undoubtedly help this sort of
> approach, doesn't that sort of defeat the purpose of real-time Linux
> (running real-time code in user space threads)?
>
> Do folks do something completely different?
>
LinuxCNC user here, 4 machines, but hobby shop status, no income from it.

Generally we use an outboard controller card for such as spindle motor 
variable speed control. I have one machine yet that is doing software 
pwm, and I found years ago, a card made by PMDX that serves as both the 
required AC isolation needed to control 99.9% of the OEM motor 
controllers, and as a surprisingly linear control, giving without any 
encoder derived feedback, an extremely stiff control, doing it so 
silently I had to put an ammeter in the motor leads to see how hard it 
was working, otherwise I couldn't afford the fuses I was blowing.

I also have a Mesa SpinX1 controlling a vfd, using a high speed (20 KHz) 
pwm generator in a Mesa 7i90 interface card. And 2 of the Pico Systems 
pwm-servo amplifiers (160 volt, 20 amps) to spin 1 HP motors as spindle 
motors in 2 other machines. But those have always been problematic in 
terms of control linearity if there are any opto-isolators in the path 
as they simply are not fast enough. Surgically remove the opto from that 
pin of the breakout board and everybody is happy. I am a C.E.T if that 
counts, and a long retired broadcast engineer. So all this serves to 
keep me out of the bars.

My next question for this group, and its waiting until I get the spi 
driver ported from the pi that running that 3/4 ton lathe, to a rock64 
board, which will get rid of several things the pi doesn't do well, like 
pay attention to its own keyboard. Something is wrong, and whatever it 
is, can be fixed by a few random reboots, sometimes its worse and 
sometimes it perfect for 3 or 4 weeks at a time. Once past that, and the 
code to run the machine is in its sdram, it runs the lathe flawlessly. 
But the rock64 is easily 10x faster than a pi.

I do not have  but one machine doing software step generation. That right 
there, limits the machine to a maximum speed of any axis to around 8 or 
9 IPM because the software method is too slow, and an extra 10 
microseconds between steps will often "stall" a stepper. Machines with 
hardware step generators plugged in can move at 90+ IPM with the same 
power supply and motor driver, thats the diff between softwares shaky 
timing and the steady heartbeat of an fpga based generator. Anything you 
folks can do to improve our latency test results in a base thread that 
may be running at a 20 microsecond loop rate, will reduce the cost of 
converting a machine to cnc by as much as $150, and will have us bowing 
to a new $DIETY.

And thats my $0.02. From a lurker on this list.

> Again, thanks for tips & pointers.
>
> Stay tuned for my next episode, to be entitled something like "Current
> Best Practices for Counting External Events in real-time".  (I'm still
> working on a less wordy title.)
>
> --wpd
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
