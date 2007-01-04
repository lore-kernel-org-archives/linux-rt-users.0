From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: cyclictest hangs with posix interval timers !?
Date: Thu, 04 Jan 2007 12:43:11 +0100
Message-ID: <459CE84F.8000009@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:4703 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964807AbXADMDl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Jan 2007 07:03:41 -0500
To: linux-rt-users@vger.kernel.org
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

These are my very first steps into CONFIG_PREEMPT_RT.

I built a kernel 2.6.20-rc3-rt0, booted it on a x86 based single board
computer and tried to run cyclictest.

"cyclictest -t 1 -p 80 -i 10000 -l 10000 -n" runs fine.

But "cyclictest -t 1 -p 80 -i 10000 -l 10000" hangs.

Putting in some printfs I got the impression that the timerthread() blocks
at sigwait()

		case MODE_SYS_ITIMER:
			if (sigwait(&sigset, &sigs) < 0) {
				goto out;
			}
			break;

So I I booted the OSADL Live CD provided at

	http://www.osadl.org/projects-live-cd.0.html

on the same board and cyclictest runs fine in both modes.

I build a kernel 2.6.17 + 2.6.17-rt3 patch with the same kernel config used
on this CD. But cyclictest hangs when using interval timer.

So I recon it has something to do with the rootfs I am using (created with
PTXdist).

Will I need a special version of glibc or libpthread? NTPL?
I am using a cross tool chain gcc-3.4.4-glibc-2.3.5 for i686 built with
"crosstool".

Any ideas what I could be missing? Or how I could find out.

Thanks a million!

--
Steven
