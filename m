From: pavel <pavel@pavlinux.ru>
Subject: 1us latency?
Date: Mon, 3 Aug 2015 14:13:27 +0300
Message-ID: <55BF4CD7.8000007@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward16j.cmail.yandex.net ([5.255.227.235]:54689 "EHLO
	forward16j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752829AbbHCLVN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Aug 2015 07:21:13 -0400
Received: from smtp12.mail.yandex.net (smtp12.mail.yandex.net [95.108.131.191])
	by forward16j.cmail.yandex.net (Yandex) with ESMTP id 95230220C3
	for <linux-rt-users@vger.kernel.org>; Mon,  3 Aug 2015 14:13:29 +0300 (MSK)
Received: from smtp12.mail.yandex.net (localhost [127.0.0.1])
	by smtp12.mail.yandex.net (Yandex) with ESMTP id 6D1A216A0818
	for <linux-rt-users@vger.kernel.org>; Mon,  3 Aug 2015 14:13:29 +0300 (MSK)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

# ./cyclictest -S -p fifo
defaulting realtime priority to 9
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.00 0.03 0.05 1/218 4240

T: 0 ( 4174) P: 9 I:1000 C: 430806 Min:      1 Act:    1 Avg:    1 Max:      10
T: 1 ( 4175) P: 9 I:1500 C: 287204 Min:      1 Act:    1 Avg:    1 Max:       6
T: 2 ( 4176) P: 9 I:2000 C: 215403 Min:      1 Act:    2 Avg:    1 Max:      11
T: 3 ( 4177) P: 9 I:2500 C: 172322 Min:      1 Act:    1 Avg:    1 Max:       9
T: 4 ( 4178) P: 9 I:3000 C: 143602 Min:      1 Act:    1 Avg:    1 Max:      10
T: 5 ( 4179) P: 9 I:3500 C: 123087 Min:      1 Act:    1 Avg:    1 Max:      11
T: 6 ( 4180) P: 9 I:4000 C: 107701 Min:      1 Act:    1 Avg:    1 Max:      10
T: 7 ( 4181) P: 9 I:4500 C: 108232 Min:      1 Act:    2 Avg:    1 Max:      11


It possible? 1us latency?  o_O

kernel- 3.18.19-rt15
cyclictest V 0.92
Intel(R) Xeon(R) CPU E3-1246 v3 @ 3.50GHz
MSI MS-7823/B85M-G43 (MS-7823), BIOS V3.14B3 06/23/2014
