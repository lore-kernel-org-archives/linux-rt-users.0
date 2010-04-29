From: Xianghua Xiao <xiaoxianghua@gmail.com>
Subject: loadavgrt
Date: Thu, 29 Apr 2010 16:37:04 -0500
Message-ID: <q2me6bf505b1004291437uc5078c0as7e61a06cb8ee8cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39064 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887Ab0D3Tuf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Apr 2010 15:50:35 -0400
Received: by gwj19 with SMTP id 19so276680gwj.19
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Apr 2010 12:50:33 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm using kernel 2.6.33-rt15, in the old days there is /proc/loadavgrt
to show rt loads, which is missing in new kernels. are newer kernels
already including RT load to /proc/loadavg? I looked at kernel/sched.c
and found out nothing was done to RT as far as load calculation is
concerned.

xianghua
