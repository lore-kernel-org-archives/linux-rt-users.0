From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc: Make it possible to safely select
 CONFIG_FRAME_POINTER
Date: Thu, 05 Feb 2009 12:15:31 +1100
Message-ID: <1233796531.4612.35.camel__48771.7037475251$1233796849$gmane$org@pasglop>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	 <20090204150838.GB30027@oksana.dev.rtsoft.ru>
	 <1233793889.4612.33.camel@pasglop>
	 <1233794154.16878.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <srostedt@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48957 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759141AbZBEBTP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Feb 2009 20:19:15 -0500
In-Reply-To: <1233794154.16878.20.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2009-02-04 at 19:35 -0500, Steven Rostedt wrote:
> On Thu, 2009-02-05 at 11:31 +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2009-02-04 at 18:08 +0300, Anton Vorontsov wrote:
> > > Remove -fno-omit-frame-pointer flag from CFLAGS.
> > > Remove -fno-omit-frame-pointer workarounds.
> > 
> > But what about -pg -requires -fno-omit-frame-pointer ?
> 
> I don't think it requires -fno-omit-frame-pointer. It is just
> incompatible with -fomit-frame-pointer.

>From a quick test, you seem to be right.

Now the question of course is whether -pg will internally trigger
the bug for which we need the workaround tho...

Ben.

