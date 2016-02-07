From: "Simone Pietro Lossani, 3L" <s.lossani@3l-automazione.com>
Subject: Config file settings
Date: Sun,  7 Feb 2016 20:26:23 +0100
Message-ID: <O26ZBZ$D3BDAEDD4DE0D479BE670B7C583E3879@3l-automazione.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpweb153.aruba.it ([62.149.158.153]:37348 "EHLO
	smtpcmd05153.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196AbcBGT00 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Feb 2016 14:26:26 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I installed OpenSuse 13.2 on IPC277E
with the native kernel 13.16.6.

After that I downloaded kernel 3.18.25
and the relative RT PREEMPT PATCH.

I done the patch.

I copied from boot directory the file
config-3.16.6-2-desktop to usr/src/linux-3.18.25. I renamed it to .conf=
ig.

And then I started make menuconfig and
at this point I got some problems.

I didn=E2=80=99t find setting written In the howto:

The most default configurations here are ok as-they-are. However you
should make sure that you have

enable
CONFIG_PREEMPT_RT
=C2=A0
activated
the High-Resolution-Timer Option (Attention, the amount of supported pl=
atforms
by the HR timer is still very limited. Right now the option is only sup=
ported
on x86 systems, PowerPC and ARM Support are however in queue.)

disabled
all Power Management Options like ACPI or APM (not all ACPI functions a=
re
"bad", but you will have to check very carefully to find out which
function will affect your real time system. Thus it's better to simply =
disable
them all if you don't need them. APM, however, is a no-go.) NOTE: Since=
 rt
patch 2.6.18-rt6 you will probably have to activate ACPI option to acti=
vate
high resolution timer. Since the TSC timer on PC platforms, as used in =
the
previous versions, are now marked as unsuitable for hrt mode due to man=
y lacks
of functionalities and reliabilities, you will need i.E. pm_timer as pr=
ovided
by ACPI to use as clock source. To activate the pm_timer, you can just =
activate
the ACPI_SUPPORT in menuconfig and deactivate all other sub modules lik=
e
"fan", "processor" or "button". If you have an
old pc, which lacks ACPI support, you might have problems using the hig=
h
resolution timer.

Also in the website there is another
tips for patch configuration:

Kernel 3.x:

CONFIG_PREEMPT=3Dy

CONFIG_PREEMPT_RT_BASE=3Dy

CONFIG_PREEMPT_RT_FULL=3Dy

But I didn=E2=80=99t find also them.


Do you have a list of changing to do in
menuconfig for a kernel similar to 3.18.25?


Thanks!

Simone Pietro Lossani

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
