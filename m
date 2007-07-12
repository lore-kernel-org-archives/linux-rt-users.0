From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: LAPIC broken on ferrari 1000
Date: Thu, 12 Jul 2007 21:26:50 +0200
Message-ID: <1184268410.12353.245.camel@chaos>
References: <200707121624.02169.joachim.deguara@amd.com>
	 <200707122040.37708.joachim.deguara@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Joachim Deguara <joachim.deguara@amd.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:55204 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753856AbXGLT0w (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 15:26:52 -0400
In-Reply-To: <200707122040.37708.joachim.deguara@amd.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Joachim,

On Thu, 2007-07-12 at 20:40 +0200, Joachim Deguara wrote:
> x86_64-apic-whitex86_64-apic-whitespace-comment-and-remove-unused-code.patch
> x86_64-timec-fix-whitespace-wreckage.patch
> #GOOD
> x86_64-consolidate-tsc-calibration.patch
> #Not Bisectable
> x86_64-preparatory-apic-set-lvtt.patch
> #Not Bisectable
> x86_64-convert-to-cleckevents.patch
> #BAD

I'm in the middle of making this bisectable.

	tglx
