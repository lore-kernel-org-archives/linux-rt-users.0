From: "Daniel Schnell" <daniel.schnell@marel.com>
Subject: Lttng for 2.6.24-rt1 ?
Date: Thu, 14 Feb 2008 12:35:12 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB02B4492D@is-hdq-exchange.marel.net>
References: <47B411A6.9030007@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.marel.is ([213.167.134.96]:29374 "EHLO mail.marel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757283AbYBNMtQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Feb 2008 07:49:16 -0500
Content-class: urn:content-classes:message
In-Reply-To: <47B411A6.9030007@cn.fujitsu.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Just wanted to know if anybody uses LTTNG on the 2.6.24 rt kernel ? I am
trying to trace down some performance problems on my mpc5200b based
embedded box and LttNG would probably help quite a bit in analyzing
which tasks besides our own burn how much CPU and how the exact
scheduling order between ISR and application is.


Best regards,

Daniel Schnell.
