Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45935 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeHVLcl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Aug 2018 07:32:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so598363pfo.12
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Aug 2018 01:08:55 -0700 (PDT)
Subject: Re: kernel freeze when running docker
References: <CAH3OF51v8_KK_XF_sttVzSddmWoLUvVOjbUvKr2OuiJTLntTQQ@mail.gmail.com>
 <20180821012731.GB8562@jcartwri.amer.corp.natinst.com>
 <CAH3OF50F26ywGHZ2Rfa7v-SeoZ6KccSPt+1uNq65eBNTqom=-A@mail.gmail.com>
 <20180821134221.GC8562@jcartwri.amer.corp.natinst.com>
From: Vignesh Raman <vignesh.raman.in@gmail.com>
Message-ID: <d4b10821-ccd1-79cb-f337-403077aba2f6@gmail.com>
Date: Wed, 22 Aug 2018 13:38:49 +0530
MIME-Version: 1.0
In-Reply-To: <20180821134221.GC8562@jcartwri.amer.corp.natinst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: linux-rt-users@vger.kernel.org

Hi Julia,

On Tuesday 21 August 2018 07:12 PM, Julia Cartwright wrote:
> That's annoying.  When you are in this state can you trigger a dump via
> the magic sysrq sequence over serial?

No. I'm not able to trigger a crash using sysrq (Alt+SysRq+c). Keyboard
'caps lock' led light does not respond when caps lock key is pressed.

Does it indicate a softlockup or hardlockup ?

> Have you tried enabling the various lockup detectors?  There is a
> software-driven one, and an NMI watchdog based one.  Enabling both
> at the same time should be fine.

The below config options are enabled,
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
# Debug Lockups and Hangs
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HAVE_NMI=y
CONFIG_HAVE_PERF_EVENTS_NMI=y

CONFIG_BOOTPARAM_HARDLOCKUP_PANIC and CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC
is enabled using,
echo 1 > /proc/sys/kernel/softlockup_panic
echo 1 > /proc/sys/kernel/hardlockup_panic

In addition to this the below parameters were set,
echo 1 > /proc/sys/kernel/hung_task_panic
echo 1 > /proc/sys/kernel/panic
echo 1 > /proc/sys/kernel/panic_on_io_nmi
echo 1 > /proc/sys/kernel/panic_on_oops
echo 1 > /proc/sys/kernel/panic_on_unrecovered_nmi
echo 1 > /proc/sys/kernel/unknown_nmi_panic
echo 1 > /proc/sys/vm/panic_on_oom
echo 1 > /proc/sys/kernel/sysrq

Thanks.

Regards,
Vignesh
