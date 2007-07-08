From: jayabrata_c@dataone.in
Subject: Interrupt latency benchmark
Date: Mon, 09 Jul 2007 02:40:16 +1000
Message-ID: <f5f0cd74458f.4691a010@dataone.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bglbbmr1-a-fixed.dataone.in ([218.248.240.59]:43156 "EHLO
	bglbbmr1.dataone.in" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753262AbXGHQkr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 8 Jul 2007 12:40:47 -0400
Received: from dataone.in ([10.16.18.23])
 by bglbbmr1.dataone.in (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTP id <0JKV00JHPCRKI700@bglbbmr1.dataone.in> for
 linux-rt-users@vger.kernel.org; Sun, 08 Jul 2007 22:05:44 +0530 (IST)
Content-language: en
Content-disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello All,

I have a query, Can i use Realfeel benchmark tool,
to test the interrupt latency on an smp machine. I have a non-smp machine,
on which i tested the 2.6.19-rt11 kernel, and i got very impressive
interrupt latency (< 30 us, with tests carried over 10 hours, on heavy load).
But i am not getting the same performance on an smp machine, which i
recently acquired. I used the latest 2.6.21.5-rt19 kernel.
But still the same results. Am i doing something wrong, or is Realfeel not
meant for smp? In that case, which tool can i use? I have used the Realfeel
tool from the amlat package.

Regards
Jayabrata
