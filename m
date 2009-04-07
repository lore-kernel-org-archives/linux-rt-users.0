From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [Patch 0/2] TSC: fix incorrectly marked unstable TSC clock
Date: Tue, 7 Apr 2009 11:31:41 -0300
Message-ID: <20090407143141.GC1833@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:30263 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbZDGObr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2009 10:31:47 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2753881rvb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Apr 2009 07:31:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas,

I have backported to 2.6.24.7-rt27 a set of changes from upstream that
fixes several cases where TSC was erroneously marked unstable, mainly in
newer systems.

These changes are simple and pretty straightforward. I have been running
kernels with these changes for more than a month and in several different
boxes. Please check if these patches are of interest to carry in the
PREEMPT_RT patchset.

Regards,
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

