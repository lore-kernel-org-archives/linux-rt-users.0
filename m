From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH 1/2][RFC] Add README_cyclicload
Date: Mon, 13 Aug 2012 12:41:30 -0700
Message-ID: <5029586A.2090308@am.sony.com>
References: <1343797643-10208-1-git-send-email-Priyanka.Jain@freescale.com> <AC83832D6324604BB08FAE5A33553F1907A926BA@039-SN2MPN1-012.039d.mgd.msft.net>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Srivastava Rajan-B34330 <B34330@freescale.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Jain Priyanka-B32167 <B32167@freescale.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:46552
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752380Ab2HMTl4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Aug 2012 15:41:56 -0400
In-Reply-To: <AC83832D6324604BB08FAE5A33553F1907A926BA@039-SN2MPN1-012.039d.mgd.msft.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/05/12 21:00, Jain Priyanka-B32167 wrote:
> Hi,
> 
> Waiting for the comments on this tool.
> 

< snip >

I would suggest not adding this to cyclictest, but to instead
make it a stand alone program.

The patch adds complexity to an already complex program.

-Frank

