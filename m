From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 0/9] v4.4-rt2: fix compilation warnings and errors
Date: Fri, 15 Jan 2016 20:21:04 +0100
Message-ID: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Cc: linux-rt-users@vger.kernel.org, khilman@kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
To: bigeasy@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34372 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbcAOT06 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 14:26:58 -0500
Received: by mail-lf0-f42.google.com with SMTP id 17so86666408lfz.1
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jan 2016 11:26:57 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

This patchset fixes some build warnings and errors that were introduced by
v4.4-rt2. To build these patches they should be applied on top of patch [1], [2]
and [3].

Cheers,
Anders
[1] https://lkml.org/lkml/2015/12/28/221
[2] https://lkml.org/lkml/2015/12/28/222
[3] http://www.spinics.net/lists/kernel/msg2162906.html

Anders Roxell (9):
  drivers/clocksource: timer-atmel-pit: fix irq name
  drivers/clocksource: timer-atmel-pit: fix forward declaration
  drivers/clocksource: timer-atmel-pit: fix unused var 'ret'
  drivers/clocksource: timer-atmel-st: undeclared var 'ret'
  drivers/clocksource: timer-atmel-st: fix unused var 'ret'
  drivers/clocksource: timer-atmel-st: undeclared var 'irq'
  kernel/time: hrtimer: fix forward declaration
  drivers/cpuidle: coupled: fix warning cpuidle_coupled_lock
  driver/gpio: gpio-omap: fix incompatible pointer type

 drivers/clocksource/timer-atmel-pit.c | 4 ++--
 drivers/clocksource/timer-atmel-st.c  | 4 ++--
 drivers/cpuidle/coupled.c             | 1 -
 drivers/gpio/gpio-omap.c              | 2 +-
 kernel/time/hrtimer.c                 | 4 ++--
 5 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.1.4

