From: Stanislav Meduna <stano@meduna.org>
Subject: Re: malloc/free and priority inheritance?
Date: Thu, 04 Apr 2013 15:30:52 +0200
Message-ID: <515D808C.8090808@meduna.org>
References: <515B647C.3080505@meduna.org> <515D7943.5000401@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: libc-help@sourceware.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:34472 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760119Ab3DDNbA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Apr 2013 09:31:00 -0400
In-Reply-To: <515D7943.5000401@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04.04.2013 14:59, Stanislav Meduna wrote:

> OK, after code-review it looks that it does not and neither
> do the condition variables and semaphores. This is bad...

hm well.. the assembler version of e.g. __pthread_cond_broadcast
in 2.17 for x86 seems to be using the PI. No luck with ARM (2.16
in ports) though.

Regards
-- 
                                        Stano

