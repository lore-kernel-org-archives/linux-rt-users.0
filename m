From: Simon Thelen <urday@student.kit.edu>
Subject: Low USB polling frequency with RT-PREEMPT
Date: Tue, 5 Sep 2017 17:05:39 +0200
Message-ID: <20170905150539.GF2607@anonymous>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from scc-mailout-kit-02.scc.kit.edu ([129.13.231.82]:50874 "EHLO
        scc-mailout-kit-02.scc.kit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751386AbdIEPYZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Sep 2017 11:24:25 -0400
Received: from kit-msx-25.kit.edu ([2a00:1398:9:f612::25])
        by scc-mailout-kit-02.scc.kit.edu with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA384:256)
        (envelope-from <urday@student.kit.edu>)
        id 1dpFQ4-0001We-7c
        for linux-rt-users@vger.kernel.org; Tue, 05 Sep 2017 17:05:41 +0200
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

We have some Dynamixel robitic actuators hooked up via USB to an Ubuntu
14.04 system running the 4.4.79-rt92 kernel. When using a kernel built
without the realtime patches (CONFIG_PREEMPT not set) we can query the
bus at 1000Hz (2 devices at 500Hz each) whereas with the realtime kernel
(CONFIG_PREEMPT=y, CONFIG_PREEMPT_RT_FULL=y) we only get 62.5Hz per
device. The USB device requests Ivl=0ms in both cases and the issue
isn't related to load etc. The polling rate is always 62.5Hz (It takes
~15ms for every read()).


Is this a known limitation of USB with the CONFIG_PREEMPT_RT patches and
is there any method to improve the polling rate?

-- 
Simon Thelen
