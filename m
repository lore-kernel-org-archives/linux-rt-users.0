From: Stanislav Meduna <stano@meduna.org>
Subject: Re: How to find long execution times in kernel threads?
Date: Tue, 30 Apr 2013 20:02:23 +0200
Message-ID: <5180072F.7010102@meduna.org>
References: <517FCBA3.1000909@meduna.org> <517FF6B1.9050204@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:52937 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760203Ab3D3SCd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Apr 2013 14:02:33 -0400
In-Reply-To: <517FF6B1.9050204@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 30.04.2013 18:52, Carsten Emde wrote:

> Sure, record everything (trace-cmd record -e all) and analyze the
> traces.

Well, the problem is that with record -e all I get 20 ms instead
of 1 ms, so I'd say Mr. Heisenberg laughs at me loudly here ;)

Thanks for the pointer anyway, I'll try to thoroughly read
the available documentation and come up with some sane set
of filters to start with.

Thanks
-- 
                                      Stano

