From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: remembering rt-sched attributes - was: [LAD] rtirq script is
 broken with  2.6.31
Date: Mon, 10 Aug 2009 23:35:19 +0100
Message-ID: <4A80A0A7.8000807@rncbc.org>
References: <4A7B01F3.2060200@gareus.org> <4A7B3EA6.1080509@rncbc.org> <4A7C259D.9020409@gareus.org> <4A7EE291.3000500@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	The Linux Audio Developers' Mailing List
	<linux-audio-dev@lists.linuxaudio.org>
To: Robin Gareus <robin@gareus.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx.netcabo.pt ([212.113.174.24]:6650 "EHLO mx.netcabo.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011AbZHJWjd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Aug 2009 18:39:33 -0400
In-Reply-To: <4A7EE291.3000500@gareus.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Robin Gareus wrote:
> Hello rt-users and -devs,
> 
> I have a question about per-device-IRQ-threads in 2.6.31-rc5-rt1.1:
> 
> After a suspend/resume cycle some IRQ-threads come up with a new PID.
> The scheduling policy of those threads is reset to default values
> instead of retaining the previously set values.
> 
> Is this an issue that is being worked on? Or must userspace from now on
> re-init rtprio settings after each suspend/resume cycle?
> 
> As you can see from the information below (from linux-audio-dev @
> linuxaudio.org) not all IRQ-threads are re-started, but for example the
> HDA-Intel is. It may just as well be a specific issue with snd_hda_intel
> (and sdhci, e1000e, i810/intelfb,..).
> 
> Robin Gareus wrote:
>> Rui Nuno Capela wrote:
>>>>  [..]
>>>>
>>>> Yes, I'm also baffled at the high PIDs for IRQs. I hazard a guess that
>>>> those are a result of a suspend/resume cycle; and I'll check later if
>>>> the chrt settings do persist after a suspend/resume.
>> It looks like the guess was correct. The PIDs change after
>> suspend/resume and the chrt settings are retained here.
> Sorry I was too quick, there. After some more suspend/resumes cycles and
> a closer look: the previous statement is not correct.
> 
> RTPRIO is reset when the IRQ handler process restarts under new PID.
> However not all IRQ threads are re-launched:
> 
> [from /proc/interrupts]
>  17:   78393056     873204   IO-APIC-fasteoi   uhci_hcd:usb3, HDA Intel,
> ohci1394
>  18:     451927    2099364   IO-APIC-fasteoi   uhci_hcd:usb4, mmc0
> 
> before suspend:
>   PID CLS RTPRIO  NI PRI %CPU STAT COMMAND
>  1418 FF      90   - 130  0.0 S<   irq/8-rtc0	
>  1450 FF      89   - 129  0.0 S<   irq/18-uhci_hcd	
> 32506 FF      88   - 128  0.1 S<   irq/17-HDA Inte	
> 32507 FF      87   - 127  0.0 S<   irq/17-ohci1394	
>  1447 FF      50   -  90  0.2 S<   irq/17-uhci_hcd	
> 32508 FF      50   -  90  0.0 S<   irq/18-mmc0	
> ...
> 
> after resume:
> 
>   PID CLS RTPRIO  NI PRI %CPU STAT COMMAND
>  1418 FF      90   - 130  0.0 S<   irq/8-rtc0	
>  1450 FF      89   - 129  0.0 S<   irq/18-uhci_hcd	
>   388 FF      50   -  90  0.0 S<   irq/17-HDA Inte	
>   389 FF      50   -  90  0.0 S<   irq/17-ohci1394	
>   390 FF      50   -  90  0.0 S<   irq/18-mmc0	
>  1447 FF      50   -  90  0.2 S<   irq/17-uhci_hcd	
> ...
> 
> As you can see all IRQ17 threads get reset completely; on IRQ18 only
> mmc0 gets a new PID but the usb retains it's PID and rtprio.
> 
> 
> My first assumption - that it could correlate with the device being in
> use while suspending - did also proove wrong: I tried suspending with
> JACKd using an USB audio device on IRQ18 (instead of HDA-Intel on IRQ17)
> and after resume IRQ18 has still high rtprio, while IRQ17 has been reset
> whether in use or not.
> 
> However, after unloading the HDA-Intel module, the other IRQ-threads on
> IRQ17 (ohci1394 and uhci_hcd:usb3) retain their PID and rtprio. So it
> seems there's something with the HDA driver and/or hardware that causes
> the kernel to re-initialize IRQ process.
> 
> <OT>
> I usually unload the sd-card mmc0 driver and connect a USB-UA25 on
> uhci_hcd:usb4; It then is the sole device on IRQ18 and works without
> x-runs even at 64 spp * 3p / 48000sps = 4ms audio latency with JACKd.
> 
> With 2.6.29.6-rt23 I get x-runs at these low latencies when not
> unloading the mmc0 driver. With 2.6.31-rc5-rt1.1 I don't. So the
> per-driver IRQ priority does work.. YAY.
> </OT>
> 

picking on old subject, why not doing a plain `/etc/init.d/rtirq
restart` on resume?

byee
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
