From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: MIPS port
Date: Thu, 22 Oct 2009 11:40:33 +0200
Message-ID: <4AE02891.9070901@osadl.org>
References: <2cc9eb1b0910220223k6f04baemdf342e0182e48226@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: fabio <fabio7774@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:33722 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbZJVJuE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 05:50:04 -0400
In-Reply-To: <2cc9eb1b0910220223k6f04baemdf342e0182e48226@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Fabio,

> Can someone tell me how to gather this patch ?
>> RT_PREEMPT for mips/loongson2e is cleaned up and updated to 
>> patch-2.6.29.2-rt10.bz2, and a git branch 
>> linux-2.6.29-stable-mips-RT_PREEMPT is created for it. $ git clone
>> git://dev.lemote.com/rt4ls.git $ git checkout -b
>> linux-2.6.29-stable-mips-RT_PREEMPT --track 
>> origin/linux-2.6.29-stable-mips-RT_PREEMP
Can you wait a couple of days, until MIPS support will finally be
available in 2.6.31-rt?

A trace problem that prevented the patches from being included into
the most recent patch set appears to be solved now.

There is hope that MIPS support will make it into the next release
of the RT patches.

	Carsten.
