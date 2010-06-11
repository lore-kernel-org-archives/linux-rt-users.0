From: Esben Haabendal <eha@dev.doredevelopment.dk>
Subject: Stable gianfar driver for 2.6.33/RT_PREEMPT
Date: Fri, 11 Jun 2010 10:51:05 +0200
Message-ID: <1276246265.2854.8.camel@eha.doredevelopment.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 07723322604.hef.nianet.dk ([77.233.226.4]:54869 "EHLO
	public.doredevelopment.dk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754328Ab0FKJBF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Jun 2010 05:01:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by public.doredevelopment.dk (Postfix) with ESMTP id 0F74C619
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Jun 2010 10:51:09 +0200 (CEST)
Received: from public.doredevelopment.dk ([127.0.0.1])
	by localhost (public.doredevelopment.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VVFGqXxl87o2 for <linux-rt-users@vger.kernel.org>;
	Fri, 11 Jun 2010 10:51:06 +0200 (CEST)
Received: from [192.168.18.32] (eha.doredevelopment.dk [192.168.18.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by public.doredevelopment.dk (Postfix) with ESMTPS id 64270368
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Jun 2010 10:51:06 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I had problems with an mpc8313 board using 2.6.33 RT_PREEMPT.
The gianfar simply stalled.

I found a patch from Anton Vorontsov [1], which solves exactly the same
problems for SMP, and it fixes it for RT_PREEMPT also.

So if anyone has trouble with gianfar with RT_PREEMPT, you should
definitely give it a try.

It has been accepted by David Miller, so it should end up in Linus tree
at some point, but I would suggest applying it to the 2.6.33 RT_PREEMPT
tree also.

[1] http://kerneltrap.org/mailarchive/linux-netdev/2010/3/3/6271188

Best regards,
Esben Haabendal

