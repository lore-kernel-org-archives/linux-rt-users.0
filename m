From: Hartmut Behrens <hartmut.behrens@gmail.com>
Subject: Improving ARM7 platform performance with CONFIG_PREEMPT_RT
Date: Wed, 12 Sep 2012 12:20:50 +0200
Message-ID: <CA+69FtBGGHQykr8DiOizeR0pWA+5ifeN1LtzZ2n2LmeA6+TWRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40168 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab2ILKUv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Sep 2012 06:20:51 -0400
Received: by obbuo13 with SMTP id uo13so2346239obb.19
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Sep 2012 03:20:50 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have patched a 3.2 kernel for a OMAP compatible processor (ARM
Cortex A8) to be used on an Gumstix Overo with the CONFIG_PREEMPT_RT
patch.

I have noticed that the latency of the patched kernel on this platform
is <300usec (using cyclictest), similar to what is reported for the
ARM9 platforms at
https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch

Is this the best performance that can be expected from ARM7/9 platforms?

Could it be improved by using different kernel config settings - e.g.
CONFIG_LATENCY_TRACE=n  -
https://rt.wiki.kernel.org/index.php/Cyclictest mentions that latency
tracing adds significant kernel overhead?
