From: Arpit Goel <arpitgoel@gmail.com>
Subject: iMX6 compilation fails with RT patch
Date: Wed, 3 Apr 2013 11:36:10 +0530
Message-ID: <CANRA68LNCUUJGoYtntem-D8R3abcM-RmFRHjz+e002DtXVM4qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:44166 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab3DCGGL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Apr 2013 02:06:11 -0400
Received: by mail-oa0-f41.google.com with SMTP id f4so1163510oah.0
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Apr 2013 23:06:10 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am using 3.8.4 kernel with RT patch(patch-3.8.4-rt2.patch).
Patch was applied using "git apply" on kernel with Tag 3.8.4.

Compilation for ARM architecture fails for iMX6 using
imx_v6_v7_defconfig fails after following configuration flags are
enabled.

CONFIG_PREEMPT_RT_BASE
CONFIG_PREEMPT_RT_FULL

Compilation Error:

arch/arm/mach-imx/clk.c:3:1: error: expected '=', ',', ';', 'asm' or
'__attribute__' before '__cacheline_aligned_in_smp'

Toolchain -> Linaro ARM FSL toolchain (arm-fsl-linux-gnueabi-)

Regards
Arpit Goel
