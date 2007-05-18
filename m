From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: v2.6.21-rt3
Date: Fri, 18 May 2007 09:53:24 +0200
Message-ID: <1179474804.12981.57.camel@chaos>
References: <20070517194143.GA25394@elte.hu>
	 <2cf1ee820705180039l1d72005fq2169f8fa36e12377@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: emin ak <eminak71@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:48251 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755121AbXERHsU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 May 2007 03:48:20 -0400
In-Reply-To: <2cf1ee820705180039l1d72005fq2169f8fa36e12377@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-05-18 at 10:39 +0300, emin ak wrote:
> Hi,
> I have tried to compile -rt3 patch for ppc (mpc8540ads) and it failed
> with undefined referance errors on ppc/kernel/asm-offsets.c. Here is
> the compiler outputs:

arch/ppc is known to be broken. Does it even compile on 2.6.21 vanilla ?

	tglx
