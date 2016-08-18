From: Bernhard Landauer <oberon@manjaro.org>
Subject: nvidia 370.23 not compiling against rt-patched kernel
Date: Thu, 18 Aug 2016 20:57:34 +0200
Message-ID: <4b0c04a5-82c8-dc36-8503-c2f7defafb12@manjaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.manjaro.org ([176.9.38.148]:59484 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753669AbcHSCp7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Aug 2016 22:45:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 1AE8330E0893
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Aug 2016 20:57:39 +0200 (CEST)
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LnRAZ6ZCcPU3 for <linux-rt-users@vger.kernel.org>;
        Thu, 18 Aug 2016 20:57:37 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Latest nvidia 370.23 driver is unhappy with 'rt_mutex_destroy' and the 
extramodule fails to build with

FATAL: modpost: GPL-incompatible module nvidia-drm.ko uses GPL-only 
symbol 'rt_mutex_destroy'

This concerns 4.6.5_rt10 aswell as 4.4.17_rt25 at least
What can we do about that?

kind regards
Bernhard Landauer

