From: Meha Mehta <mehtameha@gmail.com>
Subject: CONFIG_4KSTACK with rt patch
Date: Tue, 11 Aug 2009 14:01:04 -0400
Message-ID: <af81d2bf0908111101h3d72e3f2o48e2e411c02306b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:24443 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbZHKSBD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Aug 2009 14:01:03 -0400
Received: by an-out-0708.google.com with SMTP id d40so4210793and.1
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Aug 2009 11:01:04 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have a question regarding CONFIG_4KSTACK. From the code it looks
like with rt patch and CONFIG_PREEMPT_SOFTIRQ enabled, codepath still
uses interrupt stack rather than softirq thread's own stack. Is it
correct?
Should CONFIG_4KSTACK enabled with CONFIG_PREMPT_SOFTIRQ also enabled?

Thanks,
Meha
