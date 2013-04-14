From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: Realtime capable userspace?
Date: Sun, 14 Apr 2013 12:08:53 +0200
Message-ID: <516A8035.9040604@xenomai.org>
References: <516A7083.8080705@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xenomai.org ([88.191.142.154]:39224 "EHLO xenomai.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878Ab3DNKVg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 14 Apr 2013 06:21:36 -0400
In-Reply-To: <516A7083.8080705@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/14/2013 11:01 AM, Stanislav Meduna wrote:

> Hi,
> 
> I know this is not a kernel-related question, but I think the amount of
> people doing realtime here is probably the largest.
> 
> As learned the hard-way the glibc is not (yet) realtime capable and
> first changes are now starting to trickle in. Even if I try to fix known
> places, who knows what, where and for how long is locked.
> 
> What userspace (libc / threads / malloc) are you using for realtime
> applications? From my quick research:


PI mutexes are not sufficient to make malloc deterministic. I guess if
you are looking for a deterministic malloc, you should have a look at TLSF.

You can probably get the replacement malloc be used by glibc by using
LD_PRELOAD techniques (but OK, it would be just a hack).

-- 
                                                                Gilles.
