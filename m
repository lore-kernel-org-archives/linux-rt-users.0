From: Yong Zhang <yong.zhang@windriver.com>
Subject: Re: [PATCH V2] lockdep: reduce stack_trace usage
Date: Wed, 5 May 2010 09:31:20 +0800
Message-ID: <20100505013119.GA20236@windriver.com>
References: <alpine.LFD.2.00.1004222208310.3155@localhost>
 <20100423025850.GA21328@windriver.com>
 <alpine.LFD.2.00.1004230907050.4151@localhost>
 <1272009915.1646.25.camel@laptop>
 <w2v520f0cf11004230131i743c596emfd0e5b8870330a8b@mail.gmail.com>
 <20100423134044.GA2777@zhy-desktop>
 <20100504065711.GC10784@windriver.com>
 <1272977811.5605.183.camel@twins>
Reply-To: Yong Zhang <yong.zhang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Kacur <jkacur@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sven-Thorsten Dietrich <thebigcorporation@gmail.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yong Zhang <yong.zhang0@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:59796 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943Ab0EEBb5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 May 2010 21:31:57 -0400
Content-Disposition: inline
In-Reply-To: <1272977811.5605.183.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, May 04, 2010 at 02:56:51PM +0200, Peter Zijlstra wrote:
> Right, this looks like it ought to do as intended.
> 
> I added the below snipped because I know I'll fail to remember and that
> 'static' qualifier is fairly easy to miss.

OK. Thanks for your comments.

BTW, do you need me resend the patch with your comments in?

Thanks,
Yong
