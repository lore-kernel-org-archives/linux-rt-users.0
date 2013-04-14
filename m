From: Stanislav Meduna <stano@meduna.org>
Subject: Re: Realtime capable userspace?
Date: Sun, 14 Apr 2013 13:46:46 +0200
Message-ID: <516A9726.9040801@meduna.org>
References: <516A7083.8080705@meduna.org> <516A8035.9040604@xenomai.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:44953 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237Ab3DNLqz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 14 Apr 2013 07:46:55 -0400
In-Reply-To: <516A8035.9040604@xenomai.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 14.04.2013 12:08, Gilles Chanteperdrix wrote:

> PI mutexes are not sufficient to make malloc deterministic. I guess if
> you are looking for a deterministic malloc, you should have a look at TLSF.

Yup, I know that malloc from glibc is a complicated beast and should
be probably not used at all during hard realtime operation.

Right now my biggest problem is the possibility of priority inversion.
My time constraints are in the 20 - 50 ms range and I hope the malloc
itself - while not deterministic - is not unbounded / won't go to that
times. I am of course using mlockall and everything. OTOH a priority
inversion case is a sure recipe for missing the deadlines.

Thank you for the pointer to the TLSF, this is very interesting project
and I will surely investigate this.

> You can probably get the replacement malloc be used by glibc by using
> LD_PRELOAD techniques (but OK, it would be just a hack).

Yes, this is possible but is indeed quite a hack.

Thanks
-- 
                                      Stano

