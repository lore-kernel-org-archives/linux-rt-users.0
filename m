From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 04/10] KVM: Sanitize cpuid
Date: Sun, 04 Dec 2011 11:53:45 -0500
Message-ID: <1323017625.19933.7.camel@pippen.local.home>
References: <20111203014641.165123482@goodmis.org>
	 <20111203014745.894197548@goodmis.org>
	 <alpine.LFD.2.02.1112031729570.2735@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, Avi Kivity <avi@redhat.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:53152 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab1LDQxu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 4 Dec 2011 11:53:50 -0500
In-Reply-To: <alpine.LFD.2.02.1112031729570.2735@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2011-12-03 at 17:31 +0100, Thomas Gleixner wrote:
> On Fri, 2 Dec 2011, Steven Rostedt wrote:
> 
> You forgot to pick the other fix, which makes the cpuid stuff really
> work: commit 02668b061 (KVM: fix XSAVE bit scanning (now properly))


Thanks, I'll add it for rc2.

-- Steve


