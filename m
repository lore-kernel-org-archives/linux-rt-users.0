From: Esben Haabendal <eha@dev.doredevelopment.dk>
Subject: Not getting MCP with RT_PREEMPT on MPC8313
Date: Wed, 11 Aug 2010 15:10:09 +0200
Message-ID: <1281532209.3461.10.camel@eha.doredevelopment.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 07723322604.hef.nianet.dk ([77.233.226.4]:55188 "EHLO
	public.doredevelopment.dk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752056Ab0HKNTW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Aug 2010 09:19:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by public.doredevelopment.dk (Postfix) with ESMTP id 68D78ADE
	for <linux-rt-users@vger.kernel.org>; Wed, 11 Aug 2010 15:10:13 +0200 (CEST)
Received: from public.doredevelopment.dk ([127.0.0.1])
	by localhost (public.doredevelopment.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PnykAtMPYX3K for <linux-rt-users@vger.kernel.org>;
	Wed, 11 Aug 2010 15:10:10 +0200 (CEST)
Received: from [192.168.18.32] (eha.doredevelopment.dk [192.168.18.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by public.doredevelopment.dk (Postfix) with ESMTPS id A46F0573
	for <linux-rt-users@vger.kernel.org>; Wed, 11 Aug 2010 15:10:10 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I am using 2.6.33.7-rt29 with RT_PREEMPT for

I have a custom MPC8313 board with a signal on the IRQ0/MCP_IN pin.

With 2.6.33.7-rt29 configured with RT_PREEMPT I don't get a
machine_check_exception when the IRQ0 pin goes low.
Configuring the same kernel with PREEMPT instead, I get the
machine_check_exception.
Using 2.6.33 configured with PREEMPT also works.

Any known issues?  I have been digging a bit around, and is open to
suggestions on where to go next.

/Esben

