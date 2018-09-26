Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mta02.hs-regensburg.de ([194.95.104.12]:58522 "EHLO
        mta02.hs-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeIZVUb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Sep 2018 17:20:31 -0400
Received: from E16S02.hs-regensburg.de (e16s02.hs-regensburg.de [IPv6:2001:638:a01:8013::92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "E16S02", Issuer "E16S02" (not verified))
        by mta02.hs-regensburg.de (Postfix) with ESMTPS id 42L1WG16PpzygG
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2018 17:07:06 +0200 (CEST)
From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Subject: Bug or works as intended: signal behaviour on -RT
Message-ID: <d5b58969-26d3-d32b-71f7-fdd437c06ee1@oth-regensburg.de>
Date: Wed, 26 Sep 2018 17:07:02 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------0D99F403CF0346CAF386EEF5"
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>

--------------0D99F403CF0346CAF386EEF5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

If I set the SCHED_FIFO schedular, register a SIGALRM handler, set an
alarm() and consume 100% of CPU time on an isolated CPU (IOW, never
leave running/runable), the signal will never arrive in userspace.
According to /proc/timer_list the expiration time will become a negative
value.

But if I synchronously send a SIGALRM via kill, it will immediately
arrive. Even a sched_yield() in the busy loop won't help. In order to
get the signal, I have to leave running/runable with usleep().

Now I'm not sure if this behaviour is intended for some reason or if
it's a bug. Please find a minimal example attached. Run it on an
isolated CPU with taskset.

Reproduceable with 4.14.x-rt and latest -rt. Not reproducable with
mainline Linux and PREEMPT.

Thanks
  Ralf

(How I found this: I'm currently using stress-ng as a stressor for some
cyclictest measurements. stress-ng fork()s stressors. Stressors can be
parameterised by a timeout, which is implemented as alarm(). The timeout
will never occur, as stressors never leave Running/Runable.)

--------------0D99F403CF0346CAF386EEF5
Content-Type: text/x-csrc; name="sigalrm.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sigalrm.c"

#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <stdbool.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sched.h>
#include <string.h>

static volatile bool stop;

static void alarm_handler(int sig)
{
	printf("Woof woof!\n");
	stop = true;
}

int main(void) {
	struct sched_param sp;
	int ret;

	memset(&sp, 0, sizeof(sp));
	sp.sched_priority = 12;
	ret = sched_setscheduler(0, SCHED_FIFO, &sp);
	if (ret != 0) {
		printf("Error setting scheduler\n");
		return -1;
	}

	if (signal(SIGALRM, alarm_handler) == SIG_ERR) {
		printf("\ncan't catch SIGINT\n");
		return -1;
	}

	alarm(5);
	while (!stop) {}

	return 0;
}

--------------0D99F403CF0346CAF386EEF5--
