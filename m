From: Max Miller <mxmr@gmx.net>
Subject: Tweak Latency on Intel ATOM
Date: Tue, 9 Feb 2010 07:41:58 +0000 (UTC)
Message-ID: <loom.20100209T081421-234@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59819 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211Ab0BIHuH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Feb 2010 02:50:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1NekrF-0004r0-Pm
	for linux-rt-users@vger.kernel.org; Tue, 09 Feb 2010 08:50:05 +0100
Received: from host-62-245-142-18.customer.m-online.net ([62.245.142.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Feb 2010 08:50:05 +0100
Received: from mxmr by host-62-245-142-18.customer.m-online.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Feb 2010 08:50:05 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

im am using the PREEMPT-RT patch on linux 2.6.29.6. It runs on a MSI965=
GSE
industial board with Intel ATOM CPU (N270, 1,6GHz) and i945GSE Northbri=
dge.=20

I got about 45=C2=B5s as maximum and 13=C2=B5s as average latency when =
hyperthreading is
disabled. With enabled Hyperthreading the maximum latency increses to a=
bout
100=C2=B5s. I measured the latency with cyclictest.=20

What can i do to get better maximum latency? Can I do somthing in the k=
ernel
configuration or are there some kernel bootoptions? Or is it still impo=
ssible
with this CPU to get better results?

Thanks in advance,
Max Miller=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
