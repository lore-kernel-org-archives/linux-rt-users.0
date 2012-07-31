From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 05/12] slab: Prevent local lock deadlock
Date: Tue, 31 Jul 2012 15:11:42 -0400
Message-ID: <1343761902.27983.67.camel@gandalf.stny.rr.com>
References: <20120718223910.898476857@goodmis.org>
			 <20120718223957.856443728@goodmis.org> <5011DD9B.1030901@am.sony.com>
		 <1343697755.27983.17.camel@gandalf.stny.rr.com>
		 <50174158.4000408@am.sony.com>
	 <1343701935.27983.18.camel@gandalf.stny.rr.com>
	 <50182B44.8090100@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"chris.pringle@miranda.com" <chris.pringle@miranda.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:22785 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab2GaTLo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jul 2012 15:11:44 -0400
In-Reply-To: <50182B44.8090100@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-07-31 at 12:00 -0700, Frank Rowand wrote:

> > Yeah, my root fs is on the sdcard. Did you get this bug every time or
> > was it sporadic?
> 
> I get it every boot.

Can you try it with an SD card? I can set it up for nfs as well, but
that would take a bit of time.

-- Steve


