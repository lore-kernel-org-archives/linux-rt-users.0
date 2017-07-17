From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Subject: Re: RT kernel on Acer laptop unreliable
Date: Mon, 17 Jul 2017 08:21:29 +0200
Message-ID: <ac7edffc-9f5f-527d-71b1-211ffa342ddc@numalliance.com>
References: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
To: Jacek Konieczny <jajcus@jajcus.net>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.numalliance.com ([194.2.198.111]:55756 "EHLO
        mail.numalliance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbdGQG2L (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Jul 2017 02:28:11 -0400
In-Reply-To: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
Content-Language: fr
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

If you don't manage to achieve realtime, you have some wrong options in 
your kernel settings .

Please share your kernel config.

Regards,

S.Ancelot


Le 15/07/2017 à 19:43, Jacek Konieczny a écrit :
> Hello,
>
> I need low and stable latency for audio processing. I use Guitarix,
> Ardour and other jack-based applications. For anything else I would use
> the regular kernel package from my distribution (PLD Linux), but the
> latency spikes are unacceptable in some cases. That is why I have been
> trying to use RT kernel, for a few months now…
>
> First I added the RT patch to the PLD Linux kernel package. I have tried
> both the 4.4 and 4.9 kernel. Neither of them worked well. Then I
> manually compiled a few vanilla 4.9.x kernels, just with the most recent
> RT patch and with a configuration made from scratch (not to copy any PLD
> mistakes). Still no luck.
>
> Most of the information I could find online is quite outdated or
> incomplete, so I have really little idea what the proper configuration
> of the RT kernel is or how to debug it.
>
> When the RT kernel works, it would provide quite acceptable latency – I
> could get down to 8ms in jack with no significant xruns. Unfortunately
> none of the RT kernels I tried would be reliable. With little load the
> system would work for a few hours sometimes, but often it would slow
> down and crash much earlier. With high load, e.g. when trying to play
> some demanding game, the system would usually crash quite quickly.
>
> Sometimes it would just lock up hard with no warning and nothing would
> work – not even magic sysrq.
> Other times it would gradually slow down until it is not usable at all.
> Sometimes I would be able to see some 'BUG' in dmesg, but rarely I would
> be able to restart the system cleanly.
> Sometimes only some subsystems would fail, while otherwise the system
> still seems to work. It could be sound, mouse, keyboard or network that
> doesn't work.
>
> System logs would contain some kernel BUGs/WARNINGs, but they would
> often look generic and would not point to a specific problem (not for me).
>
> Today I have tried kernel 4.9.37 with the 4.9.35-rt25 patch. It failed
> again, here are the kernel error logs:
>
> https://gist.github.com/Jajcus/494b79062b537269b49265ff3c50ee78
>
> I have no idea how to properly debug the problem, even what data should
> I collect to prepare a reasonable bug report.
>
> I have already upgraded laptop firmware to the latest available, I have
> also played with some BIOS setup options.
>
> One thing that looks suspicious is the amount of time spent in IRQ 16
> handling, which is: 'idma64, i801_smbus, i2c_designware'. Also the
> i801-smbus in i2c-designware-platform were first to fail when loaded.
> Regular kernel (without PREEMPT_RT_FULL) seems to generate much lower
> number of those interrupts.
>
> However, the system would crash even if the i2c modules are blacklisted
> and not loaded. Getting rid of idma64 would not help much either. IRQ 16
> would not come any more, but the system would slow down and crash anyway.
>
>
> Any idea what is the problem?
> Any hints how to debug it?
>
>
> Greets,
> Jacek
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
