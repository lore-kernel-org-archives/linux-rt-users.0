From: "Mathias Koehrer" <mathias.koehrer@etas.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference on 3.18.13-rt10
Date: Tue, 14 Jul 2015 16:24:54 +0200
Message-ID: <55A51BB6.4070606@etas.com>
References: <453aa7881ded41e7a843795863ac1712@FE-MBX1012.de.bosch.com>	<alpine.DEB.2.11.1507091605410.5134@nanos>	<c7ec9b06a341497687b03c367196f534@FE-MBX1012.de.bosch.com>	<20150710132318.GA27402@linutronix.de>	<3c9ae4a1f9cb4ac3a96a28c3f65f9442@FE-MBX1012.de.bosch.com>	<20150713091237.GA31747@linutronix.de>	<20150713113430.4c18c965@gandalf.local.home>	<523c30ce4e4c4b53befcd288db178db9@FE-MBX1012.de.bosch.com> <20150714101551.2f39f196@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:65228 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbbGNOY5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2015 10:24:57 -0400
In-Reply-To: <20150714101551.2f39f196@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steve!
>>> What's the test that was run, and how did it enable function tracing?
>>
>> The tracing was enabled within an init script using the following bash commands:
>>      if ! grep -q "/sys/kernel/debug" /proc/mounts; then
>>          mount -t debugfs nodev /sys/kernel/debug
>>      fi
>>      if [ -d /sys/kernel/debug/tracing ]; then
>>          (
>>          cd /sys/kernel/debug/tracing
>>          echo "function" > current_tracer
>>          echo "1" > tracing_on
>>
>>          echo "1" > /proc/sys/kernel/ftrace_dump_on_oops
>>          )
>>      fi
>>
>>
>> The test was to reboot the PC permanently (every minute).
>> The reboot has been initiated by another PC that remotely controls the PC under test.
>>
>
> How reproducible is this?
Unfortunately this is not really reproducable.
I caught this bug after approx. 400 reboots while hunting another bug...

Regards

Mathias
