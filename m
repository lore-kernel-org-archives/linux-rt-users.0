From: Suresh Kumar SHUKLA <suresh.shukla@st.com>
Subject: How to change the ISR kthread priority in 2.6.26 series
Date: Wed, 27 May 2009 13:09:18 +0530
Message-ID: <000401c9de9e$43037970$a852c70a@dlh.st.com>
References: <971214.98609.qm@web59809.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:43474 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754547AbZE0IDo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 May 2009 04:03:44 -0400
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0D882DAEA
	for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2009 07:38:08 +0000 (GMT)
Received: from mail2.dlh.st.com (mail2.dlh.st.com [10.199.8.22])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7366D4BF4A
	for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2009 07:38:07 +0000 (GMT)
In-Reply-To: <971214.98609.qm@web59809.mail.ac4.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In driver init function after registering IRQ, I want to raise the thread
priority to default + 1, but am unable to find the suitable API's.

I am using 2.6.26 series with rt-patch.

regards,
Suresh

