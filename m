Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9FA170A26;
	Sat, 11 Jan 2025 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622256; cv=none; b=uF1DXicORBQ9j1cySwvchLTr0OLmZXWoBe3XhyQL1kEbhmGc6A8caDUxTFs5+ER09P0UGFWz2wrdsea4m/GLKiuC9iahM0c3L+nhWJMBkgA0UJWW5a7dm/lW8HrLJw6sQT9Ax/KAjtAFu5V/xw2JprHh7a8/u42QpUGXMhuDF8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622256; c=relaxed/simple;
	bh=7xxv6nIQW6y0nVofDWTgaDdHp0HdoXXxyMDg0XYYG8o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=J4Zod2j3p7cw3JMxqJ2Xk852LsBokn8t9lKzMpiJjUjiooab5gezoRLtAlPtIk/qjUjEzA5QNCDCUM9vfljg0CLqoA24bl0DGL8S69k94HWqxLxaEsHh0SIcaxxM15u9Fg/HtdMM5mlb1rIN6X1nMvLczJLJS/WzvWvUiR3+7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=she-devel.com; spf=pass smtp.mailfrom=she-devel.com; dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=gBuARP9V; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=she-devel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=she-devel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="gBuARP9V"
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id E16FD2091D8B;
	Sat, 11 Jan 2025 19:56:00 +0100 (CET)
Authentication-Results: ext-mx-out011.mykolab.com (amavis);
 dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-transfer-encoding:content-type:content-type:message-id
	:references:in-reply-to:subject:subject:from:from:date:date
	:mime-version:received:received:received; s=dkim20240523; t=
	1736621759; x=1738436160; bh=002uzwdVq2z9HmlHP4W2hSpP50GjYOnIm89
	ig7AE5tw=; b=gBuARP9VILBFZwcerQbSva2M3dqSJAjCNk+wSQgSK3pPAf5UTUE
	xgMMdYqQ5PDxBeEKUbYOf2hX4lL4eTonp195qneyjHV5bcKWCp/jy4Tw8kie7GmQ
	+3XZHhogWR+ti9LRQ2K5BiuC39ES8eLiEoQJiPRhMwtEWbqmfPLQ11JlPkHlTt1J
	XWDG3TOJBhRaEXIES23MfhGqMYy+pCzQ1Qa1bkhADsd9fKAg7Pz2yQmZ1n7+8U4P
	45rwDwcU0bSooAt8er/bSusOGZt2RvgDJkyseG26dMaORv4/LOLvY2din0+Zzdus
	kcZgUXcH8T9agkcLxET8JnZ+8X2jdMnSCTA==
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out011.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id PStAmuxGQ8bI; Sat, 11 Jan 2025 19:55:59 +0100 (CET)
Received: from int-mx011.mykolab.com (unknown [10.9.13.11])
	by mx.kolabnow.com (Postfix) with ESMTPS id 067252091D81;
	Sat, 11 Jan 2025 19:55:56 +0100 (CET)
Received: from int-subm015.mykolab.com (unknown [10.9.37.15])
	by int-mx011.mykolab.com (Postfix) with ESMTPS id 403733141C74;
	Sat, 11 Jan 2025 19:55:56 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 11 Jan 2025 10:55:55 -0800
From: Alison Chaiken <alison@she-devel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: corbet@lwn.net, gratian.crisan@ni.com, triegel@redhat.com,
 rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org, achaiken@aurora.tech
Subject: Re: [PATCH] Documentation: locking: update libc support status of PI
 futexes
In-Reply-To: <20250107153121.wAL-TfKG@linutronix.de>
References: <20241228181546.1315328-1-alison@she-devel.com>
 <20250107153121.wAL-TfKG@linutronix.de>
Message-ID: <619bfa123308eeb3a548fae36a3f9e4c@she-devel.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-07 07:31, Sebastian Andrzej Siewior wrote:
> On 2024-12-28 10:15:46 [-0800], alison@she-devel.com wrote:
>> From: Alison Chaiken <alison@she-devel.com>
>> 
>> Update the text of futex-requeue-pi.rst to explain that, because of a
>> conflict between POSIX requirements and ABI constraints, glibc does
>> not support requeueing of PI futexes.  Add some information about
>> librtpi, a library which provides an implementation of condition
>> variables which supports priority inheritance.
> 
> Are you sure? My memory is that glibc avoided using the internal mutex.
> The old problem should be gone and pthread_cond_signal() and
> pthread_cond_wait() should work.

Ignoring support for 64-bit time, the last substantive change to 
pthread_cond_wait() and pthread_cond_signal() was Torvald Riegel's  
commit ed19993b5b0d05d62cc883571519a67dae481a14 "New condvar 
implementation that provides stronger ordering guarantees," which fixed 
problems with waking of ineligible futex waiters and with ABA issues 
concerning the futex word.    What the patch does not do is made clear 
by the commit message:

      This condvar doesn't yet use a requeue optimization (ie, on a 
broadcast,
      waking just one thread and requeueing all others on the futex of 
the
      mutex supplied by the program).

What futex-requeue-pi.rst directs is

      In order to support PI-aware pthread_condvar's, the kernel needs to
      be able to requeue tasks to PI futexes.

Riegel and Darren Hart discussed Riegel's patch in at length at the 2016 
RT Summit:

     
https://wiki.linuxfoundation.org/realtime/events/rt-summit2016/schedule

The related glibc bug report by Darren may be found at

     https://sourceware.org/bugzilla/show_bug.cgi?id=11588

The last comment on the bug from 2017 is by Riegel:

     So far, there is no known solution for how to achieve PI support 
given the current constraints we have (eg, available futex operations, 
POSIX requirements, ...).

I ran the bug reproducer posted by Darren in Qemu and found that it did 
not fail.   I'm not sure if the result is valid given the peculiarities 
of Qemu, or whether I made some other mistake.

> 
>> Signed-off-by: Alison Chaiken <alison@she-devel.com>
> 
> Sebastian

-- Alison Chaiken
     Aurora Innovation
