From: Suresh Kumar SHUKLA <suresh.shukla@st.com>
Subject: RE: Setting the priority of an IRQ thread
Date: Thu, 18 Jun 2009 16:35:02 +0530
Message-ID: <001201c9f004$a1103860$a852c70a@dlh.st.com>
References: <3efb10970906171314s2b60a2eerc3cbad09a6f8e4a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:42281 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757449AbZFRLFH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Jun 2009 07:05:07 -0400
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 716D914F
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jun 2009 11:05:05 +0000 (GMT)
Received: from mail2.dlh.st.com (mail2.dlh.st.com [10.199.8.22])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B10DF4C2A2
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jun 2009 11:05:04 +0000 (GMT)
In-Reply-To: <3efb10970906171314s2b60a2eerc3cbad09a6f8e4a6@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> > It _is_ solely a user space issue. The kernel has 

I don't agree. Isn't this a policy of its own.

Mechanism for changing priority should be available within driver code too.
My desired functionality fits perfectly fine as driver/LKM, why force me to
create a user mode application.

