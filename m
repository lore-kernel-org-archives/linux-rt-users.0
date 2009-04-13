From: Suresh Kumar SHUKLA <suresh.shukla@st.com>
Subject: Measuring timer interrupt latency
Date: Mon, 13 Apr 2009 12:14:42 +0530
Message-ID: <002901c9bc03$54aa23d0$3f52c70a@dlh.st.com>
References: <alpine.LFD.2.00.0904110003370.21577@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: "'rt-users'" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:55699 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754783AbZDMHHp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Apr 2009 03:07:45 -0400
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 96CC7DA63
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Apr 2009 06:43:36 +0000 (GMT)
Received: from mail2.dlh.st.com (mail2.dlh.st.com [10.199.8.22])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ED0BA4C01A
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Apr 2009 06:44:45 +0000 (GMT)
In-Reply-To: <alpine.LFD.2.00.0904110003370.21577@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I want to profile the improvements in interrupt latency with and without RT
patches.

The approach I have in mind is that time gap between IRQ firing and IRQ
handler reading value of counter would be sufficient to reveal the interrupt
latency. These values can be analysed for min/max/avg.

Is there any test program which captures interrupt latency (for x86) ? 
I checked realfeel but it is user mode program and am not sure of its
accuracy.

regards,
Suresh

