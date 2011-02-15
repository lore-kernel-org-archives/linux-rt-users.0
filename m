From: "Fernando Gomes" <fernando.gomes@efacec.com>
Subject: RT availability for the 2.6.37 kernel
Date: Tue, 15 Feb 2011 13:11:44 -0000
Message-ID: <BA0FD0EA8282D74CAE2088A5DCB4474B0F7B6EBB@S005.maia.efacec.pt>
References: <BA0FD0EA8282D74CAE2088A5DCB4474B0F7B6EBA@S005.maia.efacec.pt>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail2.efacec.com ([62.28.144.243]:8512 "HELO mail2.efacec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751089Ab1BONLt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Feb 2011 08:11:49 -0500
Content-class: urn:content-classes:message
In-Reply-To: <BA0FD0EA8282D74CAE2088A5DCB4474B0F7B6EBA@S005.maia.efacec.pt>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all

>From the last 2.6.33 RT release I saw that the next RT release will be
for the 2.6.37 kernel, is there any expected date for this release? I
will need to use the 2.6.37 kernel for a development we are working on
but we also need to have the RT features, in order to have a smaller
latency for high priority user threads. This is almost 'on spec' for the
2.6.33 with PREEMPT_RT, but it is far out on the 2.6.33 with PREEMPT
only (latency with a loaded CPU get much larger with the 2.6.37 kernel
with load), but unfortunately we need to use the 2.6.37 kernel due to
the driver availability for some devices. If the 2.6.37 PREEMPT_RT will
still take a long time to be released, we might have to choose the road
of backporting the drivers to the 2.6.33 kernel, but for sure we prefer
to release the product with the newer kernel.

Best regards

Fernando

