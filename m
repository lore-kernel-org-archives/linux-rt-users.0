From: Wolfgang Grandegger <wg@grandegger.com>
Subject: High latencies with linux-2.6.25.4-rt6 on MPC5200
Date: Wed, 18 Jun 2008 10:07:05 +0200
Message-ID: <4858C229.2060509@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:40266 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbYFRIHD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Jun 2008 04:07:03 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 21745439693
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Jun 2008 10:07:04 +0200 (CEST)
Received: from lancy.denx.de (p5497CFFA.dip.t-dialin.net [84.151.207.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 79CAA90171
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Jun 2008 10:07:02 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I currently re-doing latency measurement with my TQM5200 board under 
Linux 2.6.25. With 2.6.24-rt1 "cyclictest -n -p80 -i1000 -t1" reported a 
maximum latency of 170us. With 2.6.25.4-rt5 I'm unable to reproduce such 
reasonable latencies. cyclictest shows quickly latencies up to 600 us. 
What has changed in the meantime? Any ideas how to get better latencies?

Wolfgang.
