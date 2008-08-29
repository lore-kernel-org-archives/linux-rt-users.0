From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] seqlock: serialize against writers
Date: Fri, 29 Aug 2008 18:22:16 +0200
Message-ID: <20080829162216.GW26610@one.firstfloor.org>
References: <20080829154237.1196.66825.stgit@dev.haskins.net> <87abevpzv7.fsf@basil.nowhere.org> <48B81F60.3080409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>,
	Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <gregory.haskins@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:44788 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbYH2QTe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Aug 2008 12:19:34 -0400
Content-Disposition: inline
In-Reply-To: <48B81F60.3080409@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Im running it on a x86_64 box as we speak.  How can I tell if there is a
> certain mode that is permitting this?

If the boot up says you're running with PMtimer then it uses the fallback
(usually happens on pre Fam10h AMD boxes). A typical Intel box
would use the faster ring 3 only TSC path and then explode with your
change I bet. 

Or step with gdb through gettimeofday() and see if it does a syscall.

-Andi
