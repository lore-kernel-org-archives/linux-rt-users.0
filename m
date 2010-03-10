From: Daniele Nicolodi <daniele@grinta.net>
Subject: Re: patch-2.6.33-rt4 does not apply to linux-2.6.33 vanilla sources
Date: Wed, 10 Mar 2010 14:18:14 +0100
Message-ID: <4B979C16.9000501@grinta.net>
References: <4B97887F.7030303@grinta.net> <520f0cf11003100513t6792801kc7d078e780422381@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: RT-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.unitn.it ([193.205.206.70]:41249 "EHLO mail3.unitn.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755468Ab0CJNSS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Mar 2010 08:18:18 -0500
In-Reply-To: <520f0cf11003100513t6792801kc7d078e780422381@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

John Kacur wrote:
> On Wed, Mar 10, 2010 at 12:54 PM, Daniele Nicolodi <daniele@grinta.net> wrote:
>> Hello. I just downloaded linux-2.6.33.tar.bz2 and patch-2.6.33-rt4 from
>> kernel.org. However, the patch does not apply to the downloaded sources.
>>
>> I am missing something, or there may be a problem?
>>
> 
> It should work. Do something like the following.
> 
> tar xjf linux-2.6.33.tar.bz2
> cd linux-2.6.33
> bunzip2 -c ../patch-2.6.33-rt4.bz2 | patch -p1

Sorry for the noise. Probably my university proxy corrupted the bz2
download. Always check the signature before reporting such problems.

Thanks. Cheers,
-- 
Daniele
