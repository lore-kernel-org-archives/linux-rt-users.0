From: rolf.freitag@email.de
Subject: Why is real time pinging not possible with RT kernels?
Date: Sat, 10 Jun 2017 20:13:11 +0200
Message-ID: <trinity-c4969a6b-8eeb-4799-93a4-349c300c9363-1497118391298@3capp-webde-bap09>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:50771 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbdFJSNN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 10 Jun 2017 14:13:13 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I tried ping as a minimal latency test, e. g.

ionice -c3 -p $$
renice +19 -p $$
ping -q -s 28 -l 1 -p 0f1e2d3c4b5a6978 -i 0.001 localhost

but when cyclictest shows a worst-case latency of 40 mikroseconds,
ping shows more than 10,000 (after 1 day run).
I tried different kernels, e. g.
SMP PREEMPT RT Debian 4.6.4-1~bpo8+1 (2016-08-11) x86_64
but with the same result, low cyclictest values, high ping values.
What is the reason?

Regards,

Rolf
