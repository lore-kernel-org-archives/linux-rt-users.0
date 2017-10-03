From: "Hindman, Gavin" <gavin.hindman@intel.com>
Subject: Mainline-facing dev branch?
Date: Tue, 3 Oct 2017 17:29:47 +0000
Message-ID: <D5D6254030DBC644B6EE58B333BFBB1E9D80309D@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64774 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbdJCRaY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Oct 2017 13:30:24 -0400
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

As preempt_rt gets more widely adopted, hardware vendors (like us) are going to hit the issue of developing new features to mainline, but wanting to do pre-upstream testing and integration of those features against preempt_rt.

I assume there must be a preempt_rt branch somewhere that's tracking to mainline, rather than the public dev branch that's still on 4.11.  Is there interest among other partners, and would it be feasible, to make that branch public and keep it healthy?   The next question would obviously be how stable that branch could be considered at any point in time.

Thanks,
Gavin Hindman
Intel Open-Source Technology Center
