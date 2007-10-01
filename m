From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH RFC 3/9] RCU: Preemptible RCU
Date: Mon, 1 Oct 2007 15:09:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0710011249390.25942@alien.or.mcafeemobile.com>
References: <20070923173807.GA292@tv-sign.ru> <20070924001509.GG11123@linux.vnet.ibm.com>
 <20070926151351.GA328@tv-sign.ru> <20070927154652.GE16652@linux.vnet.ibm.com>
 <20070928144714.GA397@tv-sign.ru> <20070928185759.GC9153@linux.vnet.ibm.com>
 <20070930163102.GA374@tv-sign.ru> <Pine.LNX.4.64.0709301549160.19355@alien.or.mcafeemobile.com>
 <20071001013739.GB12494@linux.vnet.ibm.com>
 <Pine.LNX.4.64.0710011129440.25942@alien.or.mcafeemobile.com>
 <20071001192136.GC29100@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Oleg Nesterov <oleg@tv-sign.ru>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>, dipankar@in.ibm.com,
	josht@linux.vnet.ibm.com, tytso@us.ibm.com, dvhltc@us.ibm.com,
	tglx@linutronix.de, a.p.zijlstra@chello.nl, bunk@kernel.org,
	ego@in.ibm.com, srostedt@redhat.com
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([64.71.152.41]:35519 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbXJAWJT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Oct 2007 18:09:19 -0400
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S2517B2> for <linux-rt-users@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 1 Oct 2007 18:09:17 -0400
In-Reply-To: <20071001192136.GC29100@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 1 Oct 2007, Paul E. McKenney wrote:

> That would indeed be one approach that CPU designers could take to
> avoid being careless or sadistic.  ;-)

That'd be the easier (unique maybe) approach too for them, from an silicon 
complexity POV. Distinguishing between different CPUs stores once inside a 
shared store buffer, would require tagging them in some way. That'd defeat 
most of the pros of having a shared store buffer ;)



- Davide
