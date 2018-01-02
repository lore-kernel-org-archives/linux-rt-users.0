From: Daniel Wagner <daniel.wagner@siemens.com>
Subject: [ANNOUNCE] Linux 4.4.15-cip15-rt10
Date: Tue, 2 Jan 2018 12:56:11 +0100
Message-ID: <b4cf2728-0d0c-5128-d007-818e66da5613@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gecko.sbs.de ([194.138.37.40]:42605 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751580AbeABMK2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Jan 2018 07:10:28 -0500
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello CIP RT Folks!
	
I'm pleased to announce the Linux 4.4.15-cip15-rt10 stable release.
	
You can get this release via the git tree at:
	
  git://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux-cip-rt.git
  https://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux-cip-rt.git
	
  branch: linux-4.4.y-cip-rt
  Head SHA1: 6c97018d1d4626e21b5233eb28e607e412c79ebe

Currently, I don't have uploaded the patches, because I need to figure
out how this works on kernel.org.
	
The release is based on the Linux 4.4.75-rt88 version. That is I
applied the -rt88 patch on the 4.4.75-cip6 kernel and merged in all
CIP releases.

Note we got via the stable tree the new RT pull/push logic
from upstream cb1831a83e54 ("sched/rt: Simplify the IPI based RT
balancing logic").

I spend quite a while to get a baseline configuration working and 
the testing up and running.  I have a BeagleBone Black and a MinnowBoard
Turbot as test target. On the BBB, cyclictest reports reasonable
numbers, though not the MinnowBoard Turbot. It seems the bios/uefi
or so is eating CPU time. The exact same kernel works on different
x86 hardware just fine. 

Furthermore, I let the kernel run on the Real-Time Linux Continuous
Integration servers:

  https://ci-rt.linutronix.de/RT-Test/kbuild.jsp?id=112

Some of the builds are failing (allmodconfig), though it
doesn't look cip-rt specific, eg:

    kernel/utilities/compiletest-runner@2/build/../include/linux/compiler.h:484 call to ‘__compiletime_assert_150’ declared with attribute error: BUILD_BUG_ON failed: hw_flag_names[NUM_IEEE80211_HW_FLAGS] != (void *)0x1

Not sure how to handle those. IIRC, we don't support allmodconfig.

Next steps are improving my tests and identifying which 4.4.${x}-rt${y}
changes should be added to the cip-rt kernel.

Thanks,
Daniel
