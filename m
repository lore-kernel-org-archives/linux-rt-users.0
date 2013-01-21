From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: Detecting shift of CLOCK_REALTIME with clock_nanosleep (again)
Date: Mon, 21 Jan 2013 20:12:28 +0100
Message-ID: <20130121191228.GE2342@netboy.at.omicron.at>
References: <OFB404C2D9.B6E5E0B9-ON86257AA8.0054900F-86257AA8.005761C4@ni.com>
 <alpine.LFD.2.02.1210311949400.2756@ionos>
 <OF0AC62D08.8289F39F-ON86257AB7.0067DE83-86257AB7.006AEF36@ni.com>
 <50A55664.2090605@us.ibm.com>
 <OF701783A6.DD321DA8-ON86257AD9.0065C5C7-86257AD9.0071DB52@ni.com>
 <50D22A41.2070503@linaro.org>
 <20130105040946.GA17645@netboy.at.omicron.at>
 <OF48F68A41.A33D8F99-ON86257AFA.0053184D-86257AFA.0055C08D@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Stultz <john.stultz@linaro.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Scot Salmon <scot.salmon@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:33609 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab3AUTMl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Jan 2013 14:12:41 -0500
Received: by mail-ea0-f169.google.com with SMTP id d13so2554174eaa.14
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jan 2013 11:12:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <OF48F68A41.A33D8F99-ON86257AFA.0053184D-86257AFA.0055C08D@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I still think that your problems can be solved at the application
level quite easily. Just out of curiosity, I wrote a little test
program, below, and I think it shows a promising direction to solve
your issue. (The 'clk_cmp' function was taken from the userland servo
in the phc2sys program, from the linuxptp project.)

I am not sure what your application wants to do if it should notice a
jump in CLOCK_REALTIME: keep the old phase angle or re-align to the
new UTC second. My test program does not shift its phase, but I think
you would know how to do it. 

Running on my dinky atom netbook (32 bit, no vdso, no RT) in an
unscientific test, I see the value of 'expected - offset' typically
around a few hundred nanoseconds, with occasional outliers of a few
microseconds. With RT-PREMPT these could surely be avoided, or by
using a moving average of say, 10 readings.

Also, rather than jumping to the new phase angle (if that is what you
want in fact to do), you could smoothly ajust the loop phase using a
PI controller or similar.

Anyhow, here it is. What do you think?

Thanks,
Richard

---
#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <inttypes.h>

#define NS_PER_SEC 1000000000LL

static int clk_cmp(clockid_t clkid, clockid_t sysclk, int readings,
		    int64_t *offset, uint64_t *ts)
{
	struct timespec tdst1, tdst2, tsrc;
	int i;
	int64_t interval, best_interval = INT64_MAX;

	/* Pick the quickest clkid reading. */
	for (i = 0; i < readings; i++) {
		if (clock_gettime(sysclk, &tdst1) ||
				clock_gettime(clkid, &tsrc) ||
				clock_gettime(sysclk, &tdst2)) {
			perror("clock_gettime");
			return -1;
		}

		interval = (tdst2.tv_sec - tdst1.tv_sec) * NS_PER_SEC +
			tdst2.tv_nsec - tdst1.tv_nsec;

		if (best_interval > interval) {
			best_interval = interval;
			*offset = (tdst1.tv_sec - tsrc.tv_sec) * NS_PER_SEC +
				tdst1.tv_nsec - tsrc.tv_nsec + interval / 2;
			*ts = tdst2.tv_sec * NS_PER_SEC + tdst2.tv_nsec;
		}
	}

	return 0;
}

int main(int argc, char *argv[])
{
	int64_t expected, offset;
	uint64_t systs;
	struct timespec next;
	struct timespec incr = {
		0, 250000000
	};
	clockid_t clk = CLOCK_MONOTONIC;
	int n_readings = 1;

	/*
	 * Calibrate the offset.
	 */
	if (clk_cmp(clk, CLOCK_REALTIME, 25, &expected, &systs)) {
		return -1;
	}
	if (clock_gettime(clk, &next)) {
		perror("clock_gettime");
		return -1;
	}

	next.tv_sec++;

	while (1) {
		if (clock_nanosleep(clk, TIMER_ABSTIME, &next, NULL)) {
			perror("clock_nanosleep");
			break;
		}
		if (clk_cmp(clk, CLOCK_REALTIME, n_readings, &offset, &systs)) {
			break;
		}
		printf("%" PRId64 "\n", expected - offset);
		/*
		 * At this point, if the difference is more than, say,
		 * 10 microseconds, then you could simply recalibrate
		 * the offset and set the next deadline.
		 */
		next.tv_sec  += incr.tv_sec;
		next.tv_nsec += incr.tv_nsec;
		while (next.tv_nsec >= NS_PER_SEC) {
			next.tv_nsec -= NS_PER_SEC;
			next.tv_sec++;
		}
	}

	return 0;
}


