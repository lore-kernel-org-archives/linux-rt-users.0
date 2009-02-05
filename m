From: Steven Rostedt <srostedt@redhat.com>
Subject: Re: [PATCH 2/3] powerpc: Make it possible to safely select
	CONFIG_FRAME_POINTER
Date: Wed, 04 Feb 2009 19:35:54 -0500
Message-ID: <1233794154.16878.20.camel@localhost.localdomain>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	 <20090204150838.GB30027@oksana.dev.rtsoft.ru>
	 <1233793889.4612.33.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:33312 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757230AbZBEAgk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Feb 2009 19:36:40 -0500
In-Reply-To: <1233793889.4612.33.camel@pasglop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 2009-02-05 at 11:31 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2009-02-04 at 18:08 +0300, Anton Vorontsov wrote:
> > Remove -fno-omit-frame-pointer flag from CFLAGS.
> > Remove -fno-omit-frame-pointer workarounds.
> 
> But what about -pg -requires -fno-omit-frame-pointer ?

I don't think it requires -fno-omit-frame-pointer. It is just
incompatible with -fomit-frame-pointer.

-- Steve


