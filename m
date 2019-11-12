Return-Path: <SRS0=ZIbK=ZE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E01AC43331
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Nov 2019 19:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E73C21925
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Nov 2019 19:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLT0s (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:26:48 -0500
Received: from mail.softplc.com ([206.126.248.66]:11657 "EHLO mail.softplc.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfKLT0s (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Nov 2019 14:26:48 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Nov 2019 14:26:47 EST
Received: from [192.100.100.3] ([::ffff:107.174.231.239])
  (AUTH: PLAIN dick@softplc.com, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by mail.softplc.com with ESMTPSA; Tue, 12 Nov 2019 14:21:46 -0500
  id 00000000001E0006.000000005DCB064A.000005A1
To:     linux-rt-users@vger.kernel.org
From:   Dick Hollenbeck <dick@softplc.com>
Subject: Need help building for aarch64 kernel 5.2
Message-ID: <a0a64a18-5805-de3b-c4f7-537de8fa0508@softplc.com>
Date:   Tue, 12 Nov 2019 13:21:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Experts,

I really need some help please.

Here is the result of my first build attempt on a tree made from pristine
Linux 5.2.21

and the corresponding RT patch, which applied cleanly:



$ /i/runtime/arm64/kernel/build-arm64-rt.sh
make[1]: Entering directory '/ssd/build/linux-5.2.y'
  GEN     Makefile
scripts/kconfig/conf  --syncconfig Kconfig
  GEN     Makefile
  Using /ssd/linux-5.2.y as source for kernel
  CALL    /ssd/linux-5.2.y/scripts/atomic/check-atomics.sh
  CALL    /ssd/linux-5.2.y/scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  GZIP    kernel/config_data.gz
  CC      kernel/configs.o
  AR      kernel/built-in.a
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  LD      vmlinux.o
  MODPOST vmlinux.o
  MODINFO modules.builtin.modinfo
kernel/sched/core.o: In function `migrate_enable':
core.c:(.text+0x3750): undefined reference to `takedown_cpu_task'
core.c:(.text+0x3750): relocation truncated to fit: R_AARCH64_ADR_PREL_PG_HI21 against
undefined symbol `takedown_cpu_task'
core.c:(.text+0x3754): undefined reference to `takedown_cpu_task'
/ssd/linux-5.2.y/Makefile:1054: recipe for target 'vmlinux' failed
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory '/ssd/build/linux-5.2.y'
Makefile:179: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2


Am I right to think that this pointer, takedown_cpu_task, is more that some maximum
distance away from object file "core.o" in the link image for the build setup?


How are other globals avoiding this same problem, what't the best fix?


Thanks much,

Dick

