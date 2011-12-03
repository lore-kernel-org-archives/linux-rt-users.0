From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/10] KVM: Sanitize cpuid
Date: Sat, 3 Dec 2011 17:31:29 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1112031729570.2735@ionos>
References: <20111203014641.165123482@goodmis.org> <20111203014745.894197548@goodmis.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, Avi Kivity <avi@redhat.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50925 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab1LCQbb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 Dec 2011 11:31:31 -0500
In-Reply-To: <20111203014745.894197548@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2 Dec 2011, Steven Rostedt wrote:

You forgot to pick the other fix, which makes the cpuid stuff really
work: commit 02668b061 (KVM: fix XSAVE bit scanning (now properly))

Thanks,

	tglx

