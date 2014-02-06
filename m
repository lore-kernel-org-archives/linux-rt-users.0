From: jordan <triplesquarednine@gmail.com>
Subject: Linux-rt fails to boot [any release past 3.12.5-rt7] on all of my machines
Date: Wed, 5 Feb 2014 20:54:59 -0500
Message-ID: <CAOcfFMw2P9QwQrzUYL4rpvrJ2_d7L8Q3fi3-U=dgB=krjd2QoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:40857 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbaBFBzA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Feb 2014 20:55:00 -0500
Received: by mail-vc0-f173.google.com with SMTP id ld13so949987vcb.4
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Feb 2014 17:54:59 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey list,

I've been meaning to post, but alas, I am working three jobs right now
(just took on more work) and haven't had a whole lot of free time to
investigate my boot problems on linux-rt (-rt9, -rt10, -rt11, -rt13).

On 3.12.8-rt11 - i was able to get the kernel to boot via reverting two
patches, from the split queue;

'timer-Raise-softirq-if-there-s-irq_work.patch'
'timers-do-not-raise-softirq-unconditionally.patch'

(i haven't tried reverting on -rt13, as i haven't had the time to do that).

however, while this was enough to boot - my system was unstable. thus i
downgraded my kernel back to trusty 3.12.5-rt7 - which works flawlessly for
me. Next, I saw the -rt13 release, thinking maybe the boot issue was
finally solved [according to the change log], but no - it fails just as
before... I tried to add debug to grub's commandline but in the end, it
wasn't really helpful. [the last thing shown is something about PnP and
then ACPI];

[    0.255329] pnp: PnP ACPI: found 10 devices
[    0.255330] ACPI: bus type PNP unregistered

(which i would normally see anyway.)

I might have some time over the weekend (hopefully), to take a closer look
- but i  thought i would at least notify the list ~ as i saw another user
have the same booting problems and he has the same CPU as i do; AMD
Phenom 965 X4 [not exactly exotic H/W and every RT release has worked
great on my setup, until 3.12.x-rt8. Now, nothing works properly.
[note: vanilla 3.12.x kernels boot just fine].

anyway, if anyone has some suggestions - that i could follow up on over the
weekend that would be fantastic.

cheers

Jordan
